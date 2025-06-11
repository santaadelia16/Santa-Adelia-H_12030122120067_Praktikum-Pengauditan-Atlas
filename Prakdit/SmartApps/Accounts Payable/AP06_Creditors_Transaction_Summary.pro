COMMENT - Copyright Arbutus Software Inc. 2018
SET DEFAULT
SET ECHO NONE
SET SAFETY OFF
SET TEMP "TEMP_"
CLOSE PRIMARY ALL
DELETE ALL OK
DO SMARTAPPS_AP_HEADER_

DO .USER_INPUTS

CLASSIFY ON %vendorentry% TO Temp_1 OPEN
SAVE FIELD %vendorentry% TO v_Vendor_List

OPEN %tablename%

DIALOG (DIALOG TITLE "%v_AP06_dialog3_title%" WIDTH 351 HEIGHT 219 ) (BUTTONSET TITLE "&OK;&Cancel" AT 108 168 DEFAULT 1 HORZ ) (TEXT TITLE "%v_creditor_text%" AT 36 24 ) (DROPDOWN TITLE v_Vendor_List TO "DROPDOWN1" AT 156 22 WIDTH 159 HEIGHT 27 )

SET FOLDER \Accounts Payable Results

EXTRACT RECORD TO %v_AP06_output% IF %vendorentry%=dropdown1

IF WRITE1=0 PAUSE "%v_no_vendor_transactions%"
IF WRITE1=0 CLOSE
IF WRITE1>0 PAUSE "%v_vendor_transactions%"
IF WRITE1>0 OPEN %v_AP06_output%

DELETE TEMP OK
DELETE v_Vendor_List OK
RETURN

PROCEDURE USER_INPUTS
DIALOG (DIALOG TITLE "%v_title_select_table%" WIDTH 435 HEIGHT 179 ) (BUTTONSET TITLE "&OK;&Cancel" AT 144 132 DEFAULT 1 HORZ ) (TEXT TITLE "%v_AP_text_title%" AT 36 24 ) (ITEM TITLE "f" TO "tablename" AT 180 20 WIDTH 220 HEIGHT 154 DEFAULT "%v_choose_table%" )

IF ftype(tablename 'f')<>'f' PAUSE "%v_no_table_message%"
IF ftype(tablename 'f')<>'f' RETURN ALL

OPEN %tablename%

DIALOG (DIALOG TITLE "%v_AP06_dialog2_title%" WIDTH 354 HEIGHT 219 ) (BUTTONSET TITLE "&OK;&Cancel" AT 108 180 DEFAULT 1 HORZ ) (TEXT TITLE "%v_AP02_field4%" AT 36 24 ) (ITEM TITLE "C" TO "vendorentry" AT 120 20 WIDTH 200 HEIGHT 186 DEFAULT "%v_choose_field%" )

IF isdefined(vendorentry)=f PAUSE "%v_invalid_field_message5%"
IF isdefined(vendorentry)=f RETURN ALL
RETURN
