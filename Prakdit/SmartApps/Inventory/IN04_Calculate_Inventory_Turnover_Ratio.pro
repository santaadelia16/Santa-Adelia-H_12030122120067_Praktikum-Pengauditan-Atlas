COMMENT - Copyright Arbutus Software Inc. 2018
SET DEFAULT
SET ECHO NONE
SET SAFETY OFF
CLOSE PRIMARY ALL
DELETE ALL OK
DO SMARTAPPS_IN_HEADER_

DO .USER_INPUTS

DEFINE FIELD Inventory_Turnover COMPUTED

%cogs%/((%BeginningInventory%+%EndingInventory%)/2%v_decimals%00) if %BeginningInventory%+%EndingInventory% <> 0
0%v_decimals%00

SET FOLDER \Inventory Results

EXTRACT ALL TO %v_IN04_output%
DELETE FIELD Inventory_Turnover OK
OPEN %v_IN04_output%
RETURN

PROCEDURE USER_INPUTS
DIALOG (DIALOG TITLE "%v_title_select_table%" WIDTH 373 HEIGHT 182 ) (BUTTONSET TITLE "&OK;&Cancel" AT 108 144 DEFAULT 1 HORZ ) (TEXT TITLE "%v_IN_text_title%" AT 36 24 ) (ITEM TITLE "f" TO "tablename" AT 144 22 WIDTH 190 HEIGHT 154 DEFAULT "%v_choose_table%" )

IF ftype(tablename 'f') <> 'f' PAUSE "%v_no_table_message%"
IF ftype(tablename 'f') <> 'f' RETURN ALL

OPEN %tablename%
DELETE FIELD Inventory_Turnover OK

DIALOG (DIALOG TITLE "%v_IN04_dialog2_title%" WIDTH 389 HEIGHT 221 ) (BUTTONSET TITLE "&OK;&Cancel" AT 120 180 DEFAULT 1 HORZ ) (TEXT TITLE "%v_IN04_dialog2_text1%" AT 24 24 ) (ITEM TITLE "N" TO "COGS" AT 180 22 WIDTH 188 HEIGHT 97 DEFAULT "%v_choose_field%" ) (TEXT TITLE "%v_IN04_dialog2_text2%" AT 24 132 ) (ITEM TITLE "N" TO "EndingInventory" AT 180 130 WIDTH 185 HEIGHT 71 DEFAULT "%v_choose_field%" ) (TEXT TITLE "%v_IN04_dialog2_text3%" AT 24 72 ) (ITEM TITLE "N" TO "BeginningInventory" AT 180 70 WIDTH 184 HEIGHT 21 DEFAULT "%v_choose_field%" )

IF isdefined(COGS) = f OR isdefined(BeginningInventory) = f OR isdefined(EndingInventory) = f PAUSE "%v_invalid_field_message3%"
IF isdefined(COGS) = f OR isdefined(BeginningInventory) = f OR isdefined(EndingInventory) = f RETURN ALL
RETURN

