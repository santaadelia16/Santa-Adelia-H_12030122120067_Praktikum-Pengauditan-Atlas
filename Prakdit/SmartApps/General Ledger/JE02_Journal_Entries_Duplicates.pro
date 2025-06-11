COMMENT - Copyright Arbutus Software Inc. 2018
SET DEFAULT
SET ECHO NONE
SET SAFETY OFF
CLOSE PRIMARY ALL
DELETE ALL OK
DO SMARTAPPS_GL_HEADER_

DO .USER_INPUTS

SET FOLDER \General Ledger Results

DUPLICATES ON %jentry% AS "Journal_Entry" OTHER ALL TO %v_JE02_output% PRESORT

IF WRITE1 = 0 PAUSE "%v_JE02_noresults_message%"
IF WRITE1 = 0 CLOSE
IF WRITE1 > 0 PAUSE "%v_JE02_results_message%"
IF WRITE1 > 0 OPEN %v_JE02_output%
RETURN

PROCEDURE USER_INPUTS
DIALOG (DIALOG TITLE "%v_title_select_table%" WIDTH 388 HEIGHT 190 ) (BUTTONSET TITLE "&OK;&Cancel" AT 120 144 DEFAULT 1 HORZ ) (TEXT TITLE "%v_JE_text_title%" AT 36 24 ) (ITEM TITLE "f" TO "tablename" AT 144 20 WIDTH 220 HEIGHT 154 DEFAULT "%v_choose_table%")

IF ftype(tablename 'f') <> 'f' PAUSE "%v_no_table_message%"
IF ftype(tablename 'f') <> 'f' RETURN ALL

OPEN %tablename%

DIALOG (DIALOG TITLE "%v_JE02_dialog2_title%" WIDTH 379 HEIGHT 221 ) (BUTTONSET TITLE "&OK;&Cancel" AT 120 180 DEFAULT 1 HORZ ) (TEXT TITLE "%v_JE01_dialog2_text1%" AT 36 24 ) (ITEM TITLE "C" TO "jentry" AT 156 20 WIDTH 200 HEIGHT 186 DEFAULT "%v_choose_field%")

IF isdefined(jentry) = f PAUSE "%v_invalid_field_message2%"
IF isdefined(jentry) = f RETURN ALL
RETURN

