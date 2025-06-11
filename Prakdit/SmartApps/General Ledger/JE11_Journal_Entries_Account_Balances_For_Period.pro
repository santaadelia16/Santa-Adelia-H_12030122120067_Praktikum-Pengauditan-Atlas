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

SUMMARIZE ON %jentry% ACCUMULATE %amountentry% to %v_JE11_output% PRESORT IF BETWEEN(%date_entry% edit1 edit2) OPEN

IF WRITE1 = 0 PAUSE "%v_JE08_noresults_message%"
IF WRITE1 = 0 CLOSE
IF WRITE1 > 0 PAUSE "%v_JE08_results_message%"
IF WRITE1 > 0 OPEN %v_JE11_output%
RETURN

PROCEDURE USER_INPUTS
DIALOG (DIALOG TITLE "%v_title_select_table%" WIDTH 388 HEIGHT 190 ) (BUTTONSET TITLE "&OK;&Cancel" AT 120 144 DEFAULT 1 HORZ ) (TEXT TITLE "%v_JE_text_title%" AT 36 24 ) (ITEM TITLE "f" TO "tablename" AT 168 22 WIDTH 196 HEIGHT 154 DEFAULT "%v_choose_table%" )

IF ftype(tablename 'f') <> 'f' PAUSE "%v_no_table_message%"
IF ftype(tablename 'f') <> 'f' RETURN ALL

OPEN %tablename%

DIALOG (DIALOG TITLE "%v_JE11_dialog2_title%" WIDTH 388 HEIGHT 218 ) (BUTTONSET TITLE "&OK;&Cancel" AT 120 168 DEFAULT 1 HORZ ) (TEXT TITLE "%v_JE01_dialog2_text1%" AT 36 36 ) (ITEM TITLE "C" TO "jentry" AT 156 32 WIDTH 200 HEIGHT 186 DEFAULT "%v_choose_field%") (TEXT TITLE "%v_JE01_dialog2_text2%" AT 36 84 HEIGHT 17 ) (ITEM TITLE "N" TO "amountentry" AT 156 80 WIDTH 200 DEFAULT "%v_choose_field%")

IF isdefined(jentry) = f or isdefined(amountentry) = f PAUSE "%v_invalid_field_message2%"
IF isdefined(jentry) = f or isdefined(amountentry) = f RETURN ALL

DIALOG (DIALOG TITLE "%v_JE08_dialog2_title%" WIDTH 406 HEIGHT 206 ) (BUTTONSET TITLE "&OK;&Cancel" AT 132 168 DEFAULT 1 HORZ ) (TEXT TITLE "%v_JE08_dialog2_text1%" AT 24 60 ) (ITEM TITLE "D" TO "date_entry" AT 180 22 WIDTH 193 HEIGHT 152 DEFAULT "%v_choose_field%" ) (TEXT TITLE "%v_JE08_dialog2_text2%" AT 24 108 ) (EDIT TO "EDIT2" AT 180 106 WIDTH 213 DATE ) (EDIT TO "EDIT1" AT 180 58 WIDTH 211 DATE ) (TEXT TITLE "%v_JE04_dialog2_title%" AT 24 24 )

IF isdefined(date_entry) = f PAUSE "%v_invalid_field_message2%"
IF isdefined(date_entry) = f RETURN ALL
RETURN


