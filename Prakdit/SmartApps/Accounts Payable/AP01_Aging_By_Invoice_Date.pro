COMMENT - Copyright Arbutus Software Inc. 2018
SET DEFAULT
SET ECHO NONE
SET SAFETY OFF
CLOSE PRIMARY ALL
DELETE ALL OK
DO SMARTAPPS_AP_HEADER_
SET DATE "%v_date_settings%"

DO .USER_INPUTS

PAUSE "%v_AP01_results_message%"

SET ECHO ON

AGE ON %dateentry1% CUTOFF DATE(DATE1) INTERVAL %v_aging_periods% ACCUMULATE %amount1%

CLOSE
RETURN

PROCEDURE USER_INPUTS
DIALOG (DIALOG TITLE "%v_title_select_table%" WIDTH 425 HEIGHT 204 ) (BUTTONSET TITLE "&OK;&Cancel" AT 180 144 DEFAULT 1 HORZ ) (TEXT TITLE "%v_AP_text_title%" AT 36 24 ) (ITEM TITLE "f" TO "tablename" AT 180 20 WIDTH 220 DEFAULT "%v_choose_table%" )

IF ftype(tablename 'f')<>'f' PAUSE "%v_no_table_message%"
IF ftype(tablename 'f')<>'f' RETURN ALL

OPEN %tablename%

DIALOG (DIALOG TITLE "%v_AP01_dialog2_title%" WIDTH 406 HEIGHT 224 ) (BUTTONSET TITLE "&OK;&Cancel" AT 132 180 DEFAULT 1 HORZ ) (TEXT TITLE "%v_AP01_field1%" AT 36 12 ) (ITEM TITLE "D" TO "dateentry1" AT 180 10 WIDTH 167 HEIGHT 97 DEFAULT "%v_choose_field%" ) (EDIT TO "Date1" AT 180 70 WIDTH 206 HEIGHT 25 DEFAULT "%v_cutoff_date%" DATE ) (TEXT TITLE "%v_AP01_aging_date%" AT 36 72 ) (TEXT TITLE "%v_AP01_field2%" AT 36 132 ) (ITEM TITLE "N" TO "amount1" AT 180 130 WIDTH 168 HEIGHT 48 DEFAULT "%v_choose_field%" )

IF isdefined(dateentry1)=f or date1=`19000101` or isdefined(amount1)=f PAUSE "%v_invalid_field_message1%"
IF isdefined(dateentry1)=f or date1=`19000101` or isdefined(amount1)=f RETURN ALL
RETURN

