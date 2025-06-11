COMMENT - Copyright Arbutus Software Inc. 2018
SET DEFAULT
SET ECHO NONE
SET SAFETY OFF
CLOSE PRIMARY ALL
DELETE ALL OK
DO SMARTAPPS_AR_HEADER_

DO .USER_INPUTS

PAUSE "%v_AR01_results_message%"

SET ECHO ON

COMMENT : %v_AR01_comment1%

AGE ON %dateentry1% CUTOFF DATE(DATE1) INTERVAL %v_aging_periods% ACCUMULATE %amount1%

COMMENT : %v_AR01_comment2%

AGE ON %dateentry2% CUTOFF DATE(DATE1) INTERVAL %v_aging_periods% ACCUMULATE %amount1%

CLOSE
RETURN

PROCEDURE USER_INPUTS
DIALOG (DIALOG TITLE "%v_title_select_table%" WIDTH 425 HEIGHT 204 ) (BUTTONSET TITLE "&OK;&Cancel" AT 156 144 DEFAULT 1 HORZ ) (TEXT TITLE "%v_AR_text_title%" AT 36 24 ) (ITEM TITLE "f" TO "tablename" AT 204 22 WIDTH 194 DEFAULT "%v_choose_table%" )

IF ftype(tablename 'f')<>'f' PAUSE "%v_no_table_message%"
IF ftype(tablename 'f')<>'f' RETURN ALL

OPEN %tablename%

SET DATE "%v_date_settings%"

DIALOG (DIALOG TITLE "%v_AR01_dialog2_title%" WIDTH 438 HEIGHT 233 ) (BUTTONSET TITLE "&OK;&Cancel" AT 168 192 DEFAULT 1 HORZ ) (TEXT TITLE "%v_AR01_dialog2_text1%" AT 36 12 ) (ITEM TITLE "D" TO "dateentry1" AT 192 10 WIDTH 200 DEFAULT "%v_choose_field%" ) (TEXT TITLE "%v_AR01_dialog2_text2%" AT 36 48 ) (ITEM TITLE "D" TO "dateentry2" AT 192 46 WIDTH 200 DEFAULT "%v_choose_field%" ) (EDIT TO "Date1" AT 192 82 WIDTH 218 HEIGHT 20 DEFAULT "%v_AR01_cutoff_text%" DATE ) (TEXT TITLE "%v_AR01_dialog2_text3%" AT 36 84 ) (TEXT TITLE "%v_AR01_dialog2_text4%" AT 36 132 ) (ITEM TITLE "N" TO "amount1" AT 192 130 WIDTH 200 DEFAULT "%v_choose_field%" )

IF isdefined(dateentry1)=f or isdefined(dateentry2)=f or date1=`19000101` or isdefined(amount1)=f PAUSE "%v_invalid_field_message1%"
IF isdefined(dateentry1)=f or isdefined(dateentry2)=f or date1=`19000101` or isdefined(amount1)=f RETURN ALL
RETURN
