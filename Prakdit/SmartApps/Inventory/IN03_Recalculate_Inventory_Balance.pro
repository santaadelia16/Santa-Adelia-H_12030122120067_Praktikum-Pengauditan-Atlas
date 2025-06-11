COMMENT - Copyright Arbutus Software Inc. 2018
SET DEFAULT
SET ECHO NONE
SET SAFETY OFF
CLOSE PRIMARY ALL
DELETE ALL OK
DO SMARTAPPS_IN_HEADER_

DO .USER_INPUTS

SET FOLDER \Inventory Results

SUMMARIZE ON %prodnoentry% ACCUMULATE %valueentry% to %v_IN03_output% PRESORT OPEN
RETURN

PROCEDURE USER_INPUTS
DIALOG (DIALOG TITLE "%v_title_select_table%" WIDTH 373 HEIGHT 182 ) (BUTTONSET TITLE "&OK;&Cancel" AT 108 144 DEFAULT 1 HORZ ) (TEXT TITLE "%v_IN_text_title%" AT 36 24 ) (ITEM TITLE "f" TO "tablename" AT 156 22 WIDTH 189 HEIGHT 154 DEFAULT "%v_choose_table%" )

IF ftype(tablename 'f') <> 'f' PAUSE "%v_no_table_message%"
IF ftype(tablename 'f') <> 'f' RETURN ALL

OPEN %tablename%

DIALOG (DIALOG TITLE "%v_IN03_dialog2_title%" WIDTH 384 HEIGHT 215 ) (BUTTONSET TITLE "&OK;&Cancel" AT 120 168 DEFAULT 1 HORZ ) (TEXT TITLE "%v_IN03_dialog2_text1%" AT 36 48 ) (ITEM TITLE "C" TO "prodnoentry" AT 168 46 WIDTH 186 HEIGHT 78 DEFAULT "%v_choose_field%" ) (TEXT TITLE "%v_IN03_dialog2_text2%" AT 36 108 HEIGHT 15 ) (ITEM TITLE "N" TO "valueentry" AT 168 106 WIDTH 182 HEIGHT 65 DEFAULT "%v_choose_field%" )

IF isdefined(prodnoentry) = f or isdefined(valueentry) = f PAUSE "%v_invalid_field_message2%"
IF isdefined(prodnoentry) = f or isdefined(valueentry) = f RETURN ALL
RETURN

