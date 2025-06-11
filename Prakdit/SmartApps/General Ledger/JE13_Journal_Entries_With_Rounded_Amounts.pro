COMMENT - Copyright Arbutus Software Inc. 2018
SET DEFAULT
SET ECHO NONE
SET SAFETY OFF
CLOSE PRIMARY ALL
DELETE ALL OK
DO SMARTAPPS_GL_HEADER_

DO .USER_INPUTS

SET FOLDER \General Ledger Results

EXTRACT RECORD TO %v_JE13_output% if round(%amount_entry%) = %amount_entry%

IF WRITE1 = 0 PAUSE "%v_JE13_noresults_message%"
IF WRITE1 = 0 CLOSE
IF WRITE1 > 0 PAUSE "%v_JE13_results_message%"
IF WRITE1 > 0 OPEN %v_JE13_output%
RETURN

PROCEDURE USER_INPUTS
DIALOG (DIALOG TITLE "%v_title_select_table%" WIDTH 388 HEIGHT 190 ) (BUTTONSET TITLE "&OK;&Cancel" AT 120 144 DEFAULT 1 HORZ ) (TEXT TITLE "%v_JE_text_title%" AT 36 24 ) (ITEM TITLE "f" TO "tablename" AT 156 22 WIDTH 206 HEIGHT 154 DEFAULT "%v_choose_table%" )

IF ftype(tablename 'f') <> 'f' PAUSE "%v_no_table_message%"
IF ftype(tablename 'f') <> 'f' RETURN ALL

OPEN %tablename%

DIALOG (DIALOG TITLE "%v_JE13_dialog2_title%" WIDTH 366 HEIGHT 217 ) (BUTTONSET TITLE "&OK;&Cancel" AT 108 168 DEFAULT 1 HORZ ) (ITEM TITLE "N" TO "amount_entry" AT 144 32 WIDTH 200 HEIGHT 152 DEFAULT "%v_choose_field%") (TEXT TITLE "%v_JE12_dialog2_text2%" AT 24 36 )

IF isdefined(amount_entry) = f PAUSE "%v_invalid_field_message2%"
IF isdefined(amount_entry) = f RETURN ALL
RETURN


