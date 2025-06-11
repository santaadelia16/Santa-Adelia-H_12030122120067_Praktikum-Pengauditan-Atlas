COMMENT - Copyright Arbutus Software Inc. 2018
SET DEFAULT
SET ECHO NONE
SET SAFETY OFF
CLOSE PRIMARY ALL
DELETE ALL OK
DO SMARTAPPS_GL_HEADER_

DO .USER_INPUTS

SET FOLDER \General Ledger Results

IF RADIO1 = 1 EXTRACT RECORD TO %v_JE04_output% if DOW(%datefld%) = 6 OR DOW(%datefld%) = 7
IF RADIO1 = 2 EXTRACT RECORD TO %v_JE04_output% if DOW(%datefld%) = 7 OR DOW(%datefld%) = 1

IF WRITE1 = 0 PAUSE "%v_JE04_noresults_message%"
IF WRITE1 = 0 CLOSE
IF WRITE1 > 0 PAUSE "%v_JE04_results_message%"
IF WRITE1 > 0 OPEN %v_JE04_output%
RETURN

PROCEDURE USER_INPUTS
DIALOG (DIALOG TITLE "%v_title_select_table%" WIDTH 388 HEIGHT 190 ) (BUTTONSET TITLE "&OK;&Cancel" AT 120 144 DEFAULT 1 HORZ ) (TEXT TITLE "%v_JE_text_title%" AT 36 24 ) (ITEM TITLE "f" TO "tablename" AT 168 22 WIDTH 194 HEIGHT 154 DEFAULT "%v_choose_table%" )

IF ftype(tablename 'f') <> 'f' PAUSE "%v_no_table_message%"
IF ftype(tablename 'f') <> 'f' RETURN ALL

OPEN %tablename%

DIALOG (DIALOG TITLE "%v_JE04_dialog2_title%" WIDTH 340 HEIGHT 225 ) (BUTTONSET TITLE "&OK;&Cancel" AT 84 180 DEFAULT 1 HORZ ) (TEXT TITLE "%v_JE04_dialog2_text1%" AT 36 24 ) (ITEM TITLE "D" TO "datefld" AT 132 22 WIDTH 164 HEIGHT 148 DEFAULT "%v_choose_field%" )

DIALOG (DIALOG TITLE "%v_JE04_dialog3_title%" WIDTH 309 HEIGHT 290 ) (BUTTONSET TITLE "&OK;&Cancel" AT 180 168 DEFAULT 1 ) (TEXT TITLE "%v_JE04_dialog3_text1%" AT 36 36 ) (RADIOBUTTON TITLE "%v_JE04_dialog3_text2%" TO "RADIO1" AT 48 82 DEFAULT 2 )


IF isdefined(datefld) = f PAUSE "%v_invalid_field_message3%"
IF isdefined(datefld) = f RETURN ALL
RETURN

