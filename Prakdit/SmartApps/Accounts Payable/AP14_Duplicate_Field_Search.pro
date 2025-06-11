COMMENT - Copyright Arbutus Software Inc. 2018
SET DEFAULT
SET ECHO NONE
SET SAFETY OFF
CLOSE PRIMARY ALL
DELETE ALL OK
DO SMARTAPPS_AP_HEADER_

DO .USER_INPUTS

SET FOLDER \Accounts Payable Results

DUPLICATES ON %key1% %key2% %key3% %key4% TO %v_AP14_output% PRESORT errorlimit errorentry

IF WRITE1=0 PAUSE "%v_no_dupe_customers%"
IF WRITE1=0 CLOSE
IF WRITE1>0 PAUSE "%v_dupe_customers%"
IF WRITE1>0 OPEN %v_AP14_output%
RETURN

PROCEDURE USER_INPUTS
DIALOG (DIALOG TITLE "%v_title_select_table%" WIDTH 425 HEIGHT 204 ) (BUTTONSET TITLE "&OK;&Cancel" AT 180 144 DEFAULT 1 HORZ ) (TEXT TITLE "%v_AP_text_title%" AT 36 24 ) (ITEM TITLE "f" TO "tablename" AT 180 20 WIDTH 220 DEFAULT "%v_choose_table%" )

IF ftype(tablename 'f')<>'f' PAUSE "%v_no_table_message%"
IF ftype(tablename 'f')<>'f' RETURN ALL

OPEN %tablename%

DIALOG (DIALOG TITLE "%v_AP14_dialog2_title%" WIDTH 984 HEIGHT 305 ) (BUTTONSET TITLE "&OK;&Cancel" AT 432 240 DEFAULT 1 HORZ ) (TEXT TITLE "%v_key1%" AT 72 96 ) (TEXT TITLE "%v_key2%" AT 288 96 ) (TEXT TITLE "%v_key3%" AT 516 96 ) (TEXT TITLE "%v_key4%" AT 732 96 ) (ITEM TITLE "CND" TO "Key1" AT 72 128 WIDTH 200 DEFAULT "%v_choose_field%" ) (ITEM TITLE "CND" TO "key2" AT 288 128 WIDTH 200 DEFAULT "%v_choose_field%" ) (ITEM TITLE "CND" TO "key3" AT 516 128 WIDTH 200 DEFAULT "%v_choose_field%" ) (ITEM TITLE "CND" TO "key4" AT 732 128 WIDTH 200 DEFAULT "%v_choose_field%" ) (TEXT TITLE "%v_AP14_dialog2_text%" AT 72 48 ) (TEXT TITLE "**********************************************************" AT 72 72 WIDTH 230 )

IF isdefined(key1)=f key1=""
IF isdefined(key2)=f key2=""
IF isdefined(key3)=f key3=""
IF isdefined(key4)=f key4=""
IF key1="" AND key2="" AND key3="" AND key4="" PAUSE "%v_invalid_field_message2%"
IF key1="" AND key2="" AND key3="" AND key4="" RETURN ALL

DIALOG (DIALOG TITLE "%v_AP14_dialog3_title%" WIDTH 382 HEIGHT 186 ) (BUTTONSET TITLE "&OK;&Cancel" AT 120 144 DEFAULT 1 HORZ ) (TEXT TITLE "%v_AP14_dialog3_text%" AT 60 48 WIDTH 110 HEIGHT 65 ) (EDIT TO "errorentry" AT 228 48 DEFAULT "20" NUM )
RETURN
