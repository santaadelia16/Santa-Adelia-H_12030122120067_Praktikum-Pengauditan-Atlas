COMMENT - Copyright Arbutus Software Inc. 2018
SET DEFAULT
SET ECHO NONE
SET SAFETY OFF
CLOSE PRIMARY ALL
DELETE ALL OK
DO SMARTAPPS_GL_HEADER_

DO .USER_INPUTS

SET FOLDER \General Ledger Results

EXTRACT RECORD TO %v_JE12_output% if %amount_entry% >= EDIT1

IF WRITE1 = 0 PAUSE "%v_JE12_noresults_message%"
IF WRITE1 = 0 CLOSE
IF WRITE1 > 0 PAUSE "%v_JE12_results_message%"
IF WRITE1 > 0 OPEN %v_JE12_output%
RETURN

PROCEDURE USER_INPUTS
DIALOG (DIALOG TITLE "%v_title_select_table%" WIDTH 388 HEIGHT 190 ) (BUTTONSET TITLE "&OK;&Cancel" AT 120 144 DEFAULT 1 HORZ ) (TEXT TITLE "%v_JE_text_title%" AT 36 24 ) (ITEM TITLE "f" TO "tablename" AT 168 22 WIDTH 200 HEIGHT 154 DEFAULT "%v_choose_table%" )

IF ftype(tablename 'f') <> 'f' PAUSE "%v_no_table_message%"
IF ftype(tablename 'f') <> 'f' RETURN ALL

OPEN %tablename%

DIALOG (DIALOG TITLE "%v_JE12_dialog2_title%" WIDTH 395 HEIGHT 221 ) (BUTTONSET TITLE "&OK;&Cancel" AT 120 180 DEFAULT 1 HORZ ) (TEXT TITLE "%v_JE12_dialog2_text1%" AT 24 60 WIDTH 111 HEIGHT 48 ) (ITEM TITLE "N" TO "amount_entry" AT 168 20 WIDTH 200 HEIGHT 152 DEFAULT "%v_choose_field%" ) (EDIT TO "EDIT1" AT 168 60 WIDTH 200 DEFAULT "25000" NUM ) (TEXT TITLE "%v_JE12_dialog2_text2%" AT 24 24 )

IF isdefined(amount_entry) = f PAUSE "%v_invalid_field_message2%"
IF isdefined(amount_entry) = f RETURN ALL
RETURN


