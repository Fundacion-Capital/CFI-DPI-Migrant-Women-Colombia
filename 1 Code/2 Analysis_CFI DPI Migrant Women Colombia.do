/*------------------------------------------------------------------------------*
| Title: 			Data Preparation code										|
| Project: 			CFI - Digital Public Infrastructure Migrant Women Colombia	|
| Authors:			Jorge Zavala 												|
| 					  									                        |
|																				|
| Description:		Imports and aggregates "CFI"			 					|
|                                                                               |
| Date created: 09/02/2026			 					                        |										          
|																			    |
| Version: Stata 16	                        							 	    |
*-------------------------------------------------------------------------------*/


/*--------------------------*
*           INDEX           *
*---------------------------*

	I.   Análisis descriptivo
	II.  Análisis con regresiones
	III. Análisis de cluster


*---------------------------*
*		0. Data intake		*
*---------------------------*/

	import excel "${input_dir}\1 Raw\CFI DPI Encuesta Cuantitativa_WIDE.xlsx", ///
	sheet("data") firstrow


*---------------------------------------*
*		I. Análisis descriptivo  		*
*---------------------------------------*


*-------------------------------------------*
*		II. Análisis con regresiones  		*
*-------------------------------------------*



*---------------------------------------*
*		III. Análisis de cluster   		*
*---------------------------------------*




