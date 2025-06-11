COMMENT - Copyright Arbutus Software Inc. 2018
SET DEFAULT
SET ECHO NONE
SET SAFETY OFF
CLOSE PRIMARY ALL
DEL ALL OK
DO SMARTAPPS_FA_HEADER_

DO .USER_INPUTS

DEFINE FIELD RECALC_DEP COMPUTED

(%costentry%-%salvageentry%)/%assetlifeentry% IF %assetlifeentry% <> 0
0%v_decimals%00

SET FOLDER \Fixed Assets Results

EXTRACT %costentry% %salvageentry% %assetlifeentry% %depentry% RECALC_DEP TO %v_FA03_output% IF recalc_dep<>%depentry%

IF WRITE1=0 PAUSE "%v_FA03_results_message1%"
IF WRITE1=0 CLOSE
IF WRITE1>0 PAUSE "%v_FA03_results_message2%"
IF WRITE1>0 OPEN %v_FA03_output%
RETURN





PROCEDURE USER_INPUTS
DIALOG (DIALOG TITLE "%v_title_select_table%" WIDTH 415 HEIGHT 188 ) (BUTTONSET TITLE "&OK;&Cancel" AT 144 144 DEFAULT 1 HORZ ) (TEXT TITLE "%v_FA_text_title%" AT 36 24 ) (ITEM TITLE "f" TO "tablename" AT 144 20 WIDTH 220 HEIGHT 154 DEFAULT "%v_choose_table%" )

IF ftype(tablename 'f')<>'f' PAUSE "%v_no_table_message%"
IF ftype(tablename 'f')<>'f' RETURN ALL

OPEN %tablename%
DELETE FIELD RECALC_DEP OK

DIALOG (DIALOG TITLE "%v_title_select_fields%" WIDTH 389 HEIGHT 298 ) (BUTTONSET TITLE "&OK;&Cancel" AT 132 264 DEFAULT 1 HORZ ) (TEXT TITLE "%v_FA03_dialog2_text1%" AT 36 12 ) (ITEM TITLE "N" TO "costentry" AT 156 8 WIDTH 200 HEIGHT 97 DEFAULT "%v_choose_field%" ) (TEXT TITLE "%v_FA03_dialog2_text2%" AT 36 132 ) (TEXT TITLE "%v_FA03_dialog2_text3%" AT 36 72 ) (ITEM TITLE "N" TO "assetlifeentry" AT 156 128 WIDTH 200 DEFAULT "%v_choose_field%" ) (ITEM TITLE "N" TO "salvageentry" AT 156 68 WIDTH 200 DEFAULT "%v_choose_field%" ) (TEXT TITLE "%v_FA03_dialog2_text4%" AT 36 192 ) (ITEM TITLE "N" TO "depentry" AT 156 188 WIDTH 200 HEIGHT 70 DEFAULT "%v_choose_field%" )

IF isdefined(costentry)=f OR isdefined(salvageentry)=f OR isdefined(assetlifeentry)=f OR isdefined(depentry)=f PAUSE "%v_invalid_field_message2%"
IF isdefined(costentry)=f OR isdefined(salvageentry)=f OR isdefined(assetlifeentry)=f OR isdefined(depentry)=f RETURN ALL
RETURN

