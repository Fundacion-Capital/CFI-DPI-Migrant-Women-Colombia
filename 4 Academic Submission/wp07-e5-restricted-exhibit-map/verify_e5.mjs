// File-only audit: native aggregate identities and documentary boundaries, not estimation.
import fs from 'node:fs/promises';
import path from 'node:path';
import crypto from 'node:crypto';
import assert from 'node:assert/strict';
const root = process.cwd();
const folder = '4 Academic Submission/wp07-e5-restricted-exhibit-map';
const privateFolder = '4 Academic Submission/audit-local/intake/package-e-restricted-20261108/e5-exhibit-map-f77ac2b';
const run = '4 Academic Submission/audit-local/intake/package-e-restricted-20261108/e4-restricted-scope-c49b157/run';
const read = p => fs.readFile(path.join(root, p), 'utf8');
const json = async p => JSON.parse(await read(p));
const fingerprint = async p => {
  const bytes = await fs.readFile(path.join(root, p));
  return { path: p, bytes: bytes.length, sha256: crypto.createHash('sha256').update(bytes).digest('hex') };
};
// These five source emitters write fixed, unquoted comma-separated fields only.
const csv = async name => {
  const lines = (await read(run + '/' + name)).trimEnd().split(/\r?\n/);
  const header = lines.shift().split(',');
  return lines.map((line, i) => {
    assert(!line.includes('"') && line.split(',').length === header.length, name + ' schema');
    return { native: Object.fromEntries(header.map((key, j) => [key, line.split(',')[j]])), line: i + 2 };
  });
};
const inputs = await json(folder + '/INPUTS.json');
const map = await json(privateFolder + '/NUMERICAL_MAP.json');
const native = {};
for (const name of ['e4_model_status.csv', 'e4_primary_tests.csv', 'e4_probabilities.csv', 'e4_native_matrices.csv', 'e4_support.csv']) native[name] = await csv(name);
const expected = [
  ['models', 'e4_model_status.csv', native['e4_model_status.csv']],
  ['primary_tests', 'e4_primary_tests.csv', native['e4_primary_tests.csv']],
  ['probabilities', 'e4_probabilities.csv', native['e4_probabilities.csv']],
  ['coefficients', 'e4_native_matrices.csv', native['e4_native_matrices.csv'].filter(x => x.native.operation === 'fit' && x.native.matrix === 'e4_B')]
];
function verifyMap(candidate) {
  assert.deepEqual(candidate.model_order, ['R0_E4', 'D0_E4', 'R1_E4', 'D1_E4', 'R0C_E4']);
  assert.deepEqual(candidate.focal_order, ['wp07_iat3', 'wp07_iadt2', 'wp07_iaff2']);
  for (const [group, file, rows] of expected) {
    assert.equal(candidate[group].length, rows.length, group + ' complete coverage');
    candidate[group].forEach((row, i) => {
      assert.deepEqual(row.native, rows[i].native, group + ' native string tokens');
      assert.equal(row.source.line, rows[i].line);
      assert.equal(row.source.path, run + '/' + file);
      assert.equal(row.source.sha256, candidate.source_ledgers.find(x => x.path === row.source.path).sha256);
    });
  }
  for (const row of candidate.probabilities) {
    const p = row.native;
    const difference = p.record === 'higher_minus_lower';
    assert.equal(p.units, difference ? 'percentage_points' : 'probability');
    assert.equal(p.status, 'AVAILABLE_POINTWISE_WORKING_VCE');
    assert.equal(row.mask, candidate.models.find(x => x.native.model === p.model).mask);
    assert.deepEqual(row.denominator_source, candidate.models.find(x => x.native.model === p.model).source);
    assert.deepEqual(row.exhibits, difference ? (['R0_E4', 'D0_E4'].includes(p.model) ? ['QF1', 'QS1'] : ['QS1']) : ['QS2']);
    const matrix = difference ? 'e4_DT' : 'e4_MT';
    const column = p.record === 'higher' ? '2' : '1';
    for (const [field, nativeRow] of [['estimate', 'b'], ['se', 'se'], ['ll', 'll'], ['ul', 'ul']]) {
      const cells = native['e4_native_matrices.csv'].filter(x => x.native.model === p.model && x.native.operation === p.focal && x.native.matrix === matrix && x.native.row_name === nativeRow && x.native.column === column);
      assert.equal(cells.length, 1);
      // Only a native-capture identity check; no SE, CI or test is newly estimated.
      assert(Math.abs(Number(p[field]) - Number(cells[0].native.value) * (difference ? 100 : 1)) < 1e-12);
    }
  }
  assert.equal(candidate.primary_tests.length, 6);
  assert(candidate.primary_tests.every(x => x.family_size === 6 && x.exhibits.join() === 'QT2'));
  assert.equal(candidate.coefficients.filter(x => x.reference).length, 12);
  assert.equal(candidate.claim_rules.cross_outcome_difference_test, false);
  assert.equal(candidate.claim_rules.new_coefficient_SE_or_CI, false);
  assert.equal(candidate.claim_rules.public_release, false);
  assert.equal(candidate.claim_rules.C2, 'HOLD');
}
verifyMap(map);
for (const source of map.source_ledgers) assert.deepEqual(await fingerprint(source.path), source);
assert.deepEqual(expected.map(x => x[2].length), [5, 6, 45, 74]);
assert.equal(native['e4_native_matrices.csv'].length, 2262);
assert.equal(native['e4_support.csv'].length, 186);
let negativeControls = 0;
for (const mutate of [
  x => x.probabilities.pop(),
  x => x.probabilities[0].native.units = 'percentage_points',
  x => x.probabilities[0].source.line++,
  x => x.primary_tests[0].native.p_holm = '0',
  x => x.probabilities[2].native.estimate = Number(x.probabilities[2].native.estimate).toFixed(2),
  x => x.models[0].native.estimator_n = '423',
  x => x.probabilities[0].mask = 'e4_mask_common',
  x => x.claim_rules.C2 = 'RELEASED'
]) {
  const changed = structuredClone(map);
  mutate(changed);
  assert.throws(() => verifyMap(changed));
  negativeControls++;
}
const navigation = inputs.planned_mutable_files;
let preserved = 0;
for (const source of inputs.sources) {
  const target = navigation.includes(source.path) ? privateFolder + '/' + path.basename(source.path) : source.path;
  const actual = await fingerprint(target);
  assert.equal(actual.bytes, source.bytes, source.path);
  assert.equal(actual.sha256, source.sha256, source.path);
  preserved++;
}
const draft = await read(privateFolder + '/RESULTS_DRAFT.md');
for (const model of map.model_order) for (const focal of map.focal_order) assert(draft.includes('C-' + model + '-' + focal));
assert.equal(new Set(map.probabilities.map(x => [x.native.model, x.native.focal, x.native.record].join('|'))).size, 45);
const spec = await read(folder + '/EXHIBIT_SPEC.md');
for (const slot of ['QT1', 'QF1', 'QT2', 'QS1', 'QS2', 'QS3']) assert(spec.includes('| ' + slot + ' /'));
const oldRegister = (await read('4 Academic Submission/wp07-e4-restricted-execution/TASK_REGISTER.csv')).trimEnd().split(/\r?\n/);
const newRegister = (await read(folder + '/TASK_REGISTER.csv')).trimEnd().split(/\r?\n/);
assert.equal(newRegister.length, 42);
assert.deepEqual(oldRegister.filter((line, i) => line !== newRegister[i]).map(line => line.split(',')[0]), ['"E.5"']);
const exactNumericTokens = [...map.probabilities.flatMap(x => ['estimate', 'se', 'll', 'ul'].map(k => x.native[k].trim())), ...map.primary_tests.flatMap(x => [x.native.p_raw, x.native.p_holm])].filter(x => x.length > 8);
for (const file of await fs.readdir(path.join(root, folder))) {
  const text = await read(folder + '/' + file);
  for (const token of exactNumericTokens) assert(!text.includes(token), 'Unexpected restricted numerical token in ' + file);
}
for (const file of ['0 Master.do', '1 Data preparation.do', '2 Analysis.do']) {
  const source = await read('1 Code/academic/' + file);
  assert.equal(source.split(/\r?\n/)[6], 'exit 198');
}
assert(/exit 198\r?\n\* BEGIN E4 ESTIMATION/.test(await read('1 Code/academic/2 Analysis.do')));
const pointer = await json('4 Academic Submission/00_meta/current_workplan.json');
assert.equal(pointer.appendix_c2, 'HOLD');
assert.equal(pointer.participant_loads_newly_authorized, false);
assert.equal(pointer.fits_newly_authorized, 0);
assert.equal(pointer.release_authorized, false);
assert.equal(pointer.latest_source_handoff, folder + '/README.md');
assert.equal(pointer.e5_exhibits_rendered, 0);
console.log(JSON.stringify({ result: 'PASS_RESTRICTED_MAP_IDENTITIES_AND_PRESERVATION_ONLY', predecessor_entries: preserved, immutable_predecessors: preserved - navigation.length, navigation_beforeimages: navigation.length, models: 5, tests: 6, probability_records: 45, fitted_coefficient_records: 74, native_matrix_cells: 2262, negative_controls_rejected: negativeControls, new_Stata_calls: 0, participant_or_model_loads: 0, fits: 0, rendered_exhibits: 0, C2: 'HOLD' }));
