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

PAUSE "%v_IN01_results_message%"

AGE ON %dateentry1% CUTOFF DATE(DATE1) INTERVAL %v_aging_periods%

CLOSE
RETURN

PROCEDURE USER_INPUTS
DIALOG (DIALOG TITLE "%v_title_select_table%" WIDTH 373 HEIGHT 182 ) (BUTTONSET TITLE "&OK;&Cancel" AT 108 144 DEFAULT 1 HORZ ) (TEXT TITLE "%v_IN_text_title%" AT 36 24 ) (ITEM TITLE "f" TO "tablename" AT 156 22 WIDTH 187 HEIGHT 154 DEFAULT "%v_choose_table%" )

IF ftype(tablename 'f') <> 'f' PAUSE "%v_no_table_message%"
IF ftype(tablename 'f') <> 'f' RETURN ALL

OPEN %tablename%

DIALOG (DIALOG TITLE "%v_IN01_dialog2_title%" WIDTH 392 HEIGHT 217 ) (BUTTONSET TITLE "&OK;&Cancel" AT 132 180 DEFAULT 1 HORZ ) (TEXT TITLE "%v_IN01_dialog2_text1%" AT 36 36 ) (ITEM TITLE "D" TO "dateentry1" AT 168 34 WIDTH 177 HEIGHT 97 DEFAULT "%v_choose_field%" ) (EDIT TO "Date1" AT 168 106 WIDTH 207 HEIGHT 22 DEFAULT "%v_IN01_dialog2_text2%" DATE ) (TEXT TITLE "%v_IN01_dialog2_text2%" AT 36 108 )

IF isdefined(dateentry1) = f OR date1 = `19000101` PAUSE "%v_invalid_field_message1%"
IF isdefined(dateentry1) = f OR date1 = `19000101` RETURN ALL
RETURN

