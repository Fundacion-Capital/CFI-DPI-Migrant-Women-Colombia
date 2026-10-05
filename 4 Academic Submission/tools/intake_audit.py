"""Read-only archive/OOXML intake. No statistical analysis, rendering, or cloud writes.

Outputs contain unpublished/restricted text and MUST stay in ignored audit-local.
Use --self-test for the parser/check; otherwise supply --repo --dropbox --onedrive.
"""
import argparse
import csv
import difflib
import hashlib
import json
import posixpath
import re
import subprocess
from collections import Counter
from datetime import datetime, timezone
from pathlib import Path
from xml.etree import ElementTree as ET
from zipfile import BadZipFile, ZipFile

W = "{http://schemas.openxmlformats.org/wordprocessingml/2006/main}"
M = "{http://schemas.openxmlformats.org/officeDocument/2006/math}"
NS = {"w": W[1:-1]}
R = "{http://schemas.openxmlformats.org/officeDocument/2006/relationships}"
A = "{http://schemas.openxmlformats.org/drawingml/2006/main}"
V = "{urn:schemas-microsoft-com:vml}"


def sha256(path):
    with path.open("rb") as handle:
        return hashlib.file_digest(handle, "sha256").hexdigest().upper()


def visible_text(node):
    """Current-view text; retain inserted text/math, exclude tracked deletions."""
    if node.tag == W + "del":
        return ""
    if node.tag in {W + "t", M + "t"}:
        return node.text or ""
    if node.tag == W + "tab":
        return "\t"
    if node.tag in {W + "br", W + "cr"}:
        return "\n"
    return "".join(visible_text(child) for child in node)


def parse_blocks(xml, styles=None):
    styles = styles or {}
    root = ET.fromstring(xml)
    body = root.find("w:body", NS)
    if body is None:
        raise ValueError("No OOXML document body")
    blocks = []
    for i, child in enumerate(body, 1):
        if child.tag == W + "sectPr":
            continue
        sid = child.find("w:pPr/w:pStyle", NS)
        style = sid.get(W + "val", "") if sid is not None else ""
        direct = child.find("w:pPr/w:outlineLvl", NS)
        level = direct.get(W + "val") if direct is not None else styles.get(style, {}).get("level")
        cells = [[visible_text(c).strip() for c in row.findall("w:tc", NS)]
                 for row in child.findall("w:tr", NS)] if child.tag == W + "tbl" else []
        text = "\n".join(" | ".join(row) for row in cells) if cells else visible_text(child).strip()
        blocks.append({"id": f"B{i:05d}", "kind": "table" if cells or child.tag == W + "tbl" else "paragraph",
                       "style": style, "heading_level": level, "text": text, "cells": cells,
                       "math_count": len(child.findall(".//" + M + "oMath")),
                       "drawings": len(child.findall(".//w:drawing", NS)),
                       "legacy_pictures": len(child.findall(".//w:pict", NS)),
                       "textboxes": len(child.findall(".//w:txbxContent", NS)),
                       "caption_candidate": bool(re.match(r"^(Table|Figure|Graph|Exhibit)\s+[A-Z]?\d", text, re.I))})
    return blocks


