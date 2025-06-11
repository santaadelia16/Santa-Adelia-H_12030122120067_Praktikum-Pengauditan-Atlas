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

EXTRACT RECORD TO %v_JE09_output% if BETWEEN(%date_entry% edit1 edit2) and %jsentry% = DROPDOWN1

IF WRITE1 = 0 PAUSE "%v_JE08_noresults_message%"
IF WRITE1 = 0 CLOSE
IF WRITE1 > 0 PAUSE "%v_JE08_results_message%"
IF WRITE1 > 0 OPEN %v_JE09_output%
RETURN

PROCEDURE USER_INPUTS
DIALOG (DIALOG TITLE "%v_title_select_table%" WIDTH 388 HEIGHT 190 ) (BUTTONSET TITLE "&OK;&Cancel" AT 120 144 DEFAULT 1 HORZ ) (TEXT TITLE "%v_JE_text_title%" AT 36 24 ) (ITEM TITLE "f" TO "tablename" AT 156 22 WIDTH 202 HEIGHT 154 DEFAULT "%v_choose_table%" )

IF ftype(tablename 'f') <> 'f' PAUSE "%v_no_table_message%"
IF ftype(tablename 'f') <> 'f' RETURN ALL

OPEN %tablename%

DIALOG (DIALOG TITLE "%v_JE09_dialog2_title%" WIDTH 392 HEIGHT 215 ) (BUTTONSET TITLE "&OK;&Cancel" AT 132 168 DEFAULT 1 HORZ ) (TEXT TITLE "%v_JE09_dialog2_text1%" AT 36 24 ) (ITEM TITLE "C" TO "jsentry" AT 180 22 WIDTH 180 HEIGHT 110 DEFAULT "%v_choose_field%" )

IF ftype(jsentry) = 'U' PAUSE "%v_invalid_field_message2%"
IF ftype(jsentry) = 'U' RETURN ALL

Classify on %jsentry% to Clean_JS OPEN
Save Field %jsentry% to JS_List
Close
Delete Format Clean_JS OK

DIALOG (DIALOG TITLE "%v_JE09_dialog3_title%" WIDTH 353 HEIGHT 218 ) (BUTTONSET TITLE "&OK;&Cancel" AT 108 180 DEFAULT 1 HORZ ) (TEXT TITLE "%v_JE09_dialog3_text1%" AT 36 36 ) (DROPDOWN TITLE JS_List TO "DROPDOWN1" AT 156 34 WIDTH 167 HEIGHT 23 )

OPEN %tablename%

DIALOG (DIALOG TITLE "%v_JE08_dialog2_title%" WIDTH 409 HEIGHT 203 ) (BUTTONSET TITLE "&OK;&Cancel" AT 132 156 DEFAULT 1 HORZ ) (TEXT TITLE "%v_JE08_dialog2_text1%" AT 24 60 ) (ITEM TITLE "D" TO "date_entry" AT 168 22 WIDTH 196 HEIGHT 152 DEFAULT "%v_choose_field%" ) (TEXT TITLE "%v_JE08_dialog2_text2%" AT 24 108 ) (EDIT TO "EDIT2" AT 168 106 WIDTH 215 DATE ) (EDIT TO "EDIT1" AT 168 58 WIDTH 214 DATE ) (TEXT TITLE "%v_JE04_dialog2_title%" AT 24 24 )

IF isdefined(date_entry) = f PAUSE "%v_invalid_field_message2%"
IF isdefined(date_entry) = f RETURN ALL
RETURN



