COMMENT - Copyright Arbutus Software Inc. 2018
SET DEFAULT
SET ECHO NONE
SET SAFETY OFF
CLOSE PRIMARY ALL
DELETE ALL OK
DO SMARTAPPS_GL_HEADER_

DO .USER_INPUTS

SET FOLDER \General Ledger Results

SUMMARIZE ON %accountentry% ACCUMULATE %amountentry% to %v_JE15_output% PRESORT OPEN
RETURN

PROCEDURE USER_INPUTS
DIALOG (DIALOG TITLE "%v_title_select_table%" WIDTH 388 HEIGHT 190 ) (BUTTONSET TITLE "&OK;&Cancel" AT 120 144 DEFAULT 1 HORZ ) (TEXT TITLE "%v_JE_text_title%" AT 36 24 ) (ITEM TITLE "f" TO "tablename" AT 156 22 WIDTH 202 HEIGHT 154 DEFAULT "%v_choose_table%" )

IF ftype(tablename 'f') <> 'f' PAUSE "%v_no_table_message%"
IF ftype(tablename 'f') <> 'f' RETURN ALL

OPEN %tablename%

DIALOG (DIALOG TITLE "%v_JE15_dialog2_title%" WIDTH 389 HEIGHT 213 ) (BUTTONSET TITLE "&OK;&Cancel" AT 120 168 DEFAULT 1 HORZ ) (TEXT TITLE "%v_JE15_dialog2_text1%" AT 36 36 ) (ITEM TITLE "C" TO "accountentry" AT 156 32 WIDTH 200 HEIGHT 186 DEFAULT "%v_choose_field%") (TEXT TITLE "%v_JE15_dialog2_text2%" AT 36 84 HEIGHT 17 ) (ITEM TITLE "N" TO "amountentry" AT 156 80 WIDTH 200 DEFAULT "%v_choose_field%")

IF isdefined(accountentry) = f or isdefined(amountentry) = f PAUSE "%v_invalid_field_message2%"
IF isdefined(accountentry) = f or isdefined(amountentry) = f RETURN ALL
RETURN


