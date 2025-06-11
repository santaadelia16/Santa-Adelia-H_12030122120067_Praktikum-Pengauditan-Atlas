COMMENT - Copyright Arbutus Software Inc. 2018
SET DEFAULT
SET ECHO NONE
SET SAFETY OFF
CLOSE PRIMARY ALL
DEL ALL OK
DO SMARTAPPS_FA_HEADER_

DO .USER_INPUTS

SET FOLDER \Fixed Assets Results

SUMMARIZE ON %assetentry% ACCUMULATE %valueentry% to %v_FA02_output% PRESORT OPEN
RETURN

PROCEDURE USER_INPUTS
DIALOG (DIALOG TITLE "%v_title_select_table%" WIDTH 417 HEIGHT 187 ) (BUTTONSET TITLE "&OK;&Cancel" AT 156 144 DEFAULT 1 HORZ ) (TEXT TITLE "%v_FA_text_title%" AT 36 24 ) (ITEM TITLE "f" TO "tablename" AT 156 20 WIDTH 220 HEIGHT 154 DEFAULT "%v_choose_table%" )

IF ftype(tablename 'f')<>'f' PAUSE "%v_no_table_message%"
IF ftype(tablename 'f')<>'f' RETURN ALL

OPEN %tablename%

DIALOG (DIALOG TITLE "%v_title_select_fields%" WIDTH 400 HEIGHT 227 ) (BUTTONSET TITLE "&OK;&Cancel" AT 144 180 DEFAULT 1 HORZ ) (TEXT TITLE "%v_FA02_dialog2_text1%" AT 36 48 ) (ITEM TITLE "C" TO "assetentry" AT 156 44 WIDTH 200 HEIGHT 78 DEFAULT "%v_choose_field%" ) (TEXT TITLE "%v_FA02_dialog2_text2%" AT 36 108 HEIGHT 15 ) (ITEM TITLE "N" TO "valueentry" AT 156 104 WIDTH 200 HEIGHT 65 DEFAULT "%v_choose_field%" )

IF isdefined(assetentry)=f or isdefined(valueentry)=f PAUSE "%v_invalid_field_message1%"
IF isdefined(assetentry)=f or isdefined(valueentry)=f RETURN ALL
RETURN

