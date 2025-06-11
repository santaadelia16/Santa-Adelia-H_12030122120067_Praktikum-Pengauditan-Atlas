COMMENT - Copyright Arbutus Software Inc. 2018
SET DEFAULT
SET ECHO NONE
SET SAFETY OFF
CLOSE PRIMARY ALL
DELETE ALL OK
DO SMARTAPPS_IN_HEADER_

DO .USER_INPUTS

SET FOLDER \Inventory Results

DUPLICATES ON %key1% %key2% %key3% %key4% TO %v_IN13_output% PRESORT errorlimit errorentry

IF WRITE1=0 PAUSE "%v_IN13_noresults_message%"
IF WRITE1=0 CLOSE
IF WRITE1>0 PAUSE "%v_IN13_results_message%"
IF WRITE1>0 OPEN %v_IN13_output%
RETURN

PROCEDURE USER_INPUTS
DIALOG (DIALOG TITLE "%v_title_select_table%" WIDTH 373 HEIGHT 182 ) (BUTTONSET TITLE "&OK;&Cancel" AT 108 144 DEFAULT 1 HORZ ) (TEXT TITLE "%v_IN_text_title%" AT 36 24 ) (ITEM TITLE "f" TO "tablename" AT 144 22 WIDTH 190 HEIGHT 154 DEFAULT "%v_choose_table%" )

IF ftype(tablename 'f') <> 'f' PAUSE "%v_no_table_message%"
IF ftype(tablename 'f') <> 'f' RETURN ALL

OPEN %tablename%

DIALOG (DIALOG TITLE "%v_IN13_dialog2_title%" WIDTH 965 HEIGHT 285 ) (BUTTONSET TITLE "&OK;&Cancel" AT 432 240 DEFAULT 1 HORZ ) (TEXT TITLE "%v_IN13_dialog2_text1%" AT 72 96 ) (TEXT TITLE "%v_IN13_dialog2_text2%" AT 288 96 ) (TEXT TITLE "%v_IN13_dialog2_text3%" AT 504 96 ) (TEXT TITLE "%v_IN13_dialog2_text4%" AT 720 96 ) (ITEM TITLE "CND" TO "Key1" AT 72 128 WIDTH 200 DEFAULT "%v_choose_field%" ) (ITEM TITLE "CND" TO "key2" AT 288 128 WIDTH 200 DEFAULT "%v_choose_field%" ) (ITEM TITLE "CND" TO "key3" AT 504 128 WIDTH 200 DEFAULT "%v_choose_field%" ) (ITEM TITLE "CND" TO "key4" AT 720 128 WIDTH 200 DEFAULT "%v_choose_field%" ) (TEXT TITLE "%v_IN13_dialog2_text5%" AT 72 48 ) (TEXT TITLE "**********************************************************" AT 72 72 WIDTH 230 )

IF isdefined(key1) = f AND isdefined(key2) = f AND isdefined(key3) = f AND isdefined(key4) = f PAUSE "%v_invalid_field_message4%"
IF isdefined(key1) = f AND isdefined(key2) = f AND isdefined(key1) = f AND isdefined(key4) = f RETURN ALL
IF isdefined(key1) = f key1 = ""
IF isdefined(key2) = f key2 = ""
IF isdefined(key3) = f key3 = ""
IF isdefined(key4) = f key4 = ""

DIALOG (DIALOG TITLE "%v_IN13_dialog3_title%" WIDTH 382 HEIGHT 186 ) (BUTTONSET TITLE "&OK;&Cancel" AT 120 144 DEFAULT 1 HORZ ) (TEXT TITLE "%v_IN13_dialog3_text1%" AT 60 48 WIDTH 110 HEIGHT 63 ) (EDIT TO "errorentry" AT 228 48 DEFAULT "20" NUM )
RETURN