def docx_records(path):
    with ZipFile(path) as z:
        parts = {n: hashlib.sha256(z.read(n)).hexdigest().upper() for n in z.namelist() if not n.endswith("/")}
        styles = {}
        if "word/styles.xml" in parts:
            for s in ET.fromstring(z.read("word/styles.xml")).findall("w:style", NS):
                name, outline, parent = (s.find(p, NS) for p in ("w:name", "w:pPr/w:outlineLvl", "w:basedOn"))
                styles[s.get(W + "styleId")] = {"name": name.get(W + "val") if name is not None else "",
                                               "level": outline.get(W + "val") if outline is not None else None,
                                               "parent": parent.get(W + "val") if parent is not None else None}
            for s in styles.values():
                parent, seen = s.get("parent"), set()
                while s["level"] is None and parent in styles and parent not in seen:
                    seen.add(parent)
                    s["level"] = styles[parent]["level"]
                    parent = styles[parent].get("parent")
        xml = z.read("word/document.xml")
        root = ET.fromstring(xml)
        blocks = parse_blocks(xml, styles)
        extra = {n: visible_text(ET.fromstring(z.read(n))) for n in parts
                 if re.match(r"word/(footnotes|endnotes|comments|header\d+|footer\d+)\.xml$", n)}
        links = []
        for n in parts:
            if n.endswith(".rels"):
                for rel in ET.fromstring(z.read(n)):
                    if rel.get("TargetMode") == "External":
                        links.append({"part": n, **rel.attrib})
        cached = {}
        if "docProps/app.xml" in parts:
            cached = {c.tag.split("}")[-1]: c.text for c in ET.fromstring(z.read("docProps/app.xml"))
                      if c.tag.split("}")[-1] in {"Pages", "Words", "Paragraphs"}}
        metrics = {"blocks": len(blocks), "tables": sum(b["kind"] == "table" for b in blocks),
                   "body_words_approx": sum(len(b["text"].split()) for b in blocks if b["kind"] != "table"),
                   "table_words_approx": sum(len(b["text"].split()) for b in blocks if b["kind"] == "table"),
                   "heading_blocks": sum(b["heading_level"] is not None for b in blocks),
                   "media_parts": sum(n.startswith("word/media/") for n in parts),
                   "drawings": sum(b["drawings"] for b in blocks),
                   "legacy_pictures": sum(b["legacy_pictures"] for b in blocks),
                   "textboxes": sum(b["textboxes"] for b in blocks),
                   "math_objects": sum(b["math_count"] for b in blocks),
                   "tracked_insertions": len(root.findall(".//w:ins", NS)),
                   "tracked_deletions": len(root.findall(".//w:del", NS)),
                   "comment_anchors": len(root.findall(".//w:commentRangeStart", NS)),
                   "external_relationships": len(links), "cached_properties_NOT_rendered": cached}
        return {"source": str(path), "sha256": sha256(path), "metrics": metrics, "blocks": blocks,
                "ancillary_text": extra, "external_relationships": links, "part_hashes": parts}


def compare_docs(a, b):
    # ponytail: paragraph alignment is lexical, not semantic; disposition requires human review.
    aa, bb = ([re.sub(r"\s+", " ", x["text"]).strip() for x in d["blocks"]] for d in (a, b))
    changes = [{"change": tag, "a": [x["id"] for x in a["blocks"][i:j]],
                "b": [x["id"] for x in b["blocks"][k:l]],
                "a_text": aa[i:j], "b_text": bb[k:l], "disposition": "UNREVIEWED"}
               for tag, i, j, k, l in difflib.SequenceMatcher(None, aa, bb, autojunk=False).get_opcodes() if tag != "equal"]
    pa, pb = a["part_hashes"], b["part_hashes"]
    return {"a_sha256": a["sha256"], "b_sha256": b["sha256"], "text_changes": changes,
            "parts_only_a": sorted(pa.keys() - pb.keys()), "parts_only_b": sorted(pb.keys() - pa.keys()),
            "parts_changed": sorted(k for k in pa.keys() & pb.keys() if pa[k] != pb[k]),
            "unique_media_hashes_a": sorted(set(v for k, v in pa.items() if k.startswith("word/media/")) - set(v for k, v in pb.items() if k.startswith("word/media/"))),
            "unique_media_hashes_b": sorted(set(v for k, v in pb.items() if k.startswith("word/media/")) - set(v for k, v in pa.items() if k.startswith("word/media/")))}


def inventory(root, label, files):
    records = []
    for path in files:
        r = {"scope": label, "relative_path": path.relative_to(root).as_posix(), "sha256": "",
             "bytes": "", "modified_utc_NOT_event_date": "", "status": "", "review_status": "NOT_REVIEWED"}
        try:
            if not path.resolve().is_relative_to(root.resolve()):
                raise ValueError("File resolves outside scoped archive")
            s = path.stat()
            r.update(bytes=s.st_size, modified_utc_NOT_event_date=datetime.fromtimestamp(s.st_mtime, timezone.utc).isoformat())
            attrs = getattr(s, "st_file_attributes", 0)
            if attrs & (0x1000 | 0x40000 | 0x400000):
                r["status"] = "CLOUD_PLACEHOLDER_NOT_HYDRATED"
            else:
                r.update(sha256=sha256(path), status="HASHED")
        except (OSError, ValueError) as err:
            r["status"] = f"UNREADABLE:{type(err).__name__}"
        records.append(r)
    return records


