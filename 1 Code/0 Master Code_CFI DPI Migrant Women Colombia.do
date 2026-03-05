/*------------------------------------------------------------------------------*
| Title: 			Master code													|
| Project: 			CFI - Digital Public Infrastructure Migrant Women Colombia	|
| Authors:			Jorge Zavala 												|
| 					  									                        |
|																				|
| Description:		This .do imports, cleans and prepares data for analysis 	|
|                                                                               |
| Date created: 09/02/2026			 					                        |										          
|																			    |
| Version: Stata 16.                        							 	    |
*-------------------------------------------------------------------------------*/

/*--------------------------*
*           INDEX           *
*---------------------------*

	I. Import and rename variables
	II. Reshape, clean data, label variables, label values
	III. Create analysis data

*-------------------------------------------------------------------------------*/


*-----------------------------------*
**#		0. Setup and directory		*
*-----------------------------------*
	clear all
	clear mata
	set more off
	version 16
	set seed 6427961
	

*-----------------------------------*
**#		1. Define paths				*
*-----------------------------------*
* check what your username is in Stata by typing "di c(username)"
else if "`c(username)'" == "jzava" { // Jorge's personal laptop
    global dropbox 	"C:\Users\jzava\Dropbox (Personal)\Research & Consulting\1 Research\DPI Inclusion Migrant Women Colombia"
	global git 		"C:\Users\jzava\Documents\GitHub\CFI-DPI-Migrant-Women-Colombia"
	local os        "windows"
}

else if "`c(username)'" == "USUARIO" { // Sarita's personal laptop
    global dropbox 	"D:\Dropbox\DPI Inclusion Migrant Women Colombia"
	global git 		"C:\Users\USUARIO\OneDrive - pucp.edu.pe\Documentos\GitHub\CFI-DPI-Migrant-Women-Colombia"
	local os        "windows"
}


* Set globals for sub-folders 
	global input_dir 	"${dropbox}/2 Data"
	global code_dir 	"${git}/1 Code"
	global output_dir 	"${git}/2 Output"
	
	sysdir set PLUS "${code_dir}/ado"


* Install packages 
	local user_commands	colrspace palettes heatplot reclink repkit ietoolkit iefieldkit winsor sumstats estout keeporder grc1leg2 outreg2 //Add required user-written commands

	foreach command of local user_commands {
	   capture which `command'
	   if _rc == 111 {
		   ssc install `command'
	   }
	}
	* Install plotplain scheme for graphs formatting
	net install gr0070, from(http://www.stata-journal.com/software/sj17-3)		

	* Run do files 
	* Switch to 0/1 to not-run/run do-files 
	*if (0) do "${code_dir}/1 Data Preparation_IFC Inclusion financiera Colombia.do"
	*if (0) do "${code_dir}/2 Data Analysis_IFC Inclusion financiera Colombia.do"
