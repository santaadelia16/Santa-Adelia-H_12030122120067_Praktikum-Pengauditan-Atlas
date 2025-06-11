COMMENT - Copyright Arbutus Software Inc. 2018
SET DEFAULT
SET ECHO NONE
SET SAFETY OFF
CLOSE PRIMARY ALL
DELETE ALL OK
DO SMARTAPPS_GL_HEADER_

DO .USER_INPUTS

START_DATE = DATE(%edit1%)
END_DATE = DATE(%edit2%)

SET FOLDER \General Ledger Results

EXTRACT RECORD TO %v_JE08_output% if BETWEEN(%date_entry% edit1 edit2)

IF WRITE1 = 0 PAUSE "%v_JE08_noresults_message%"
IF WRITE1 = 0 CLOSE
IF WRITE1 > 0 PAUSE "%v_JE08_results_message%"
IF WRITE1 > 0 OPEN %v_JE08_output%
RETURN

PROCEDURE USER_INPUTS
DIALOG (DIALOG TITLE "%v_title_select_table%" WIDTH 388 HEIGHT 190 ) (BUTTONSET TITLE "&OK;&Cancel" AT 120 144 DEFAULT 1 HORZ ) (TEXT TITLE "%v_JE_text_title%" AT 36 24 ) (ITEM TITLE "f" TO "tablename" AT 168 22 WIDTH 198 HEIGHT 154 DEFAULT "%v_choose_table%" )

IF ftype(tablename 'f') <> 'f' PAUSE "%v_no_table_message%"
IF ftype(tablename 'f') <> 'f' RETURN ALL

OPEN %tablename%

DIALOG (DIALOG TITLE "%v_JE08_dialog2_title%" WIDTH 400 HEIGHT 221 ) (BUTTONSET TITLE "&OK;&Cancel" AT 132 168 DEFAULT 1 HORZ ) (TEXT TITLE "%v_JE08_dialog2_text1%" AT 24 60 ) (ITEM TITLE "D" TO "date_entry" AT 168 20 WIDTH 200 HEIGHT 152 DEFAULT "%v_choose_field%" ) (TEXT TITLE "%v_JE08_dialog2_text2%" AT 24 108 ) (EDIT TO "EDIT2" AT 168 106 WIDTH 213 DATE ) (EDIT TO "EDIT1" AT 168 58 WIDTH 214 DATE ) (TEXT TITLE "%v_JE04_dialog2_title%" AT 24 24 )

IF isdefined(date_entry) = f PAUSE "%v_invalid_field_message2%"
IF isdefined(date_entry) = f RETURN ALL
RETURN


