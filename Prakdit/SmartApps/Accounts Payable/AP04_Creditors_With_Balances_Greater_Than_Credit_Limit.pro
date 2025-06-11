COMMENT - Copyright Arbutus Software Inc. 2018
SET DEFAULT
SET ECHO NONE
SET SAFETY OFF
SET TEMP "TEMP_"
CLOSE PRIMARY ALL
DELETE ALL OK
DO SMARTAPPS_AP_HEADER_
DO .USER_INPUTS

OPEN Temp_1
OPEN %tablename2% SECONDARY

SET FOLDER \Accounts Payable Results

JOIN PKEY %vendorfield% FIELDS %vendorfield% %amountfield% SKEY %vendorfield2% WITH %limitfield% TO Temp_2 OPEN PRESORT SECSORT

CLOSE SECONDARY

EXTRACT RECORD TO %v_AP04_output% if %amountfield%>%limitfield%

IF WRITE1=0 PAUSE "%v_no_balances_exceeding_limit%"
IF WRITE1=0 CLOSE
IF WRITE1>0 PAUSE "%v_balances_exceeding_limit%"
IF WRITE1>0 OPEN %v_AP04_output%

DELETE TEMP OK
RETURN

PROCEDURE USER_INPUTS
DIALOG (DIALOG TITLE "%v_title_select_tables%" WIDTH 425 HEIGHT 204 ) (BUTTONSET TITLE "&OK;&Cancel" AT 180 144 DEFAULT 1 HORZ ) (TEXT TITLE "%v_AP_text_title%" AT 36 24 ) (ITEM TITLE "f" TO "tablename1" AT 180 20 WIDTH 220 DEFAULT "%v_choose_table%" ) (ITEM TITLE "f" TO "tablename2" AT 180 56 WIDTH 220 DEFAULT "%v_choose_table%" ) (TEXT TITLE "%v_AP_text_title2%" AT 36 60 )

IF ftype(tablename1 'f')<>'f' OR ftype(tablename2 'f')<>'f' PAUSE "%v_no_table_message%"
IF ftype(tablename1 'f')<>'f' OR ftype(tablename2 'f')<>'f' RETURN ALL

OPEN %tablename1%

DIALOG (DIALOG TITLE "%v_AP04_dialog2_title%" WIDTH 397 HEIGHT 214 ) (BUTTONSET TITLE "&OK;&Cancel" AT 132 168 DEFAULT 1 HORZ ) (TEXT TITLE "%v_vendor_text%" AT 36 24 ) (ITEM TITLE "C" TO "vendorfield" AT 180 22 WIDTH 175 HEIGHT 186 DEFAULT "%v_choose_field%" ) (TEXT TITLE "%v_amount_text%" AT 36 72 ) (ITEM TITLE "N" TO "amountfield" AT 180 70 WIDTH 172 DEFAULT "%v_choose_field%" )

IF isdefined(vendorfield)=f or isdefined(amountfield)=f PAUSE "%v_invalid_field_message3%"
IF isdefined(vendorfield)=f or isdefined(amountfield)=f RETURN ALL

SUMMARIZE ON %vendorfield% ACCUMULATE %amountfield% PRESORT TO Temp_1

OPEN %tablename2%

DIALOG (DIALOG TITLE "%v_AP04_dialog3_title%" WIDTH 406 HEIGHT 214 ) (BUTTONSET TITLE "&OK;&Cancel" AT 144 168 DEFAULT 1 HORZ ) (TEXT TITLE "%v_vendor_text%" AT 36 24 ) (ITEM TITLE "C" TO "vendorfield2" AT 180 22 WIDTH 170 HEIGHT 186 DEFAULT "%v_choose_field%" ) (TEXT TITLE "%v_creditlimit_text%" AT 36 72 ) (ITEM TITLE "N" TO "limitfield" AT 180 70 WIDTH 173 DEFAULT "%v_choose_field%" )

IF isdefined(vendorfield2)=f or isdefined(limitfield)=f PAUSE "%v_invalid_field_message3%"
IF isdefined(vendorfield2)=f or isdefined(limitfield)=f RETURN ALL
RETURN

