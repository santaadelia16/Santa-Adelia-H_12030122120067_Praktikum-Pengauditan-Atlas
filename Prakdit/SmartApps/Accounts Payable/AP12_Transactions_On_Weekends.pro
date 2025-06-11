COMMENT - Copyright Arbutus Software Inc. 2018
SET DEFAULT
SET ECHO NONE
SET SAFETY OFF
CLOSE PRIMARY ALL
DELETE ALL OK
DO SMARTAPPS_AP_HEADER_

DO .USER_INPUTS

SET FOLDER \Accounts Payable Results

IF RADIO1 = 1 EXTRACT RECORD TO %v_AP12_output% if DOW(%datefld%)=6 OR DOW(%datefld%)=7
IF RADIO1 = 2 EXTRACT RECORD TO %v_AP12_output% if DOW(%datefld%)=7 OR DOW(%datefld%)=1

IF WRITE1=0 PAUSE "%v_no_weekend_trans%"
IF WRITE1=0 CLOSE
IF WRITE1>0 PAUSE "%v_weekend_trans%"
IF WRITE1>0 OPEN %v_AP12_output%
RETURN

PROCEDURE USER_INPUTS
DIALOG (DIALOG TITLE "%v_title_select_table%" WIDTH 425 HEIGHT 204 ) (BUTTONSET TITLE "&OK;&Cancel" AT 180 144 DEFAULT 1 HORZ ) (TEXT TITLE "%v_AP_text_title%" AT 36 24 ) (ITEM TITLE "f" TO "tablename" AT 180 20 WIDTH 220 DEFAULT "%v_choose_table%" )

IF ftype(tablename 'f')<>'f' PAUSE "%v_no_table_message%"
IF ftype(tablename 'f')<>'f' RETURN ALL

OPEN %tablename%

DIALOG (DIALOG TITLE "%v_AP12_dialog2_title%" WIDTH 340 HEIGHT 225 ) (BUTTONSET TITLE "&OK;&Cancel" AT 96 180 DEFAULT 1 HORZ ) (TEXT TITLE "%v_date_text%" AT 36 24 ) (ITEM TITLE "D" TO "datefld" AT 108 20 WIDTH 200 HEIGHT 148 DEFAULT "%v_choose_field%" )

DIALOG (DIALOG TITLE "%v_AP12_dialog3_title%" WIDTH 309 HEIGHT 290 ) (BUTTONSET TITLE "&OK;&Cancel" AT 180 168 DEFAULT 1 ) (TEXT TITLE "%v_AP12_dialog3_text1%" AT 36 36 ) (RADIOBUTTON TITLE "%v_AP12_dialog3_text2%" TO "RADIO1" AT 48 82 DEFAULT 2 )

IF isdefined(datefld)=f PAUSE "%v_invalid_field_message6%"
IF isdefined(datefld)=f RETURN ALL
RETURN
