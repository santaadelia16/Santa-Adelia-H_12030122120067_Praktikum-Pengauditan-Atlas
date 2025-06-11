COMMENT - Copyright Arbutus Software Inc. 2018
SET DEFAULT
SET ECHO NONE
SET SAFETY OFF
SET TEMP "TEMP_"
CLOSE PRIMARY ALL
DELETE ALL OK
DO SMARTAPPS_AP_HEADER_

DO .USER_INPUTS

SUMMARIZE ON %vendorfield% ACCUMULATE %amountfield% PRESORT TO Temp_1 OPEN

SET FOLDER \Accounts Payable Results

EXTRACT RECORD TO %v_AP03_output% if %amountfield%>0

IF WRITE1=0 PAUSE "%v_no_debit_balances_message%"
IF WRITE1=0 CLOSE
IF WRITE1>0 PAUSE "%v_debit_balances_message%"
IF WRITE1>0 OPEN %v_AP03_output%

DELETE TEMP OK
RETURN

PROCEDURE USER_INPUTS
DIALOG (DIALOG TITLE "%v_title_select_table%" WIDTH 425 HEIGHT 204 ) (BUTTONSET TITLE "&OK;&Cancel" AT 180 144 DEFAULT 1 HORZ ) (TEXT TITLE "%v_AP_text_title%" AT 36 24 ) (ITEM TITLE "f" TO "tablename" AT 180 20 WIDTH 220 DEFAULT "%v_choose_table%" )

IF ftype(tablename 'f')<>'f' PAUSE "%v_no_table_message%"
IF ftype(tablename 'f')<>'f' RETURN ALL

OPEN %tablename%

DIALOG (DIALOG TITLE "%v_AP03_dialog2_title%" WIDTH 395 HEIGHT 216 ) (BUTTONSET TITLE "&OK;&Cancel" AT 132 168 DEFAULT 1 HORZ ) (TEXT TITLE "%v_vendor_text%" AT 36 24 ) (ITEM TITLE "C" TO "vendorfield" AT 192 22 WIDTH 168 HEIGHT 186 DEFAULT "%v_choose_field%" ) (TEXT TITLE "%v_amount_text%" AT 36 72 ) (ITEM TITLE "N" TO "amountfield" AT 192 70 WIDTH 161 DEFAULT "%v_choose_field%" )

IF isdefined(vendorfield)=f or isdefined(amountfield)=f PAUSE "%v_invalid_field_message3%"
IF isdefined(vendorfield)=f or isdefined(amountfield)=f RETURN ALL
RETURN

