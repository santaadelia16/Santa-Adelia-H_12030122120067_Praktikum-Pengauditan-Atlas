COMMENT - Copyright Arbutus Software Inc. 2018
SET DEFAULT
SET ECHO NONE
SET SAFETY OFF
CLOSE PRIMARY ALL
DELETE ALL OK
DO SMARTAPPS_AP_HEADER_

DO .USER_INPUTS

SET FOLDER \Accounts Payable Results

EXTRACT RECORD TO %v_AP09_output% if %datefld%>=datevar1 AND %datefld%<=datevar2

IF WRITE1=0 PAUSE "%v_no_payables_within_range%"
IF WRITE1=0 CLOSE
IF WRITE1>0 PAUSE "%v_payables_within_range%"
IF WRITE1>0 OPEN %v_AP09_output%
RETURN

PROCEDURE USER_INPUTS
DIALOG (DIALOG TITLE "%v_title_select_table%" WIDTH 425 HEIGHT 204 ) (BUTTONSET TITLE "&OK;&Cancel" AT 180 144 DEFAULT 1 HORZ ) (TEXT TITLE "%v_AP_text_title%" AT 36 24 ) (ITEM TITLE "f" TO "tablename" AT 180 20 WIDTH 220 DEFAULT "%v_choose_table%" )

IF ftype(tablename 'f')<>'f' PAUSE "%v_no_table_message%"
IF ftype(tablename 'f')<>'f' RETURN ALL

OPEN %tablename%

DIALOG (DIALOG TITLE "%v_AP08_dialog2_title%" WIDTH 411 HEIGHT 225 ) (BUTTONSET TITLE "&OK;&Cancel" AT 144 180 DEFAULT 1 HORZ ) (TEXT TITLE "%v_start_date_text%" AT 36 84 ) (EDIT TO "DateVar1" AT 156 82 WIDTH 222 DATE ) (EDIT TO "datevar2" AT 156 130 WIDTH 220 DATE ) (TEXT TITLE "%v_end_date_text%" AT 36 132 ) (TEXT TITLE "%v_date_text%" AT 36 36 ) (ITEM TITLE "D" TO "datefld" AT 156 34 WIDTH 200 DEFAULT "%v_choose_field%" )

IF isdefined(datefld)=f PAUSE "%v_invalid_field_message6%"
IF isdefined(datefld)=f RETURN ALL
RETURN
