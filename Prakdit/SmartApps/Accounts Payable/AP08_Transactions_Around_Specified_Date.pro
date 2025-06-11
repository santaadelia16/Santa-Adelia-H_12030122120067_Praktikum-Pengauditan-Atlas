COMMENT - Copyright Arbutus Software Inc. 2018
SET DEFAULT
SET ECHO NONE
SET SAFETY OFF
CLOSE PRIMARY ALL
DELETE ALL OK
DO SMARTAPPS_AP_HEADER_

DO .USER_INPUTS

SET FOLDER \Accounts Payable Results

EXTRACT RECORD TO %v_AP08_output% if ABS(DateVar1-%datefld%)<=n_days

IF WRITE1=0 PAUSE "%v_no_trans_within_range_message%"
IF WRITE1=0 CLOSE
IF WRITE1>0 PAUSE "%v_trans_within_range_message%"
IF WRITE1>0 OPEN %v_AP08_output%
RETURN

PROCEDURE USER_INPUTS
DIALOG (DIALOG TITLE "%v_title_select_table%" WIDTH 425 HEIGHT 204 ) (BUTTONSET TITLE "&OK;&Cancel" AT 180 144 DEFAULT 1 HORZ ) (TEXT TITLE "%v_AP_text_title%" AT 36 24 ) (ITEM TITLE "f" TO "tablename" AT 180 20 WIDTH 220 DEFAULT "%v_choose_table%" )

IF ftype(tablename 'f')<>'f' PAUSE "%v_no_table_message%"
IF ftype(tablename 'f')<>'f' RETURN ALL

OPEN %tablename%

DIALOG (DIALOG TITLE "%v_AP08_dialog2_title%" WIDTH 414 HEIGHT 219 ) (BUTTONSET TITLE "&OK;&Cancel" AT 156 180 DEFAULT 1 HORZ ) (TEXT TITLE "%v_date_text2%" AT 36 84 ) (EDIT TO "DateVar1" AT 168 82 WIDTH 211 HEIGHT 26 DATE ) (EDIT TO "n_days" AT 168 130 NUM ) (TEXT TITLE "%v_dayswithin_text%" AT 36 132 WIDTH 114 HEIGHT 36 ) (TEXT TITLE "%v_date_text%" AT 36 36 ) (ITEM TITLE "D" TO "datefld" AT 168 34 WIDTH 162 HEIGHT 26 DEFAULT "%v_choose_field%" )

IF isdefined(datefld)=f PAUSE "%v_invalid_field_message5%"
IF isdefined(datefld)=f RETURN ALL

IF n_days = 0 PAUSE "%v_no_date_value_message%"
IF n_days = 0 RETURN ALL
RETURN
