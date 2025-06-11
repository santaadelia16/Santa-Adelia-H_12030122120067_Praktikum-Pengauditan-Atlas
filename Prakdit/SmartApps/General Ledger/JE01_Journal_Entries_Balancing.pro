COMMENT - Copyright Arbutus Software Inc. 2018
SET DEFAULT
SET ECHO NONE
SET SAFETY OFF
SET TEMP "TEMP_"
CLOSE PRIMARY ALL
DELETE ALL OK
DO SMARTAPPS_GL_HEADER_

DO .USER_INPUTS

CLASSIFY ON %jentry% AS jentry ACCUMULATE %amtfld% TO Temp_junk1001 OPEN

EXTRACT RECORD TO Temp_junk1002 if %amtfld%<>0

OPEN %tablename%
OPEN Temp_junk1002 SECONDARY

SET FOLDER \General Ledger Results

JOIN PKEY %jentry% SKEY %jentry% FIELDS ALL TO %v_JE01_output% PRESORT

CLOSE SECONDARY

DELETE TEMP OK

IF WRITE1 = 0 PAUSE "%v_JE01_noresults_message%"
IF WRITE1 = 0 CLOSE
IF WRITE1 > 0 PAUSE "%v_JE01_results_message%"
IF WRITE1 > 0 OPEN %v_JE01_output%
RETURN

PROCEDURE USER_INPUTS
DIALOG (DIALOG TITLE "%v_title_select_table%" WIDTH 396 HEIGHT 179 ) (BUTTONSET TITLE "&OK;&Cancel" AT 156 144 DEFAULT 1 HORZ ) (TEXT TITLE "%v_JE_text_title%" AT 36 24 ) (ITEM TITLE "f" TO "tablename" AT 156 20 WIDTH 200 HEIGHT 154 DEFAULT "%v_choose_table%" )

IF ftype(tablename 'f') <> 'f' PAUSE "%v_no_table_message%"
IF ftype(tablename 'f') <> 'f' RETURN ALL

OPEN %tablename%

DIALOG (DIALOG TITLE "%v_JE01_dialog2_title%" WIDTH 410 HEIGHT 211 ) (BUTTONSET TITLE "&OK;&Cancel" AT 156 168 DEFAULT 1 HORZ ) (TEXT TITLE "%v_JE01_dialog2_text1%" AT 36 24 ) (ITEM TITLE "C" TO "jentry" AT 156 20 WIDTH 200 HEIGHT 186 DEFAULT "%v_choose_field%" ) (TEXT TITLE "%v_JE01_dialog2_text2%" AT 36 60 ) (ITEM TITLE "N" TO "amtfld" AT 156 56 WIDTH 200 HEIGHT 148 DEFAULT "%v_choose_field%" )

IF isdefined(jentry) = f or isdefined(amtfld) = f PAUSE "%v_invalid_field_message2%"
IF isdefined(jentry) = f or isdefined(amtfld) = f RETURN ALL
RETURN


