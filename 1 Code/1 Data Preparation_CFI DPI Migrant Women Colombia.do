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

	I. Data intake
	II. Label variables y values
	III. Data Cleaning
	IV. Construct variables for analysis


*---------------------------*
*		I. Data intake		*
*---------------------------*/

	import excel "${input_dir}\1 Raw\CFI DPI Encuesta Cuantitativa_WIDE.xlsx", ///
	sheet("data") firstrow


	* consolidate unique ID into "key" variable
	replace key=instanceID if KEY==""
	drop instanceID

	* label variables
	label variable key "Unique submission ID"
	cap label variable submissiondate "Date/time submitted"
	cap label variable formdef_version "Form version used on device"
	cap label variable review_status "Review status"
	cap label variable review_comments "Comments made during review"
	cap label variable review_corrections "Corrections made during review"

*-------------------------------------------*
*		II. Label variables y values		*
*-------------------------------------------*

	*-----------------*
	*    Bloque 0     *
	*-----------------*

	label variable consent "¿Le gustaría continuar y participar en esta encuesta?"
	note consent: "¿Le gustaría continuar y participar en esta encuesta?"
	label define consent 1 "Sí" 0 "No" 98 "Prefiero no responder"
	label values consent consent

	label variable enumerator "Nombre completo de la encuestadora"
	note enumerator: "Nombre completo de la encuestadora"


	*-------------------------------*
	*    Bloque 1 : Elegibilidad    *
	*-------------------------------*

	label variable q1 "¿Con cuál de las siguientes opciones se identifica mejor?"
	note q1: "¿Con cuál de las siguientes opciones se identifica mejor?"
	label define q1 1 "Mujer" 2 "Hombre" 3 "No binario" 98 "Prefiero no responder"
	label values q1 q1

	label variable q2 "¿De qué país es su nacionalidad principal?"
	note q2: "¿De qué país es su nacionalidad principal?"

	label variable q3 "Lugar de residencia en Colombia"
	note q3: "Lugar de residencia en Colombia"
	label define q3 1 "Bogotá" 2 "Cali" 3 "Medellin" 4 "Soacha"
	label values q3 q3

	label variable q4 "¿Cuál es su edad en años cumplidos?"
	note q4: "¿Cuál es su edad en años cumplidos?"

	label variable q5 "En los últimos 12 meses, ¿usted o alguien en su hogar ha recibido dinero del ext"
	note q5: "En los últimos 12 meses, ¿usted o alguien en su hogar ha recibido dinero del exterior (remesas)?"
	label define q5 1 "Sí" 0 "No" 98 "Prefiero no responder"
	label values q5 q5

	label variable q6 "¿Es usted la principal receptora o gestora del dinero de remesas que recibe su h"
	note q6: "¿Es usted la principal receptora o gestora del dinero de remesas que recibe su hogar?"
	label define q6 1 "Sí" 0 "No" 98 "Prefiero no responder"
	label values q6 q6


	*---------------------------------------------------------------*
	*    Bloque 2 : Sección B. Caracterización del la encuestada    *
	*---------------------------------------------------------------*

	label variable q2_1 "¿En qué año llegó a vivir a Colombia por primera vez?"
	note q2_1: "¿En qué año llegó a vivir a Colombia por primera vez?"

	label variable q2_2 "¿Cuál es el último nivel de estudios que completó?"
	note q2_2: "¿Cuál es el último nivel de estudios que completó?"
	label define q2_2 1 "Sin estudios" 2 "Primaria incompleta" 3 "Primaria completa" 4 "Secundaria incompleta" 5 "Secundaria completa" 6 "Técnico superior incompleto" 7 "Técnico superior completo" 8 "Universitario incompleto" 9 "Universitario completo" 10 "Maestría o posgrado"
	label values q2_2 q2_2

	label variable q2_3 "Actualmente, ¿cuál es su ocupación principal?"
	note q2_3: "Actualmente, ¿cuál es su ocupación principal?"
	label define q2_3 1 "Empleador o patrono" 2 "Trabajador independiente" 3 "Empleado u obrero" 4 "Trabajador del hogar remunerado" 5 "Estudiante" 6 "Jubilado(a)/Pensionista" 7 "Trabajador familiar no remunerado" 8 "Actualmente no trabaja" 9 "Otro (especifique)"
	label values q2_3 q2_3

	label variable q2_3_otro "Por favor especifique cuál es su ocupación principal"
	note q2_3_otro: "Por favor especifique cuál es su ocupación principal"


	*----------------------------------------------------*
	*    Bloque 3 : C.0 Acceso a telecomunicaciones      *
	*----------------------------------------------------*

	label variable q3_1 "¿Usted tiene personalmente un teléfono móvil que usa con regularidad?"
	note q3_1: "¿Usted tiene personalmente un teléfono móvil que usa con regularidad?"
	label define q3_1 1 "Sí, un teléfono inteligente (smartphone)" 2 "Sí, un teléfono básico" 3 "No"
	label values q3_1 q3_1

	label variable q3_5 "¿Con qué frecuencia usa Internet en cualquier dispositivo?"
	note q3_5: "¿Con qué frecuencia usa Internet en cualquier dispositivo?"
	label define q3_5 1 "Diariamente" 2 "Varias veces por semana" 3 "Una vez a la semana" 4 "Menos de una vez a la semana" 5 "Nunca"
	label values q3_5 q3_5

	label variable q3_6 "¿Dónde accede principalmente a Internet?"
	note q3_6: "¿Dónde accede principalmente a Internet?"
	label define q3_6 1 "Hogar (wifi)" 2 "Trabajo / lugar de estudios" 3 "Datos del teléfono" 4 "WI-FI público" 5 "Casa de familiar / amigo" 6 "Otro (especifique)"
	label values q3_6 q3_6

	label variable q3_6_otro "De qué otra manera accede a internet"
	note q3_6_otro: "De qué otra manera accede a internet"

	label variable q3_7 "Actualmente, ¿cuenta con un plan de datos móviles activo en su teléfono principa"
	note q3_7: "Actualmente, ¿cuenta con un plan de datos móviles activo en su teléfono principal?"
	label define q3_7 1 "Sí, postpago" 2 "Sí, prepago/paquete de datos" 3 "No" 99 "No aplica (no uso datos)"
	label values q3_7 q3_7

	label variable q3_8 "En el último mes, ¿se quedó sin datos o saldo y eso le impidió usar servicios fi"
	note q3_8: "En el último mes, ¿se quedó sin datos o saldo y eso le impidió usar servicios financieros o comunicarse?"
	label define q3_8 1 "Sí, varias veces" 2 "Sí, una vez" 3 "No" 99 "No aplica"
	label values q3_8 q3_8

	label variable q3_10 "¿Cómo prefiere recibir notificaciones o mensajes sobre pagos y remesas?"
	note q3_10: "¿Cómo prefiere recibir notificaciones o mensajes sobre pagos y remesas?"
	label define q3_10 1 "SMS" 2 "WhatsApp" 3 "Notificación de aplicación" 4 "Llamada telefónica" 5 "Correo electrónico" 6 "Prefiero no recibir mensajes"
	label values q3_10 q3_10

	label variable q3_12 "¿Puede leer mensajes cortos en su teléfono sin ayuda de otra persona?"
	note q3_12: "¿Puede leer mensajes cortos en su teléfono sin ayuda de otra persona?"
	label define q3_12 1 "Siempre" 2 "A veces" 3 "Nunca"
	label values q3_12 q3_12


	*---------------------------------------------------------*
	*    Bloque 4 : C.1 Habilidades digitales percibidas      *
	*---------------------------------------------------------*

	label variable q3_15 "Sé descargar e instalar una aplicación en mi teléfono."
	note q3_15: "Sé descargar e instalar una aplicación en mi teléfono."
	label define q3_15 1 "Nada cierta" 2 "Poco cierta" 3 "Medianamente cierta" 4 "Muy cierta" 5 "Totalmente cierta"
	label values q3_15 q3_15

	label variable q3_16 "Sé usar mi teléfono para enviar o recibir dinero (transferencias, billetera digi"
	note q3_16: "Sé usar mi teléfono para enviar o recibir dinero (transferencias, billetera digital, pago móvil)."
	label define q3_16 1 "Nada cierta" 2 "Poco cierta" 3 "Medianamente cierta" 4 "Muy cierta" 5 "Totalmente cierta"
	label values q3_16 q3_16

	label variable q3_17 "Me siento segura evitando fraudes y mensajes sospechosos en línea (PIN, códigos "
	note q3_17: "Me siento segura evitando fraudes y mensajes sospechosos en línea (PIN, códigos OTP, enlaces)."
	label define q3_17 1 "Nada cierta" 2 "Poco cierta" 3 "Medianamente cierta" 4 "Muy cierta" 5 "Totalmente cierta"
	label values q3_17 q3_17


	*--------------------------------------------------------------------------*
	*    Bloque 5 : C.2 Habilidades prácticas de seguridad y uso de pagos      *
	*--------------------------------------------------------------------------*

	label variable q3_20 "En los últimos 3 meses, ¿escaneó un código QR para pagar o para que le paguen?"
	note q3_20: "En los últimos 3 meses, ¿escaneó un código QR para pagar o para que le paguen?"
	label define q3_20 1 "Sí, para pagar" 2 "Sí, para recibir" 3 "Sí, para pagar y recibir pagos" 4 "No"
	label values q3_20 q3_20

	label variable q3_21 "Si recibe un SMS con un código de verificación (OTP), ¿puede leerlo y usarlo sin"
	note q3_21: "Si recibe un SMS con un código de verificación (OTP), ¿puede leerlo y usarlo sin ayuda?"
	label define q3_21 1 "Siempre" 2 "A veces" 3 "Nunca" 4 "No sé qué es un OTP"
	label values q3_21 q3_21

	label variable q3_22 "¿Sabe crear o cambiar el PIN de su aplicación bancaria o billetera digital?"
	note q3_22: "¿Sabe crear o cambiar el PIN de su aplicación bancaria o billetera digital?"
	label define q3_22 1 "Sí" 2 "No" 3 "No uso apps financieras"
	label values q3_22 q3_22

	label variable q3_23 "Si recibe por WhatsApp o SMS un mensaje sospechoso que solicita dinero, claves o"
	note q3_23: "Si recibe por WhatsApp o SMS un mensaje sospechoso que solicita dinero, claves o códigos, ¿qué haría primero?"
	label define q3_23 1 "No hago click/No respondo y verifico con la entidad por otro canal" 2 "Bloqueo y reporto el número" 3 "Pido más información al remitente" 4 "Hago clic/comparto datos si parece urgente" 5 "No sabe"
	label values q3_23 q3_23


	*----------------------------------------------------------------*
	*    Bloque 6 : C.3 Documentos, cuentas y acceso financiero      *
	*----------------------------------------------------------------*
	
	*Múltiple 1
	label variable q4_1 "¿Cuáles de los siguientes documentos de identidad posee actualmente? (Marque tod"
	note q4_1: "¿Cuáles de los siguientes documentos de identidad posee actualmente? (Marque todas las que apliquen)."

	label var q4_1_1 "Documento de Identidad: Cédula de ciudadanía colombiana"
	label var q4_1_2 "Documento de Identidad: Carnet de extranjería"
	label var q4_1_3 "Documento de Identidad: Estatuto Temporal de Protección(PPT)"
	label var q4_1_4 "Documento de Identidad: Pasaporte (vigente)"
	label var q4_1_5 "Documento de Identidad: Pasaporte (vencido)"
	label var q4_1_6 "Documento de Identidad: Cédula venezolana"
	label var q4_1_7 "Documento de Identidad: Registro civil/Acta de nacimiento"
	label var q4_1_8 "Documento de Identidad: Otro"
	label var q4_1_9 "Documento de Identidad: Ninguno"
	label var q4_1_98 "Documento de Identidad: Prefiere no decirlo"

	label variable q4_1_otro "Qué otro documento de identidad posee"
	note q4_1_otro: "Qué otro documento de identidad posee"

	label variable q4_2 "En los últimos 12 meses, ¿intentó abrir una cuenta bancaria o billetera digital "
	note q4_2: "En los últimos 12 meses, ¿intentó abrir una cuenta bancaria o billetera digital y se la rechazaron por temas de documentación?"
	label define q4_2 1 "Sí" 2 "No" 3 "No intenté abrir una cuenta bancaria" 98 "Prefiero no decir"
	label values q4_2 q4_2

	*Múltiple 2
	label variable q4_3 "( SOLO SI HUBO RECHAZO ) ¿En qué tipo de entidad ocurrió el rechazo por document"
	note q4_3: "( SOLO SI HUBO RECHAZO ) ¿En qué tipo de entidad ocurrió el rechazo por documentación? (Marque todas las que apliquen)."

	label var q4_3_1 "Entidad de rechazo: Banco"
	label var q4_3_2 "Entidad de rechazo: Billetera digital"
	label var q4_3_3 "Entidad de rechazo: Cooperativa/Financiera solidaria"
	label var q4_3_4 "Entidad de rechazo: Fintech/EMI"
	label var q4_3_5 "Entidad de rechazo: Otro"

	label variable q4_3_otro "En qupe otra entidad ocurrió el rechazo"
	note q4_3_otro: "En qupe otra entidad ocurrió el rechazo"

	label variable q4_5 "¿Tiene a su nombre algún comprobante de dirección aceptado por entidades financi"
	note q4_5: "¿Tiene a su nombre algún comprobante de dirección aceptado por entidades financieras (recibo de servicios, contrato de arriendo, certificado de residencia)?"
	label define q4_5 1 "Sí" 2 "No" 3 "En trámite" 4 "Prefiero no decir"
	label values q4_5 q4_5

	label variable q4_6 "El número de teléfono que normalmente usa para sus cuentas o billeteras digitale"
	note q4_6: "El número de teléfono que normalmente usa para sus cuentas o billeteras digitales, ¿está registrado a su nombre?"
	label define q4_6 1 "Sí" 2 "No" 3 "No tengo línea propia" 4 "No sabe / No recuerda"
	label values q4_6 q4_6

	label variable q4_8 "¿Alguna vez un funcionario o una app le indicó que su documento 'no es válido' o"
	note q4_8: "¿Alguna vez un funcionario o una app le indicó que su documento 'no es válido' o 'no es legible' al intentar registrarse?"
	label define q4_8 1 "Sí, varias veces" 2 "Sí, alguna vez" 3 "No" 99 "No aplica"
	label values q4_8 q4_8

	label variable q4_11 "Si actualmente no tiene ningún documento de identidad, ¿cuál es el motivo princi"
	note q4_11: "Si actualmente no tiene ningún documento de identidad, ¿cuál es el motivo principal?"
	label define q4_11 1 "En trámite" 2 "Costo" 3 "Desconozco el proceso" 4 "Temor o desconfianza" 5 "Dificultad para obtener citas" 6 "Otro (especifique)" 7 "Prefiero no decir"
	label values q4_11 q4_11

	label variable q4_11_otro "Otro motivo para no tener documento de identidad"
	note q4_11_otro: "Otro motivo para no tener documento de identidad"

	*Múltiple 3
	label variable q4_12 "¿Usted tiene personalmente alguna cuenta en una institución financiera o una cue"
	note q4_12: "¿Usted tiene personalmente alguna cuenta en una institución financiera o una cuenta/billetera de dinero móvil? (Marque todas las que apliquen)."

	label var q4_12_1 "Posee cuenta: en Banco"
	label var q4_12_2 "Posee cuenta: en Billetera digital"
	label var q4_12_3 "Posee cuenta: en Cooperativa/financiera solidaria"
	label var q4_12_4 "Posee cuenta: en fintech/EMI"

	label variable q4_13 "De las cuentas o billeteras que mencionó, ¿cuál es la principal para recibir o m"
	note q4_13: "De las cuentas o billeteras que mencionó, ¿cuál es la principal para recibir o manejar dinero?"
	label define q4_13 1 "Banco" 2 "Billetera digital" 3 "Cooperativa / Financiera solidaria" 4 "Fintech/EMI" 5 "No tengo una cuenta"
	label values q4_13 q4_13

	label variable q4_14 "En los últimos 12 meses, ¿usó su cuenta o billetera principal para recibir remes"
	note q4_14: "En los últimos 12 meses, ¿usó su cuenta o billetera principal para recibir remesas del exterior?"
	label define q4_14 1 "Sí" 0 "No" 98 "Prefiero no responder"
	label values q4_14 q4_14

	label variable q4_15 "En los últimos 60 días (2 meses), ¿con qué frecuencia usó su cuenta o billetera "
	note q4_15: "En los últimos 60 días (2 meses), ¿con qué frecuencia usó su cuenta o billetera principal para cualquier operación (recibir, pagar, retirar, consultar saldo)?"
	label define q4_15 1 "A diario" 2 "Más de una vez por semana" 3 "Una vez a la semana" 4 "Una vez al mes" 5 "No la usé en los últimos 90 días"
	label values q4_15 q4_15

	label variable q4_16 "¿Qué tan fácil le resulta depositar o retirar efectivo (cash-in / cash-out) cerc"
	note q4_16: "¿Qué tan fácil le resulta depositar o retirar efectivo (cash-in / cash-out) cerca de su vivienda o trabajo?"
	label define q4_16 1 "Muy fácil" 2 "Algo fácil" 3 "Algo difícil" 4 "Muy difícil" 99 "No aplica"
	label values q4_16 q4_16

	label variable q4_17 "¿Aproximadamente cuánto tiempo tarda en llegar al punto de agente, cajero o sucu"
	note q4_17: "¿Aproximadamente cuánto tiempo tarda en llegar al punto de agente, cajero o sucursal más cercano donde puede hacer cash-in/cash-out?"
	label define q4_17 1 "Menos de 10 minutos" 2 "Entre 10 y 30 minutos" 3 "Entre 30 y 60 minutos" 4 "Más de una hora" 99 "No aplica"
	label values q4_17 q4_17

	label variable q4_23 "Si NO tiene ninguna cuenta ni billetera a su nombre, ¿cuál es la razón principal"
	note q4_23: "Si NO tiene ninguna cuenta ni billetera a su nombre, ¿cuál es la razón principal?"
	label define q4_23 1 "Falta de documentos" 2 "No confío en las entidades financieras" 3 "No sé cómo abrir o usar" 4 "Costos y comisiones" 5 "No tengo teléfono o dispositivo compatible" 6 "Necesito ayuda de otra persona" 7 "Lejanía de agentes y sucursales" 8 "Religión y/o cultura" 9 "Otro (especifique)" 98 "Prefiero no decir"
	label values q4_23 q4_23

	label variable q4_23_otro "Otra razón para no tner billetera o cuenta a su nombre"
	note q4_23_otro: "Otra razón para no tner billetera o cuenta a su nombre"

	label variable q4_24 "¿Usa su cuenta o billetera principal para pagar en comercios (por ejemplo, QR, t"
	note q4_24: "¿Usa su cuenta o billetera principal para pagar en comercios (por ejemplo, QR, transferencia, datafono sin tarjeta física)?"
	label define q4_24 1 "Sí, frecuentemente" 2 "Sí, ocasionalmente" 3 "No" 99 "No aplica"
	label values q4_24 q4_24

	label variable q4_25 "¿Mantiene ahorros en su cuenta o billetera principal (es decir, deja dinero guar"
	note q4_25: "¿Mantiene ahorros en su cuenta o billetera principal (es decir, deja dinero guardado por más de una semana)?"
	label define q4_25 1 "Sí, regularmente" 2 "A veces" 3 "No" 99 "No aplica"
	label values q4_25 q4_25

	label variable q4_26 "¿Recibe notificaciones (SMS o app) cuando llega una transferencia o remesa a su "
	note q4_26: "¿Recibe notificaciones (SMS o app) cuando llega una transferencia o remesa a su cuenta o billetera principal?"
	label define q4_26 1 "Sí, siempre" 2 "A veces" 3 "Nunca" 99 "No aplica"
	label values q4_26 q4_26

	label variable q4_27 "En los últimos 60 días (2 meses), ¿prestó su cuenta o billetera a otra persona p"
	note q4_27: "En los últimos 60 días (2 meses), ¿prestó su cuenta o billetera a otra persona para que recibiera o moviera dinero?"
	label define q4_27 1 "Sí" 0 "No" 98 "Prefiero no responder"
	label values q4_27 q4_27


	*---------------------------------------------------------------------*
	*    Bloque 7 : C.4 Sistemas de pago y experiencia de onboarding      *
	*---------------------------------------------------------------------*

	*Múltiple 4
	label variable q5_1 "¿Ha escuchado de alguno de estos sistemas o rieles de pago en Colombia? (Marque "
	note q5_1: "¿Ha escuchado de alguno de estos sistemas o rieles de pago en Colombia? (Marque todo lo que aplique)."

	label var q5_1_1 "Esucho sobre sistema/riel de pago: Bre-B (Banco de la República)"
	label var q5_1_2 "Esucho sobre sistema/riel de pago: Transfiyá/ACH"
	label var q5_1_3 "Esucho sobre sistema/riel de pago: Redeban (transferencia cuenta-cuenta/QR)"
	label var q5_1_4 "Esucho sobre sistema/riel de pago: Visionamos/redes cooperativas"
	label var q5_1_5 "Esucho sobre sistema/riel de pago: Otro"
	label var q5_1_6 "Esucho sobre sistema/riel de pago: Ninguno de los anteriores"

	label variable q5_1_otro "Qué otro sistema o riel de pago en Colombia ha escuchado"
	note q5_1_otro: "Qué otro sistema o riel de pago en Colombia ha escuchado"

	*Múltiple 5
	label variable q5_2 "En los últimos 60 días (2 meses), ¿usó alguno de estos sistemas para recibir, en"
	note q5_2: "En los últimos 60 días (2 meses), ¿usó alguno de estos sistemas para recibir, enviar o retirar dinero? (Marque todo lo que aplique)."

	label var q5_2_1 "Usó sistema/riel de pago: Bre-B (Banco de la República)"
	label var q5_2_2 "Usó sistema/riel de pago: Transfiyá/ACH"
	label var q5_2_3 "Usó sistema/riel de pago: Redeban (transferencia cuenta-cuenta/QR)"
	label var q5_2_4 "Usó sistema/riel de pago: Visionamos/redes cooperativas"
	label var q5_2_5 "Usó sistema/riel de pago: Otro"
	label var q5_2_6 "Usó sistema/riel de pago: Ninguno de los anteriores"
	label var q5_2_98 "Usó sistema/riel de pago: No sabe/No recuerda"

	label variable q5_2_otro "Qué otro sistema para recibir o enviar dinero ha usado"
	note q5_2_otro: "Qué otro sistema para recibir o enviar dinero ha usado"

	label variable q5_3 "Pensando en su última transferencia nacional (no internacional), ¿por cuál de es"
	note q5_3: "Pensando en su última transferencia nacional (no internacional), ¿por cuál de estos sistemas cree que se acreditó el dinero?"
	label define q5_3 1 "Bre-B (Banco de la República)" 2 "Transfiyá / ACH" 3 "Redeban (transferencia cuenta-a-cuenta/QR)" 4 "Visionamos / redes cooperativas" 5 "Otro (especifique)" 6 "Ninguno de los anteriores" 98 "No sabe / No recuerda"
	label values q5_3 q5_3

	label variable q5_4 "En los últimos 30 días, ¿usó un código QR para recibir o pagar, ya sea escaneand"
	note q5_4: "En los últimos 30 días, ¿usó un código QR para recibir o pagar, ya sea escaneando un QR o mostrando un QR propio?"
	label define q5_4 1 "Sí, recibí pagos" 2 "Sí, pagué" 3 "Sí, ambas" 4 "No"
	label values q5_4 q5_4

	label variable q5_5 "Para la última transferencia que recibió en Colombia (no internacional), ¿recibi"
	note q5_5: "Para la última transferencia que recibió en Colombia (no internacional), ¿recibió algún tipo de confirmación (SMS, notificación de app o mensaje del banco/proveedor)?"
	label define q5_5 1 "Sí, SMS" 2 "Sí, App" 3 "Sí, correo electrónico" 4 "No" 98 "No sabe / No recuerda"
	label values q5_5 q5_5

	label variable q5_6 "¿En cuánto tiempo pudo usar el dinero después de que se envió esa última transfe"
	note q5_6: "¿En cuánto tiempo pudo usar el dinero después de que se envió esa última transferencia nacional?"
	label define q5_6 1 "Minutos" 2 "Horas" 3 "Mismo día" 4 "1-3 días" 5 "Más de 3 días" 98 "No sabe / No recuerda"
	label values q5_6 q5_6

	label variable q5_7 "En esa operación, ¿las comisiones o costos por transferir o recibir el dinero es"
	note q5_7: "En esa operación, ¿las comisiones o costos por transferir o recibir el dinero estuvieron claramente visibles antes de confirmar la operación?"
	label define q5_7 1 "Muy claros" 2 "Algo claros" 3 "Poco claros" 4 "Nada claros" 98 "No recueda"
	label values q5_7 q5_7

	label variable q5_8 "En esa operación digital, la aceptación del pago por parte de la persona que rec"
	note q5_8: "En esa operación digital, la aceptación del pago por parte de la persona que recibe (por ejemplo, tocar 'Aceptar' en la app) fue…"
	label define q5_8 1 "Siempre necesaria" 2 "A veces necesaria" 3 "No fue necesaria (acreditación automática)" 98 "No sabe / No recuerda"
	label values q5_8 q5_8

	label variable q5_9 "En los últimos 12 meses, ¿tuvo algún fallo o reverso (dinero no llegó, llegó tar"
	note q5_9: "En los últimos 12 meses, ¿tuvo algún fallo o reverso (dinero no llegó, llegó tarde o se debitó dos veces) usando estos sistemas de pago?"
	label define q5_9 1 "Sí, y se resolvió" 2 "Sí, y no se ha resuelto" 3 "No" 98 "No sabe / No recuerda"
	label values q5_9 q5_9

	label variable q5_10 "¿Cuál es la principal razón por la que no usa más estos sistemas o rieles de pag"
	note q5_10: "¿Cuál es la principal razón por la que no usa más estos sistemas o rieles de pago digitales?"
	label define q5_10 1 "No los entiendo / me confunden" 2 "No confío en las entidades financieras" 3 "Comisiones altas" 4 "No tengo internet / dispositivo compatible" 5 "Problemas de documentos o registro" 6 "No están disponibles donde compro o vendo" 7 "Otro (especifique)"
	label values q5_10 q5_10

	label variable q5_10_otro "Por qué otra razón no usa estos sistemas o rieles de pagos"
	note q5_10_otro: "Por qué otra razón no usa estos sistemas o rieles de pagos"

	label variable q5_11 "Su cuenta o billetera principal la creó…"
	note q5_11: "Su cuenta o billetera principal la creó…"
	label define q5_11 1 "En persona (sucursal / agente)" 2 "App del banco / proveedor con documento" 3 "Con número de celular (OTP por SMS)" 4 "Video-identificación o videollamada" 5 "Ayuda de familiar / amigo" 98 "No sabe / No recuerda"
	label values q5_11 q5_11

	label variable q5_12 "¿Qué identificador o 'llave' usa con más frecuencia para recibir dinero en su cu"
	note q5_12: "¿Qué identificador o 'llave' usa con más frecuencia para recibir dinero en su cuenta o billetera principal?"
	label define q5_12 1 "Número de celular" 2 "Número de identificación (cédila / PPT)" 3 "Correo electrónico" 4 "Número de cuenta (CBU/CLABE/local)" 5 "Alias o usuario" 6 "Código QR" 7 "Otro (especifique)" 98 "No sabe / No recuerda" 99 "No utiliza"
	label values q5_12 q5_12

	label variable q5_12_otro "Qué otro identificador o llave usa con más frecuencia"
	note q5_12_otro: "Qué otro identificador o llave usa con más frecuencia"

	*Múltiple 6
	label variable q5_13 "En su registro (onboarding) más reciente, ¿qué le pidieron para verificar su ide"
	note q5_13: "En su registro (onboarding) más reciente, ¿qué le pidieron para verificar su identidad? (Marque todo lo que aplique)."

	label var q5_13_1 "Documento de verificación: Documento con foto"
	label var q5_13_2 "Documento de verificación: Foto o biometría"
	label var q5_13_3 "Documento de verificación: Huella dactilar"
	label var q5_13_4 "Documento de verificación: Prueba de dirección/domicilio(recibo)"
	label var q5_13_5 "Documento de verificación: Línea a su nombre"
	label var q5_13_6 "Documento de verificación: Referencia personal"
	label var q5_13_7 "Documento de verificación: Otro"
	label var q5_13_98 "Documento de verificación: No sabe/No recuerda"

	label variable q5_13_otro "Qué otro documento le pidieron para verificar su identidad"
	note q5_13_otro: "Qué otro documento le pidieron para verificar su identidad"

	label variable q5_14 "En general, ¿qué tan fácil o difícil fue completar el registro hasta poder usar "
	note q5_14: "En general, ¿qué tan fácil o difícil fue completar el registro hasta poder usar la cuenta o billetera principal?"
	label define q5_14 1 "Muy fácil" 2 "Algo fácil" 3 "Algo difícil" 4 "Muy difícil" 98 "No sabe / No recuerda"
	label values q5_14 q5_14

	label variable q5_15 "¿Cuánto tiempo tardó su registro hasta que la cuenta o billetera quedó activada "
	note q5_15: "¿Cuánto tiempo tardó su registro hasta que la cuenta o billetera quedó activada para recibir o enviar dinero?"
	label define q5_15 1 "Minutos" 2 "Horas" 3 "Mismo día" 4 "1-3 días" 5 "Más de 3 días" 98 "No sabe / No recuerda"
	label values q5_15 q5_15

	label variable q5_16 "¿Necesitó ayuda para registrarse en esa cuenta o billetera principal?"
	note q5_16: "¿Necesitó ayuda para registrarse en esa cuenta o billetera principal?"
	label define q5_16 1 "Sí" 0 "No" 98 "Prefiero no responder"
	label values q5_16 q5_16

	label variable q5_17 "En los últimos 12 meses, ¿ha cambiado su 'llave' principal (por ejemplo, número "
	note q5_17: "En los últimos 12 meses, ¿ha cambiado su 'llave' principal (por ejemplo, número de celular usado para recibir pagos)?"
	label define q5_17 1 "Sí, familiar/amigo" 2 "Sí, agente / comercio" 3 "Sí, funcionario de la entidad" 4 "No, lo hice sola" 98 "No sabe / No recuerda"
	label values q5_17 q5_17

	label variable q5_18 "Al cambiar su 'llave' (por ejemplo, su número de celular), ¿pudo actualizarla fá"
	note q5_18: "Al cambiar su 'llave' (por ejemplo, su número de celular), ¿pudo actualizarla fácilmente en su cuenta o billetera para seguir recibiendo dinero?"
	label define q5_18 1 "Sí, muy fácil" 2 "Algo fácil" 3 "Algo difícil" 4 "Muy difícil" 98 "No sabe / No recuerda" 99 "No aplica"
	label values q5_18 q5_18

	label variable q5_20 "Al registrarse, ¿le establecieron topes o límites por operación o por día para u"
	note q5_20: "Al registrarse, ¿le establecieron topes o límites por operación o por día para usar su cuenta o billetera?"
	label define q5_20 1 "Sí, claros" 2 "Sí, pero no fueron claros" 3 "No establecieron" 98 "No sabe / No recuerda"
	label values q5_20 q5_20

	label variable q5_21 "¿Recuerda haber aceptado términos y condiciones y autorización de manejo de dato"
	note q5_21: "¿Recuerda haber aceptado términos y condiciones y autorización de manejo de datos personales durante el registro?"
	label define q5_21 1 "Sí, leí y entendí" 2 "Sí, pero no los leí o no entendi bien" 3 "No" 98 "No sabe / No recuerda"
	label values q5_21 q5_21

	label variable q5_22 "En su opinión, ¿el registro protegió adecuadamente su privacidad (solo pidió lo "
	note q5_22: "En su opinión, ¿el registro protegió adecuadamente su privacidad (solo pidió lo necesario y explicó el uso de sus datos)?"
	label define q5_22 1 "Muy bien protegido" 2 "Adecuado" 3 "Insuficiente" 98 "No sabe / No recuerda"
	label values q5_22 q5_22

	label variable q5_23 "En el registro o en el primer uso, ¿el sistema o app ofreció mensajes en español"
	note q5_23: "En el registro o en el primer uso, ¿el sistema o app ofreció mensajes en español claro y algún tipo de asistencia (tutorial, ayuda paso a paso, chat)?"
	label define q5_23 1 "Sí, suficiente" 2 "Sí, pero insuficiente" 3 "No" 98 "No sabe / No recuerda"
	label values q5_23 q5_23

	label variable q5_24 "Para recibir dinero en el futuro, ¿qué tipo de identificador preferiría usar con"
	note q5_24: "Para recibir dinero en el futuro, ¿qué tipo de identificador preferiría usar con más frecuencia?"
	label define q5_24 1 "Celular (número)" 2 "Número de identificación (cédila / PPT)" 3 "Alias o usuario" 4 "QR" 5 "Número de cuenta (CBU/CLABE/local)" 6 "No tengo preferencia" 98 "No sabe / No recuerda"
	label values q5_24 q5_24

	label variable q5_25 "En su registro más reciente, ¿su documento fue aceptado sin problemas?"
	note q5_25: "En su registro más reciente, ¿su documento fue aceptado sin problemas?"
	label define q5_25 1 "Sí" 2 "No, presentaron objeciones" 98 "No sabe / No recuerda" 99 "No aplica (sin documento)"
	label values q5_25 q5_25

	label variable q5_27 "¿Recibió algún tipo de asesoría o advertencias sobre fraudes comunes (phishing, "
	note q5_27: "¿Recibió algún tipo de asesoría o advertencias sobre fraudes comunes (phishing, enlaces falsos, llamadas sospechosas) durante o después del registro?"
	label define q5_27 1 "Sí, claramente" 2 "Sí, pero limitada" 3 "No" 98 "No sabe / No recuerda"
	label values q5_27 q5_27


	*-----------------------------------------------------------*
	*    Bloque 8 : D. Remesas y experiencia transaccional      *
	*-----------------------------------------------------------*

	label variable q6_2 "Pensando solo en los últimos 12 meses, ¿con qué frecuencia recibió remesas del e"
	note q6_2: "Pensando solo en los últimos 12 meses, ¿con qué frecuencia recibió remesas del exterior?"
	label define q6_2 1 "Mensualmente o más frecuente" 2 "Cada 2 a 3 meses" 3 "1 a 2 veces en el año" 99 "No aplica / No recuerda"
	label values q6_2 q6_2

	label variable q6_4 "¿A través de qué canal recibió esa remesa más reciente?"
	note q6_4: "¿A través de qué canal recibió esa remesa más reciente?"
	label define q6_4 1 "Transferencia a cuenta bancaria" 2 "Billetera / app (Nequi, Daviplata)" 3 "Cobro en efectivo en corresponsal / ventanilla" 4 "Entrega en mano por viajero" 5 "Otro medio (especifique)"
	label values q6_4 q6_4

	label variable q6_4_otro "A través de qué otro canal recibió la remesa más reciente"
	note q6_4_otro: "A través de qué otro canal recibió la remesa más reciente"

	label variable q6_5 "(Solo si fue digital) Esa remesa más reciente, ¿a través de qué sistema o riel d"
	note q6_5: "(Solo si fue digital) Esa remesa más reciente, ¿a través de qué sistema o riel de pago cree que llegó? (Si no sabe, seleccione 'No sabe / No recuerda')."
	label define q6_5 1 "Bre-B (Banco de la República)" 2 "Transfiyá / ACH" 3 "Redeban (transferencia cuenta-a-cuenta/QR)" 4 "Visionamos / redes cooperativas" 5 "Otro riel (especifique)" 98 "No sabe / No recuerda" 99 "No aplica"
	label values q6_5 q6_5

	label variable q6_5_otro "A través de qué otro sistema o riel de pago llegó esa remesa"
	note q6_5_otro: "A través de qué otro sistema o riel de pago llegó esa remesa"

	label variable q6_6 "¿Cuánto tiempo pasó desde que la persona que envió la remesa hizo el envío hasta"
	note q6_6: "¿Cuánto tiempo pasó desde que la persona que envió la remesa hizo el envío hasta que usted pudo usar el dinero?"
	label define q6_6 1 "Minutos" 2 "Horas" 3 "Mismo día" 4 "1 a 3 días" 5 "Más de 3 días" 98 "No sabe / No recuerda"
	label values q6_6 q6_6

	label variable q6_7 "Por esa remesa más reciente, ¿se pagó alguna comisión (ya sea usted o quien envi"
	note q6_7: "Por esa remesa más reciente, ¿se pagó alguna comisión (ya sea usted o quien envió el dinero)?"
	label define q6_7 1 "Sí, la pagó quien envió" 2 "Sí, la pagué yo al recibir" 3 "Sí, ambos" 4 "No hubo comisión" 98 "No sabe / No recuerda"
	label values q6_7 q6_7

	label variable q6_9 "Pensando en esa remesa más reciente, ¿qué tan clara fue para usted la tasa de ca"
	note q6_9: "Pensando en esa remesa más reciente, ¿qué tan clara fue para usted la tasa de cambio aplicada (si hubo cambio de moneda)?"
	label define q6_9 1 "Muy clara" 2 "Algo clara" 3 "Poco clara" 4 "Nada clara" 99 "No aplica"
	label values q6_9 q6_9

	label variable q6_10 "¿Dónde y cómo retiró o dispuso del dinero de esa remesa más reciente?"
	note q6_10: "¿Dónde y cómo retiró o dispuso del dinero de esa remesa más reciente?"
	label define q6_10 1 "Lo dejé digital (guardado en cuenta / app)" 2 "Retiré efectivo en corresponsal / cajero automático" 3 "Pagué compras con QR o transferencia" 4 "Transferí a otra cuenta" 5 "Otro (especifique)"
	label values q6_10 q6_10

	label variable q6_10_otro "De qué otra manera retiró o dispuso del dinero de esa remeas más reciente"
	note q6_10_otro: "De qué otra manera retiró o dispuso del dinero de esa remeas más reciente"

	label variable q6_11 "¿Recibió alguna confirmación cuando llegó esa remesa (SMS, notificación de app, "
	note q6_11: "¿Recibió alguna confirmación cuando llegó esa remesa (SMS, notificación de app, correo electrónico o recibo en papel)?"
	label define q6_11 1 "SMS" 2 "Notificación en app" 3 "Recibo en papel" 4 "Correo electrónico" 5 "No recibí confirmación" 98 "No sabe / No recuerda"
	label values q6_11 q6_11

	*Múltiple 7
	label variable q6_12 "¿Para qué usó principalmente esa remesa más reciente? (Marque todas las opciones"
	note q6_12: "¿Para qué usó principalmente esa remesa más reciente? (Marque todas las opciones que apliquen)."

	label var q6_12_1 "Uso de remesa: Gastos de hogar/alimentos"
	label var q6_12_2 "Uso de remesa: Salud"
	label var q6_12_3 "Uso de remesa: Educación"
	label var q6_12_4 "Uso de remesa: Ahorro"
	label var q6_12_5 "Uso de remesa: Negocio/emprendimiento"
	label var q6_12_6 "Uso de remesa: Pago de deudas"
	label var q6_12_7 "Uso de remesa: Otro"

	label variable q6_12_otro "De qué otra manera usó esa remesa más reciente"
	note q6_12_otro: "De qué otra manera usó esa remesa más reciente"

	label variable q6_13 "En general, pensando en todas las remesas que recibe, ¿qué proporción termina en"
	note q6_13: "En general, pensando en todas las remesas que recibe, ¿qué proporción termina en efectivo y qué proporción se mantiene o usa de forma digital?"
	label define q6_13 1 "Todo lo retiro en efectivo" 2 "Retiro menos de la mitad en efectivo" 3 "Dejo la mitad en efectivo y la mitad de manera digital" 4 "Dejo más de la mitad digital" 5 "Mantengo el 100% del dinero de manera digital"
	label values q6_13 q6_13

	label variable q6_14 "En los últimos 60 días (2 meses), ¿realizó o recibió pagos digitales o remesas d"
	note q6_14: "En los últimos 60 días (2 meses), ¿realizó o recibió pagos digitales o remesas dentro de Colombia usando apps, transferencias, billeteras o códigos QR?"
	label define q6_14 1 "Sí" 0 "No" 98 "Prefiero no responder"
	label values q6_14 q6_14

	label variable q6_15 "En esos últimos 60 días (2 meses), aproximadamente ¿cuántas operaciones digitale"
	note q6_15: "En esos últimos 60 días (2 meses), aproximadamente ¿cuántas operaciones digitales (enviar o recibir dinero) realizó en total?"
	label define q6_15 1 "Menos de 5" 2 "Entre 5 y 10" 3 "Entre 10 y 20" 4 "Entre 20 y 50" 5 "Más de 50" 98 "No sabe / No recuerda"
	label values q6_15 q6_15

	label variable q6_16 "En esos últimos 60 días (2 meses), ¿tuvo algún problema con pagos o transferenci"
	note q6_16: "En esos últimos 60 días (2 meses), ¿tuvo algún problema con pagos o transferencias digitales (por ejemplo, dinero que no llegó, reversos, operaciones rechazadas o duplicadas)?"
	label define q6_16 1 "Sí, y se resolvió rápido (mismo día)" 2 "Sí, tardó en resolvrse (más de un día)" 3 "Sí, y no se resolvió" 4 "No" 98 "No sabe / No recuerda"
	label values q6_16 q6_16

	label variable q6_17 "¿Ha encontrado límites o topes que le impidan completar operaciones digitales (p"
	note q6_17: "¿Ha encontrado límites o topes que le impidan completar operaciones digitales (por monto por transacción, límite diario o mensual, o número de operaciones)?"
	label define q6_17 1 "Sí, por monto de transacción" 2 "Sí, por límitie diario / mensual" 3 "Sí, por número de transacciones" 4 "No" 98 "No sabe / No recuerda"
	label values q6_17 q6_17

	label variable q6_18 "En la última operación digital que hizo en esos 90 días, ¿las comisiones se most"
	note q6_18: "En la última operación digital que hizo en esos 90 días, ¿las comisiones se mostraron claramente antes de que usted confirmara la operación?"
	label define q6_18 1 "Sí, claramente" 2 "Sí, pero poco claro" 3 "No se mostró" 4 "No aplicaba comisión" 98 "No sabe / No recuerda"
	label values q6_18 q6_18

	label variable q6_19 "En esa última operación digital, la tasa de cambio (si aplicó) fue…"
	note q6_19: "En esa última operación digital, la tasa de cambio (si aplicó) fue…"
	label define q6_19 1 "Visible y clara" 2 "Visible pero confusa" 3 "No visible" 4 "No aplicó" 98 "No sabe / No recuerda"
	label values q6_19 q6_19

	label variable q6_20 "En esa última operación digital, ¿recibió una confirmación inmediata (por SMS o "
	note q6_20: "En esa última operación digital, ¿recibió una confirmación inmediata (por SMS o notificación en la app) al enviar o recibir el dinero?"
	label define q6_20 1 "Sí, inmediata" 2 "Sí, pero tardía" 3 "No recibí confirmación" 98 "No sabe / No recuerda"
	label values q6_20 q6_20

	label variable q6_21 "En general, ¿qué tan rápidos le resultan sus pagos o remesas digitales (desde qu"
	note q6_21: "En general, ¿qué tan rápidos le resultan sus pagos o remesas digitales (desde que se envían hasta que usted puede usar el dinero)?"
	label define q6_21 1 "Al instante" 2 "En horas" 3 "En el día" 4 "De 1 a 3 días" 5 "Más de 3 días" 6 "Variable / No predecible"
	label values q6_21 q6_21

	label variable q6_22 "¿Ha notado cargos adicionales al pagar con QR o transferencia en comercios, comp"
	note q6_22: "¿Ha notado cargos adicionales al pagar con QR o transferencia en comercios, comparado con pagar en efectivo (por ejemplo, recargo o comisión extra)?"
	label define q6_22 1 "Sí, suelen cobrar extra" 2 "Precio igual que en efectivo" 3 "Descuento por pagar digital" 98 "No sabe / No recuerda" 99 "No aplica / No usa"
	label values q6_22 q6_22

	label variable q6_23 "En general, ¿qué tan clara le resulta la información que dan los proveedores sob"
	note q6_23: "En general, ¿qué tan clara le resulta la información que dan los proveedores sobre límites, horarios, comisiones y tiempos de abono de las operaciones digitales?"
	label define q6_23 1 "Muy clara" 2 "Algo clara" 3 "Poco clara" 4 "Nada clara"
	label values q6_23 q6_23

	label variable q6_24 "En los últimos 60 días (2 meses), ¿cómo evaluaría su experiencia transaccional d"
	note q6_24: "En los últimos 60 días (2 meses), ¿cómo evaluaría su experiencia transaccional digital en general?"
	label define q6_24 1 "Muy mala" 2 "Mala" 3 "Regular" 4 "Buena" 5 "Excelente"
	label values q6_24 q6_24

	label variable q6_25 "Si pudiera mejorar un solo aspecto de los pagos o remesas digitales que usa, ¿cu"
	note q6_25: "Si pudiera mejorar un solo aspecto de los pagos o remesas digitales que usa, ¿cuál sería el principal para usted?"
	label define q6_25 1 "Velocidad / tiempos" 2 "Éxitos sin fallas" 3 "Claridad de comisiones o tipo de cambio" 4 "Límites más adecuados" 5 "Confirmaciones y avisos" 6 "Otro (especifique)"
	label values q6_25 q6_25

	label variable q6_25_otro "Qué otro aspecto quisiera mejorar"
	note q6_25_otro: "Qué otro aspecto quisiera mejorar"

	label variable q6_26 "Pensando en estos últimos 60 días (2 meses), ¿qué sistema o riel de pago le ha d"
	note q6_26: "Pensando en estos últimos 60 días (2 meses), ¿qué sistema o riel de pago le ha dado la mejor experiencia general?"
	label define q6_26 1 "Bre-B (Banco de la República)" 2 "Transfiyá / ACH" 3 "Redeban (transferencia cuenta-a-cuenta/QR)" 4 "Visionamos / redes cooperativas" 5 "Otro (especifique)"
	label values q6_26 q6_26

	label variable q6_26_otro "Qué otro sistema o riel de pago le ha dado la mejor experiencia"
	note q6_26_otro: "Qué otro sistema o riel de pago le ha dado la mejor experiencia"


	*----------------------------------------------------*
	*    Bloque 9 : E. Seguridad, fraude y reclamos      *
	*----------------------------------------------------*

	label variable q7_1 "En los últimos 12 meses, ¿recibió mensajes o llamadas sospechosas (SMS, WhatsApp"
	note q7_1: "En los últimos 12 meses, ¿recibió mensajes o llamadas sospechosas (SMS, WhatsApp, redes sociales o teléfono) pidiéndole códigos SMS/OTP, claves, PIN o que hiciera una transferencia urgente?"
	label define q7_1 1 "Sí, varias veces" 2 "Sí, al menos una vez" 3 "No personalmente" 4 "Conozco a alguien que sí recibió" 98 "No sabe / No recuerda"
	label values q7_1 q7_1

	label variable q7_2 "Pensando en el último mensaje o llamada sospechosa que recibió, ¿qué hizo usted "
	note q7_2: "Pensando en el último mensaje o llamada sospechosa que recibió, ¿qué hizo usted primero?"
	label define q7_2 1 "Lo ignoré/eliminé" 2 "bloquee el número / cuenta" 3 "Llamé al banco o proveedor" 4 "Hice click / compartí datos por error" 5 "Realicé otra acción (especifique)"
	label values q7_2 q7_2

	label variable q7_5 "En los últimos 12 meses, ¿su cuenta, tarjeta o app fue bloqueada o limitada por "
	note q7_5: "En los últimos 12 meses, ¿su cuenta, tarjeta o app fue bloqueada o limitada por intentos fallidos, contraseñas erradas o sospecha de fraude?"
	label define q7_5 1 "Sí, y se resolvió rápido (mismo día)" 2 "Sí, y tardó más de un día en resolverse" 3 "Sí, y no se resolvió" 4 "No" 98 "No sabe / No recuerda"
	label values q7_5 q7_5

	label variable q7_6 "Actualmente, ¿usa algún método de autenticación segura en su teléfono o app (por"
	note q7_6: "Actualmente, ¿usa algún método de autenticación segura en su teléfono o app (por ejemplo, huella, reconocimiento facial, PIN, patrón o bloqueo de pantalla)?"
	label define q7_6 1 "Sí, siempre" 2 "Sí, a veces" 3 "No, nunca" 98 "No sabe / No recuerda"
	label values q7_6 q7_6

	label variable q7_7 "¿Con qué frecuencia cambia sus claves o PIN y revisa sus movimientos para detect"
	note q7_7: "¿Con qué frecuencia cambia sus claves o PIN y revisa sus movimientos para detectar operaciones no reconocidas?"
	label define q7_7 1 "Todos los meses o más frecuente" 2 "Cada 2 a 3 meses" 3 "Rara vez (menos de una vez al año)" 4 "Nunca las suelo cambiar"
	label values q7_7 q7_7

	label variable q7_8 "¿Recibió en los últimos 12 meses mensajes de educación o alertas de su banco/app"
	note q7_8: "¿Recibió en los últimos 12 meses mensajes de educación o alertas de su banco/app sobre estafas comunes (por ejemplo, 'no comparta OTP', 'no haga clic en enlaces desconocidos')?"
	label define q7_8 1 "Sí, claros y útiles" 2 "Sí, pero poco claros" 3 "No recibí" 98 "No sabe / No recuerda"
	label values q7_8 q7_8

	label variable q7_9 "En general, ¿qué tan segura se siente al recibir remesas o pagos por canales dig"
	note q7_9: "En general, ¿qué tan segura se siente al recibir remesas o pagos por canales digitales (app, QR, transferencia)?"
	label define q7_9 1 "Muy segura" 2 "Algo segura" 3 "Poco segura" 4 "Nada segura"
	label values q7_9 q7_9

	label variable q7_10 "¿Qué medida de seguridad considera más útil para evitar fraudes en su caso?"
	note q7_10: "¿Qué medida de seguridad considera más útil para evitar fraudes en su caso?"
	label define q7_10 1 "Autenticación biométrica (huella / rostro)" 2 "OTP pro SMS / confirmación en la app" 3 "Bloqueo automático del teléfono" 4 "Alertas de movimientos por SMS / WhatsApp" 5 "Educación / alertas antifraude" 6 "Atención al cliente rápida"
	label values q7_10 q7_10

	label variable q7_11 "En los últimos 12 meses, ¿tuvo algún problema con un pago o remesa digital (por "
	note q7_11: "En los últimos 12 meses, ¿tuvo algún problema con un pago o remesa digital (por ejemplo, dinero que no llegó, llegó incompleto o tarde, cobro indebido, error de destinatario)?"
	label define q7_11 1 "Sí, al menos un problema" 2 "No tuve problemas" 98 "No sabe / No recuerda"
	label values q7_11 q7_11

	label variable q7_12 "Pensando en el problema más reciente, ¿a quién presentó el reclamo primero?"
	note q7_12: "Pensando en el problema más reciente, ¿a quién presentó el reclamo primero?"
	label define q7_12 1 "App / Chat del proveedor" 2 "Lllamada al proveedor" 3 "Agente / sucursal" 4 "Regulador" 5 "Defensoría / Consumo" 6 "No reclamé"
	label values q7_12 q7_12

	label variable q7_13 "¿Cuánto tiempo tardó en recibir una primera respuesta de ese canal de reclamo?"
	note q7_13: "¿Cuánto tiempo tardó en recibir una primera respuesta de ese canal de reclamo?"
	label define q7_13 1 "El mismo día" 2 "1 a 3 días" 3 "4 a 7 días" 4 "Más de 7 días" 5 "No recibió respuesta"
	label values q7_13 q7_13

	label variable q7_14 "¿El problema quedó resuelto y el dinero fue restituido o corregido?"
	note q7_14: "¿El problema quedó resuelto y el dinero fue restituido o corregido?"
	label define q7_14 1 "Sí, completamente resuelto" 2 "Parcialmente resuelto" 3 "No resuelto" 4 "En trámite"
	label values q7_14 q7_14

	label variable q7_15 "En una escala de 1 a 5, ¿qué tan satisfecha quedó con la atención del proveedor "
	note q7_15: "En una escala de 1 a 5, ¿qué tan satisfecha quedó con la atención del proveedor o entidad que gestionó su reclamo?"
	label define q7_15 1 "Muy insatisfecho" 2 "Insatisfecha" 3 "Ni satisfecha ni insatisfecha" 4 "Satisfecha" 5 "Muy satisfecha"
	label values q7_15 q7_15

	label variable q7_16 "Si no presentó reclamo por ese problema, ¿cuál fue la principal razón?"
	note q7_16: "Si no presentó reclamo por ese problema, ¿cuál fue la principal razón?"
	label define q7_16 1 "No sabía cómo reclamar" 2 "Pensé que no serviría / no sería efectivo" 3 "Temor a problemas con documentos / estatus migratorio" 4 "El monto era pequeño" 5 "Falta de tiempo" 6 "Ninguna de las anteriores"
	label values q7_16 q7_16

	label variable q7_17 "¿Recibió información clara y por escrito (SMS, correo, app, carta) sobre el esta"
	note q7_17: "¿Recibió información clara y por escrito (SMS, correo, app, carta) sobre el estado de su reclamo y los pasos a seguir?"
	label define q7_17 1 "Sí, clara y completa" 2 "Sí, pero poco clara" 3 "No recibí"
	label values q7_17 q7_17

	label variable q7_18 "¿Le orientaron sobre qué hacer si volvía a ocurrir el mismo problema (por ejempl"
	note q7_18: "¿Le orientaron sobre qué hacer si volvía a ocurrir el mismo problema (por ejemplo, cómo prevenirlo o cómo acelerar el trámite)?"
	label define q7_18 1 "Sí" 2 "No" 98 "No sabe / No recuerda"
	label values q7_18 q7_18

	label variable q7_19 "Valorando su experiencia y lo que conoce, ¿qué canal de reclamo le parece más ef"
	note q7_19: "Valorando su experiencia y lo que conoce, ¿qué canal de reclamo le parece más eficaz para resolver rápido si tuviera un problema con pagos o remesas digitales?"
	label define q7_19 1 "App / Chat del proveedor" 2 "Llamada al proveedor" 3 "Agente / sucursal" 4 "Regulador" 5 "Defensoría / Consumo" 98 "No sabe / No recuerda"
	label values q7_19 q7_19

	label variable q7_20 "En general, ¿qué tan claras son para usted las comisiones, límites y condiciones"
	note q7_20: "En general, ¿qué tan claras son para usted las comisiones, límites y condiciones del servicio que usa para pagos y remesas digitales?"
	label define q7_20 1 "Muy claras" 2 "Algo claras" 3 "Poco claras" 4 "Nada claras"
	label values q7_20 q7_20

	label variable q7_21 "Si pudiera mejorar un solo aspecto del proceso de reclamos en su banco o app, ¿c"
	note q7_21: "Si pudiera mejorar un solo aspecto del proceso de reclamos en su banco o app, ¿cuál sería el principal?"
	label define q7_21 1 "Tiempo de respuesta" 2 "Claridad de información" 3 "Facilidad para iniciar reclamo" 4 "Tacto y empatía" 5 "Devolución del dinero" 6 "Otro (especifique)" 98 "No sabe / No recuerda"
	label values q7_21 q7_21

	label variable q7_21_otro "Qué otro aspecto del proceso de reclamos mejoraría"
	note q7_21_otro: "Qué otro aspecto del proceso de reclamos mejoraría"


	*--------------------------------------------------------------*
	*    Bloque 11 : F. Confianza,autonomía y normas sociales      *
	*--------------------------------------------------------------*

	label variable q9_1 "Confío en que mi proveedor principal de pagos o cuenta mantendrá mi dinero segur"
	note q9_1: "Confío en que mi proveedor principal de pagos o cuenta mantendrá mi dinero seguro."
	label define q9_1 1 "Totalmente en desacuerdo" 2 "En desacuerdo" 3 "Ni de acuerdo ni en desacuerdo" 4 "De acuerdo" 5 "Totalmente de acuerdo"
	label values q9_1 q9_1

	label variable q9_4 "Yo decido cómo se usan las remesas del hogar la mayor parte del tiempo."
	note q9_4: "Yo decido cómo se usan las remesas del hogar la mayor parte del tiempo."
	label define q9_4 1 "Totalmente en desacuerdo" 2 "En desacuerdo" 3 "Ni de acuerdo ni en desacuerdo" 4 "De acuerdo" 5 "Totalmente de acuerdo"
	label values q9_4 q9_4

	label variable q9_5 "En el último mes en que recibió remesas, ¿quién guardó o administró la mayor par"
	note q9_5: "En el último mes en que recibió remesas, ¿quién guardó o administró la mayor parte de ese dinero?"
	label define q9_5 1 "Yo sola" 2 "Mi pareja o algún familiar en el hogar" 3 "Ambos (decisión conjunta con pareja u otro familiar)" 4 "Otra persona del hogar" 5 "Otra persona fuera del hogar" 98 "Prefiero no responder"
	label values q9_5 q9_5

	label variable q9_6 "Si usted quisiera destinar parte de la remesa a ahorro o a su negocio, ¿podría h"
	note q9_6: "Si usted quisiera destinar parte de la remesa a ahorro o a su negocio, ¿podría hacerlo sin pedir permiso a otra persona?"
	label define q9_6 1 "Sí, sin pedir permiso" 2 "Sí, pero debo avisar o acordar" 3 "No, otras personas deciden" 98 "Prefiero no responder"
	label values q9_6 q9_6

	label variable q9_7 "En general, me siento en control de mi dinero y de las decisiones sobre las reme"
	note q9_7: "En general, me siento en control de mi dinero y de las decisiones sobre las remesas."
	label define q9_7 1 "Totalmente en desacuerdo" 2 "En desacuerdo" 3 "Ni de acuerdo ni en desacuerdo" 4 "De acuerdo" 5 "Totalmente de acuerdo"
	label values q9_7 q9_7

	label variable q9_8 "En los últimos 12 meses, ¿alguna persona le pidió ver su teléfono o sus códigos "
	note q9_8: "En los últimos 12 meses, ¿alguna persona le pidió ver su teléfono o sus códigos (PIN/OTP) para manejar la remesa en contra de su voluntad?"
	label define q9_8 1 "Sí" 0 "No" 98 "Prefiero no responder"
	label values q9_8 q9_8

	label variable q9_9 "Si pudiera elegir libremente, ¿a nombre de quién preferiría que estuviera la cue"
	note q9_9: "Si pudiera elegir libremente, ¿a nombre de quién preferiría que estuviera la cuenta o billetera donde entra la remesa?"
	label define q9_9 1 "A mi cuenta personal" 2 "A una cuenta conjunta" 3 "A cuenta de otra persona" 4 "Me es indiferente" 98 "No sabe / No recuerda"
	label values q9_9 q9_9

	label variable q9_11 "En su hogar, ¿quién suele decidir sobre su atención de salud (visitas a médico, "
	note q9_11: "En su hogar, ¿quién suele decidir sobre su atención de salud (visitas a médico, exámenes, tratamientos)?"
	label define q9_11 1 "Yo sola" 2 "Yo y mi pareja / familiar (decisión conjunta)" 3 "Mi pareja o familiar" 4 "Otra persona" 98 "Prefiero no responder"
	label values q9_11 q9_11

	label variable q9_13 "En su hogar, ¿quién toma la decisión sobre los gastos importantes del hogar (por"
	note q9_13: "En su hogar, ¿quién toma la decisión sobre los gastos importantes del hogar (por ejemplo, electrodomésticos, arriendo, matrículas)?"
	label define q9_13 1 "Yo sola" 2 "Yo y mi pareja / familiar (decisión conjunta)" 3 "Mi pareja o familiar" 4 "Otra persona" 98 "Prefiero no responder"
	label values q9_13 q9_13

	label variable q9_15 "En mi hogar, se considera apropiado que las mujeres usen pagos digitales (app, Q"
	note q9_15: "En mi hogar, se considera apropiado que las mujeres usen pagos digitales (app, QR, transferencias)."
	label define q9_15 1 "Totalmente en desacuerdo" 2 "En desacuerdo" 3 "Ni de acuerdo ni en desacuerdo" 4 "De acuerdo" 5 "Totalmente de acuerdo"
	label values q9_15 q9_15

	label variable q9_16 "En los últimos 12 meses, ¿ha sentido presión de alguien para entregar todo el di"
	note q9_16: "En los últimos 12 meses, ¿ha sentido presión de alguien para entregar todo el dinero de la remesa o mostrar sus movimientos cuando usted no quería?"
	label define q9_16 1 "Sí" 0 "No" 98 "Prefiero no responder"
	label values q9_16 q9_16

	*Múltiple 8
	label variable q9_17 "Si usted rechaza compartir su PIN/OTP o su teléfono para manejar la remesa, ¿qué"
	note q9_17: "Si usted rechaza compartir su PIN/OTP o su teléfono para manejar la remesa, ¿qué podría ocurrir en su hogar?"

	label var q9_17_1 "Consecuencia: No pasaría nada"
	label var q9_17_2 "Consecuencia: Discusión o enojo"
	label var q9_17_3 "Consecuencia: Restricción de enojo"
	label var q9_17_4 "Consecuencia: Restricción de movilidad/comunicación"
	label var q9_17_5 "Consecuencia: Ninguna de las anteriores"
	label var q9_17_98 "Consecuencia: Prefiere no responder"	

	label variable q9_18 "En general, siento que mi opinión sobre el uso de la remesa es escuchada y respe"
	note q9_18: "En general, siento que mi opinión sobre el uso de la remesa es escuchada y respetada en mi hogar."
	label define q9_18 1 "Totalmente en desacuerdo" 2 "En desacuerdo" 3 "Ni de acuerdo ni en desacuerdo" 4 "De acuerdo" 5 "Totalmente de acuerdo"
	label values q9_18 q9_18

	label variable q9_19 "Si usted quisiera abrir una nueva cuenta o cambiar la cuenta donde llega la reme"
	note q9_19: "Si usted quisiera abrir una nueva cuenta o cambiar la cuenta donde llega la remesa, ¿podría decidirlo?"
	label define q9_19 1 "Sí, por mi cuenta" 2 "Sí, pero en conjunto con otra persona" 3 "No, deciden otras personas" 98 "Prefiero no responder"
	label values q9_19 q9_19

	label variable q9_20 "¿Ha evitado usar pagos digitales o aplicaciones por miedo a conflictos o discusi"
	note q9_20: "¿Ha evitado usar pagos digitales o aplicaciones por miedo a conflictos o discusiones dentro del hogar?"
	label define q9_20 1 "Sí" 0 "No" 98 "Prefiero no responder"
	label values q9_20 q9_20

	*Múltiple 9
	label variable q9_21 "¿Qué cambios harían más seguro para usted usar pagos digitales y evitar conflict"
	note q9_21: "¿Qué cambios harían más seguro para usted usar pagos digitales y evitar conflictos en el hogar?"

	label var q9_21_1 "Mejora: Más privacidad (ocultar saldos/notificaciones)"
	label var q9_21_2 "Mejora: Clave o biometría solo mía"
	label var q9_21_3 "Mejora: Educación para la familia"
	label var q9_21_4 "Mejora: Soporte o ayuda si hay coerción"
	label var q9_21_5 "Mejora: Otra"

	label variable q9_22 "En su comunidad, ¿la mayoría cree que las mujeres deben poder decidir sobre el u"
	note q9_22: "En su comunidad, ¿la mayoría cree que las mujeres deben poder decidir sobre el uso de las remesas del hogar?"
	label define q9_22 1 "Sí, la mayoría" 2 "Aproximadamente la mitad" 3 "Pocas personas" 4 "Casi nadie" 98 "No sabe / No recuerda"
	label values q9_22 q9_22

	*------------------------------------------------------------*
	*    Bloque 12 : G. Barreras, habilitadores y programas      *
	*------------------------------------------------------------*

	label variable q10_1 "¿Cuál diría que es el principal motivo por el cual no usa más pagos digitales (o"
	note q10_1: "¿Cuál diría que es el principal motivo por el cual no usa más pagos digitales (o no los usa en absoluto)?"
	label define q10_1 1 "No tengo teléfono propio" 2 "No tengo datos / internet" 3 "No confío en estos sistemas" 4 "No sé cómo usarlos" 5 "Costos o comisiones son altos" 6 "Documentos no aceptados" 7 "Mala señal de celular o servicio inestable" 8 "Agentes o cajeros lejos" 9 "Por familia / prefiero efectivo" 10 "Tuve malas experiencias o casos de fraude" 11 "Idioma o términos que no entiendo" 12 "Baja alfabetización" 14 "Miedo a equivocarme" 15 "Soporte o atención al cliente difícil de contactar" 16 "Ninguna de las anteriores" 98 "Prefiero no responder"
	label values q10_1 q10_1

	*Múltiple 10
	label variable q10_2 "Además de esa razón principal, ¿qué otras dificultades o barreras siente que enf"
	note q10_2: "Además de esa razón principal, ¿qué otras dificultades o barreras siente que enfrenta para usar pagos digitales?"

	label var q10_2_1 "Barrera: No tiene teléfono propio"
	label var q10_2_2 "Barrera: No tiene datos/internet"
	label var q10_2_3 "Barrera: No confia en estos sistemas"
	label var q10_2_4 "Barrera: No sabe cómo usarlos"
	label var q10_2_5 "Barrera: Costos o comisiones son altos"
	label var q10_2_6 "Barrera: Documentos no aceptados"
	label var q10_2_7 "Barrera: Mala señal de celular o servicio inestable"
	label var q10_2_8 "Barrera: Agentes o cajeros lejos"
	label var q10_2_9 "Barrera: Por familia/prefiero efectivo"
	label var q10_2_10 "Barrera: Tuvo malas experiencias/casos de fraude"
	label var q10_2_11 "Barrera: Idioma o términos que no entiende"
	label var q10_2_12 "Barrera: Baja alfabetización"
	label var q10_2_13 "Barrera: Miedo a equivocarse"
	label var q10_2_14 "Barrera: Miedo a equivocarse"
	label var q10_2_15 "Barrera: Soporte/atención al cliente difícil de contactar"
	label var q10_2_16 "Barrera: Ninguna de las anteriores"
	label var q10_2_98 "Barrera: Prefiere no responder"



	*Múltiple 11
	label variable q10_3 "Pensando en el futuro, ¿qué cambios o apoyos cree que más le ayudarían a usar pa"
	note q10_3: "Pensando en el futuro, ¿qué cambios o apoyos cree que más le ayudarían a usar pagos digitales con tranquilidad y frecuencia?"

	label var q10_3_1 "Cambio: Capacitación breve y práctica"
	label var q10_3_2 "Cambio: Acompañamiento de alguien de confianza"
	label var q10_3_3 "Comisiones más bajas/claras"
	label var q10_3_4 "Cambio: Mensajes claros y en español sencillo"
	label var q10_3_5 "Cambio: Biometría/PIN fácil de usar"
	label var q10_3_6 "Cambio: Agentes más cercanos"
	label var q10_3_7 "Cambio: Aceptación de QR en comercios"
	label var q10_3_8 "Cambio: Protección o seguridad ante fraudes"
	label var q10_3_9 "Cambio: Aceptación de documentos (PPT/CE)"
	label var q10_3_10 "Cambio: Ninguna de las anteriores"

	label variable q10_4 "En general, ¿cuánta información siente que tiene sobre comisiones, tipos de camb"
	note q10_4: "En general, ¿cuánta información siente que tiene sobre comisiones, tipos de cambio y qué hacer si tiene un problema con un pago digital o remesa?"
	label define q10_4 1 "Ninguna" 2 "Muy poca" 3 "Algo" 4 "Mucha"
	label values q10_4 q10_4

	label variable q10_6 "Pensando en los puntos donde retira efectivo (cash-out) cerca de su casa o traba"
	note q10_6: "Pensando en los puntos donde retira efectivo (cash-out) cerca de su casa o trabajo, ¿cómo describiría el tiempo y el costo adicional para retirar dinero que llega de forma digital?"
	label define q10_6 1 "Rápido y sin costo extra" 2 "Rápido pero con costo" 3 "Lento y con costo" 4 "Lento pero sin costo" 5 "No hay puntos cercanos que yo sepa" 98 "No sabe / No recuerda"
	label values q10_6 q10_6

	label variable q10_10 "En los últimos 3 años, ¿participó en alguna capacitación sobre pagos digitales, "
	note q10_10: "En los últimos 3 años, ¿participó en alguna capacitación sobre pagos digitales, remesas, billeteras o seguridad en línea?"
	label define q10_10 1 "Sí, en los últimos 12 meses" 2 "Sí, hace más de 12 meses" 3 "No, nunca" 98 "No sabe / No recuerda"
	label values q10_10 q10_10

	label variable q10_11 "¿Quién organizó la capacitación más reciente a la que asistió?"
	note q10_11: "¿Quién organizó la capacitación más reciente a la que asistió?"
	label define q10_11 1 "Gobierno (nacional o local)" 2 "Organismo de la sociedad civil / ONG" 3 "Banco o Cooperativa" 4 "Fintech" 5 "Otro (especifique)"
	label values q10_11 q10_11

	label variable q10_12 "Después de esa capacitación, ¿cómo cambió su disposición a usar pagos digitales "
	note q10_12: "Después de esa capacitación, ¿cómo cambió su disposición a usar pagos digitales o remesas por app?"
	label define q10_12 1 "Mucho menos" 2 "Algo menos" 3 "Sin cambio" 4 "Algo más" 5 "Mucho más"
	label values q10_12 q10_12

	label variable q10_13 "En los últimos 12 meses, ¿recibió acompañamiento individual para usar pagos digi"
	note q10_13: "En los últimos 12 meses, ¿recibió acompañamiento individual para usar pagos digitales o remesas? (por ejemplo, alguien que le ayudó a instalar una app, abrir cuenta, activar QR o hacer sus primeras operaciones)"
	label define q10_13 1 "Sí" 0 "No" 98 "Prefiero no responder"
	label values q10_13 q10_13

	label variable q10_14 "¿Quién le brindó ese acompañamiento individual la última vez?"
	note q10_14: "¿Quién le brindó ese acompañamiento individual la última vez?"
	label define q10_14 1 "Promotor comunitario" 2 "Peronal del banco o cooperativa" 3 "Fintech" 4 "Organismo de la sociedad civil / ONG" 5 "Familiar o amigo" 6 "Otra entidad"
	label values q10_14 q10_14

	label variable q10_16 "En los últimos 12 meses, ¿con qué frecuencia ha visto o usado materiales (follet"
	note q10_16: "En los últimos 12 meses, ¿con qué frecuencia ha visto o usado materiales (folletos, videos, mensajes por WhatsApp, redes sociales) sobre fraudes y uso seguro de pagos digitales?"
	label define q10_16 1 "Siempre" 2 "A menudo" 3 "Pocas veces" 4 "Nunca" 98 "No sabe / No recuerda"
	label values q10_16 q10_16

	*Múltiple 12 (error no activaron p10_17)
	label variable q10_17 "En su opinión, ¿qué temas debería priorizar una formación pensada especialmente "
	note q10_17: "En su opinión, ¿qué temas debería priorizar una formación pensada especialmente para mujeres migrantes sobre pagos digitales y remesas?"

	label var q10_17_1 "Tema a priorizar: Comisiones y límites"
	label var q10_17_2 "Tema a priorizar: Tiempos de abono"
	label var q10_17_3 "Tema a priorizar: Riesgos y cómo evitarlos"
	label var q10_17_4 "Tema a priorizar: Proceso de reclamos"
	label var q10_17_5 "Tema a priorizar: Ubicación de agentes"
	label var q10_17_6 "Tema a priorizar: Beneficios vs efectivo"
	label var q10_17_7 "Tema a priorizar: Otro"

	label variable q11_1 "¿Estaría dispuesto/a a ser contactado/a en el futuro para participar en un grupo"
	note q11_1: "¿Estaría dispuesto/a a ser contactado/a en el futuro para participar en un grupo focal/entrevista relacionado con los temas abordados en esta encuesta?"
	label define q11_1 1 "Sí" 0 "No" 98 "Prefiero no responder"
	label values q11_1 q11_1

	label variable q11_2 "Encuestador, ingrese nombre y apellido del entrevistado"
	note q11_2: "Encuestador, ingrese nombre y apellido del entrevistado"

	label variable q11_3 "Encuestador, ingrese el teléfono del entrevistado"
	note q11_3: "Encuestador, ingrese el teléfono del entrevistado"



