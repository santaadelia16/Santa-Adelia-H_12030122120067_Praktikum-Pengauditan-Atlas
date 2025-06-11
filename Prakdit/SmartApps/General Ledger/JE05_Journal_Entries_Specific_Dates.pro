COMMENT - Copyright Arbutus Software Inc. 2018
SET DEFAULT
SET ECHO NONE
SET SAFETY OFF
CLOSE PRIMARY ALL
DELETE ALL OK
DO SMARTAPPS_GL_HEADER_

DO .USER_INPUTS

SET FOLDER \General Ledger Results

EXTRACT RECORD TO %v_JE05_output% if BETWEEN(%datefld% datevar1 datevar2)

IF WRITE1=0 PAUSE "%v_JE05_noresults_message%"
IF WRITE1=0 CLOSE
IF WRITE1>0 PAUSE "%v_JE05_results_message%"
IF WRITE1>0 OPEN %v_JE05_output%
RETURN

PROCEDURE USER_INPUTS
DIALOG (DIALOG TITLE "%v_title_select_table%" WIDTH 405 HEIGHT 188 ) (BUTTONSET TITLE "&OK;&Cancel" AT 132 144 DEFAULT 1 HORZ ) (TEXT TITLE "%v_JE_text_title%" AT 36 24 ) (ITEM TITLE "f" TO "tablename" AT 180 22 WIDTH 187 HEIGHT 154 DEFAULT "%v_choose_table%" )

IF ftype(tablename 'f') <> 'f' PAUSE "%v_no_table_message%"
IF ftype(tablename 'f') <> 'f' RETURN ALL

OPEN %tablename%

DIALOG (DIALOG TITLE "%v_JE05_dialog2_title%" WIDTH 425 HEIGHT 214 ) (BUTTONSET TITLE "&OK;&Cancel" AT 156 180 DEFAULT 1 HORZ ) (TEXT TITLE "%v_JE05_dialog2_text1%" AT 36 84 ) (EDIT TO "DateVar1" AT 180 82 WIDTH 212 DATE ) (EDIT TO "datevar2" AT 180 130 WIDTH 211 DATE ) (TEXT TITLE "%v_JE05_dialog2_text2%" AT 36 132 ) (TEXT TITLE "%v_JE04_dialog2_text1%" AT 36 36 ) (ITEM TITLE "D" TO "datefld" AT 180 34 WIDTH 200 DEFAULT "%v_choose_field%" )

IF isdefined(datefld) = f PAUSE "%v_invalid_field_message3%"
IF isdefined(datefld) = f RETURN ALL
RETURN

