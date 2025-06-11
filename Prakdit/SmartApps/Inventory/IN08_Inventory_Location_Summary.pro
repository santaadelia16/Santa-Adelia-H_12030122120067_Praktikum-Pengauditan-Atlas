COMMENT - Copyright Arbutus Software Inc. 2018
SET DEFAULT
SET ECHO NONE
SET SAFETY OFF
CLOSE PRIMARY ALL
DELETE ALL OK
DO SMARTAPPS_IN_HEADER_

DO .USER_INPUTS

SET FOLDER \Inventory Results

SUMMARIZE ON %locentry% ACCUMULATE %amountentry% to %v_IN08_output% PRESORT OPEN
RETURN

PROCEDURE USER_INPUTS
DIALOG (DIALOG TITLE "%v_title_select_table%" WIDTH 373 HEIGHT 182 ) (BUTTONSET TITLE "&OK;&Cancel" AT 108 144 DEFAULT 1 HORZ ) (TEXT TITLE "%v_IN_text_title%" AT 36 24 ) (ITEM TITLE "f" TO "tablename" AT 144 22 WIDTH 194 HEIGHT 154 DEFAULT "%v_choose_table%" )

IF ftype(tablename 'f') <> 'f' PAUSE "%v_no_table_message%"
IF ftype(tablename 'f') <> 'f' RETURN ALL

OPEN %tablename%

DIALOG (DIALOG TITLE "%v_IN08_dialog2_title%" WIDTH 394 HEIGHT 226 ) (BUTTONSET TITLE "&OK;&Cancel" AT 132 180 DEFAULT 1 HORZ ) (TEXT TITLE "%v_IN08_dialog2_text1%" AT 36 48 ) (ITEM TITLE "C" TO "locentry" AT 156 44 WIDTH 200 HEIGHT 78 DEFAULT "%v_choose_field%" ) (TEXT TITLE "%v_IN08_dialog2_text2%" AT 36 108 HEIGHT 15 ) (ITEM TITLE "N" TO "amountentry" AT 156 104 WIDTH 200 HEIGHT 65 DEFAULT "%v_choose_field%" )

IF isdefined(locentry) = f or isdefined(amountentry) = f PAUSE "%v_invalid_field_message2%"
IF isdefined(locentry) = f or isdefined(amountentry) = f RETURN ALL
RETURN