def write_json(path, obj):
    path.write_text(json.dumps(obj, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")


def locator_indexes(doc, xml, rel_xml):
    """Candidate locators only: no number verification, caption adjudication, or rendering."""
    # ponytail: lexical numbers include dates/citations/labels; classify against outputs before treating as claims.
    numbers = []
    for block in doc["blocks"]:
        for i, match in enumerate(re.finditer(r"(?<!\w)[−-]?(?:\d+(?:[.,]\d+)*|\.\d+)\s*%?", block["text"]), 1):
            numbers.append({"id": f"{block['id']}-N{i:03d}", "block": block["id"],
                            "number_text": match.group().strip(), "char_start": match.start(),
                            "char_end": match.end(), "kind": block["kind"],
                            "context": block["text"][max(0, match.start()-100):match.end()+100],
                            "source_sha256": doc["sha256"], "status": "UNREVIEWED_CANDIDATE"})
    rels = {rel.get("Id"): rel.attrib for rel in ET.fromstring(rel_xml)}
    body = ET.fromstring(xml).find("w:body", NS)
    media = []
    for i, block in enumerate(body, 1):
        for node in block.iter():
            if node.tag not in {A + "blip", V + "imagedata"}:
                continue
            for attribute in (R + "embed", R + "link", R + "id"):
                rid = node.get(attribute)
                if not rid:
                    continue
                rel = rels.get(rid, {})
                external = rel.get("TargetMode") == "External"
                target = rel.get("Target", "")
                part = target if external else posixpath.normpath("word/" + target) if target else ""
                nearby = [b["id"] for b in doc["blocks"] if abs(int(b["id"][1:])-i) <= 4 and b["caption_candidate"]]
                media.append({"block": f"B{i:05d}", "relationship_id": rid, "target": part,
                              "binding": "EXTERNAL_NOT_FETCHED" if external else "EMBEDDED" if part in doc["part_hashes"] else "UNRESOLVED",
                              "media_sha256": "" if external else doc["part_hashes"].get(part, ""),
                              "nearby_caption_candidates_NOT_confirmed": ";".join(nearby),
                              "source_sha256": doc["sha256"], "render_validation": "NOT_PERFORMED"})
    return numbers, media


def main(args):
    repo, db, od = (p.resolve(strict=True) for p in (args.repo, args.dropbox, args.onedrive))
    out = repo / "4 Academic Submission" / "audit-local" / "intake"
    if subprocess.check_output(["git", "check-ignore", "--no-index", str(out / "privacy-probe.txt")], cwd=repo, text=True).strip() == "":
        raise ValueError("Private output location is not ignored")
    out.mkdir(parents=True, exist_ok=True)
    pin = subprocess.check_output(["git", "rev-parse", "HEAD"], cwd=repo, text=True).strip()
    tracked = subprocess.check_output(["git", "ls-tree", "-rz", "--name-only", pin], cwd=repo).decode("utf-8").split("\0")
    rows = inventory(repo, "git", [repo / p for p in tracked if p])
    for label, root in (("dropbox", db), ("onedrive", od)):
        rows.extend(inventory(root, label, sorted(p for p in root.rglob("*") if p.is_file())))
    with (out / "source_manifest.csv").open("w", newline="", encoding="utf-8") as f:
        w = csv.DictWriter(f, fieldnames=list(rows[0]))
        w.writeheader()
        w.writerows(rows)
    docs = []
    seen = {}
    errors = []
    for row in rows:
        if not row["relative_path"].lower().endswith(".docx") or row["status"] != "HASHED":
            continue
        if Path(row["relative_path"]).name.startswith("~$"):
            errors.append({"scope": row["scope"], "path": row["relative_path"], "error": "OFFICE_LOCK_NOT_DOCUMENT"})
            continue
        if row["sha256"] in seen:
            docs.append({**row, "extraction": seen[row["sha256"]], "hash_duplicate": True})
            continue
        root = {"git": repo, "dropbox": db, "onedrive": od}[row["scope"]]
        try:
            d = docx_records(root / row["relative_path"])
            stem = "D" + row["sha256"][:12]
            write_json(out / (stem + ".json"), d)
            (out / (stem + ".md")).write_text("\n\n".join(f"[{b['id']}] ({b['kind']}; style={b['style']}; level={b['heading_level']})\n{b['text']}" for b in d["blocks"]), encoding="utf-8")
            seen[row["sha256"]] = stem
            docs.append({**row, "extraction": stem, "hash_duplicate": False, "metrics": d["metrics"]})
        except (OSError, ValueError, ET.ParseError, BadZipFile) as err:
            errors.append({"scope": row["scope"], "path": row["relative_path"], "error": type(err).__name__})
    candidates = sorted((db / "6 Working paper").glob("Cardozo & Zavala*.docx"))
    if len(candidates) != 2:
        raise ValueError("Expected exactly two full legacy candidates; review the intake scope")
    a_path = next(p for p in candidates if not p.stem.endswith(" - Copia"))
    b_path = next(p for p in candidates if p.stem.endswith(" - Copia"))
    a, b = docx_records(a_path), docx_records(b_path)
    if a["sha256"] != "99919BBE239C5CE319B986B6B18C534DB02D6E3CB5469FF55EDFC1294CAFC76F":
        raise ValueError("Legacy A differs from the author-selected foundation; stop for a new source-authority decision")
    with ZipFile(a_path) as z:
        numbers, media = locator_indexes(a, z.read("word/document.xml"), z.read("word/_rels/document.xml.rels"))
    for filename, index in (("legacy_numeric_candidates.csv", numbers), ("legacy_media_map.csv", media)):
        if index:
            with (out / filename).open("w", newline="", encoding="utf-8") as f:
                writer = csv.DictWriter(f, fieldnames=list(index[0]))
                writer.writeheader()
                writer.writerows(index)
    comparison = compare_docs(a, b)
    write_json(out / "legacy_comparison.json", comparison)
    write_json(out / "document_inventory.json", {"documents": docs, "errors": errors})
    history = subprocess.check_output(["git", "log", "--all", "--date=iso-strict", "--format=%H%x09%aI%x09%cI%x09%s", "--name-status"], cwd=repo, text=True, encoding="utf-8")
    (out / "git_history.txt").write_text(history, encoding="utf-8")
    summary = {"captured_utc": datetime.now(timezone.utc).isoformat(), "repository_commit": pin,
               "manifest_rows": len(rows), "by_scope": dict(Counter(r["scope"] for r in rows)),
               "readability": dict(Counter(r["status"] for r in rows)),
               "unique_hashed_files": len({r["sha256"] for r in rows if r["sha256"]}),
               "docx_occurrences": len(docs), "unique_docx_extracted": len(seen), "extraction_errors": errors,
               "legacy_a": a["metrics"], "legacy_b": b["metrics"],
               "legacy_text_change_runs": len(comparison["text_changes"]),
               "legacy_changed_parts": len(comparison["parts_changed"]),
               "legacy_numeric_candidates_NOT_verified": len(numbers), "legacy_media_bindings_NOT_rendered": len(media),
               "scientific_review": "NOT_COMPLETED", "rendered_page_validation": "NOT_PERFORMED"}
    write_json(out / "intake_summary.json", summary)
    print(json.dumps(summary, ensure_ascii=False, indent=2))


def self_test():
    xml = f'<w:document xmlns:w="{W[1:-1]}" xmlns:m="{M[1:-1]}" xmlns:a="{A[1:-1]}" xmlns:r="{R[1:-1]}"><w:body><w:p><w:r><w:t>A &amp; B</w:t><w:tab/></w:r><w:del><w:r><w:t>REMOVED</w:t></w:r></w:del><w:ins><w:r><w:t>added</w:t></w:r></w:ins><m:oMath><m:r><m:t>x</m:t></m:r></m:oMath><w:drawing><a:blip r:embed="r1" r:link="r2"/></w:drawing></w:p><w:tbl><w:tr><w:tc><w:p><w:r><w:t>42</w:t></w:r></w:p></w:tc></w:tr></w:tbl><w:sectPr/></w:body></w:document>'
    b = parse_blocks(xml.encode())
    assert len(b) == 2 and b[0]["text"] == "A & B\taddedx" and b[0]["math_count"] == 1
    assert b[1]["cells"] == [["42"]] and b[1]["kind"] == "table"
    doc = {"blocks": b, "part_hashes": {"word/media/a.png": "hash"}, "sha256": "test"}
    assert compare_docs(doc, doc)["text_changes"] == []
    rel = b'<Relationships><Relationship Id="r1" Target="media/a.png"/><Relationship Id="r2" Target="https://example.com/a.png" TargetMode="External"/></Relationships>'
    numbers, media = locator_indexes(doc, xml.encode(), rel)
    assert len(numbers) == 1 and numbers[0]["block"] == "B00002" and numbers[0]["number_text"] == "42"
    assert len(media) == 2 and media[0]["media_sha256"] == "hash" and media[1]["binding"] == "EXTERNAL_NOT_FETCHED"
    print("PASS: current-view text, math, cells, stable blocks, comparison, numerical locators, embedded/external media")


if __name__ == "__main__":
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument("--self-test", action="store_true")
    p.add_argument("--repo", type=Path)
    p.add_argument("--dropbox", type=Path)
    p.add_argument("--onedrive", type=Path)
    a = p.parse_args()
    if a.self_test:
        self_test()
    elif all((a.repo, a.dropbox, a.onedrive)):
        main(a)
    else:
        p.error("Supply --self-test or all three scoped roots")
