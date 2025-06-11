COMMENT - Copyright Arbutus Software Inc. 2021
SET DEFAULT
SET ECHO NONE
SET SAFETY OFF
CLOSE PRIMARY ALL
DELETE ALL OK
DO SMARTAPPS_IN_HEADER_
SET DATE "%v_date_settings%"

DO .USER_INPUTS

SET ECHO ON

PAUSE "%v_IN10_results_message%"

AGE ON %dateentry1% CUTOFF DATE(DATE1) INTERVAL %v_aging_periods% ACCUMULATE %amount1%

CLOSE
RETURN

PROCEDURE USER_INPUTS
DIALOG (DIALOG TITLE "%v_title_select_table%" WIDTH 373 HEIGHT 182 ) (BUTTONSET TITLE "&OK;&Cancel" AT 108 144 DEFAULT 1 HORZ ) (TEXT TITLE "%v_IN_text_title%" AT 36 24 ) (ITEM TITLE "f" TO "tablename" AT 144 22 WIDTH 190 HEIGHT 154 DEFAULT "%v_choose_table%" )

IF ftype(tablename 'f') <> 'f' PAUSE "%v_no_table_message%"
IF ftype(tablename 'f') <> 'f' RETURN ALL

OPEN %tablename%

DIALOG (DIALOG TITLE "%v_IN10_dialog2_title%" WIDTH 425 HEIGHT 222 ) (BUTTONSET TITLE "&OK;&Cancel" AT 144 180 DEFAULT 1 HORZ ) (TEXT TITLE "%v_IN10_dialog2_text1%" AT 36 12 ) (ITEM TITLE "D" TO "dateentry1" AT 192 10 WIDTH 169 HEIGHT 97 DEFAULT "%v_choose_field%" ) (EDIT TO "Date1" AT 192 70 WIDTH 208 HEIGHT 20 DATE ) (TEXT TITLE "%v_IN01_dialog2_text2%" AT 36 72 ) (TEXT TITLE "%v_IN08_dialog2_text2%" AT 36 132 ) (ITEM TITLE "N" TO "amount1" AT 192 130 WIDTH 168 HEIGHT 48 DEFAULT "%v_choose_field%" )

IF isdefined(dateentry1) = f or date1=`19000101` or isdefined(amount1) = f PAUSE "%v_invalid_field_message1%"
IF isdefined(dateentry1) = f or date1=`19000101` or isdefined(amount1) = f RETURN ALL
RETURN

