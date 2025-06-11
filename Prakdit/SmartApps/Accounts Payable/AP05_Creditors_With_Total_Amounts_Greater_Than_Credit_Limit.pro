COMMENT - Copyright Arbutus Software Inc. 2018
SET DEFAULT
SET ECHO NONE
SET SAFETY OFF
SET TEMP "TEMP_"
CLOSE PRIMARY ALL
DELETE ALL OK
DO SMARTAPPS_AP_HEADER_

DO .USER_INPUTS

OPEN %tablename1%
SUMMARIZE ON %vendorfield% ACCUMULATE %amountfield% PRESORT TO Temp_1 IF %datefield%>=EDIT1 AND %datefield%<=EDIT2 OPEN
OPEN %tablename2% SECONDARY

JOIN PKEY %vendorfield% FIELDS %vendorfield% %amountfield% SKEY %vendorfield2% WITH %limitfield% TO Temp_2 OPEN PRESORT SECSORT

CLOSE SECONDARY

SET FOLDER \Accounts Payable Results

EXTRACT RECORD TO %v_AP05_output% if %amountfield%>%limitfield%

IF WRITE1=0 PAUSE "%v_no_vendor_exceed_limit_message%"
IF WRITE1=0 CLOSE
IF WRITE1>0 PAUSE "%v_vendor_exceed_limit_message%"
IF WRITE1>0 OPEN %v_AP05_output%

DELETE TEMP OK
RETURN

PROCEDURE USER_INPUTS
DIALOG (DIALOG TITLE "%v_title_select_tables%" WIDTH 425 HEIGHT 204 ) (BUTTONSET TITLE "&OK;&Cancel" AT 180 144 DEFAULT 1 HORZ ) (TEXT TITLE "%v_AP_text_title%" AT 36 24 ) (ITEM TITLE "f" TO "tablename1" AT 180 20 WIDTH 220 DEFAULT "%v_choose_table%" ) (ITEM TITLE "f" TO "tablename2" AT 180 56 WIDTH 220 DEFAULT "%v_choose_table%" ) (TEXT TITLE "%v_AP_text_title2%" AT 36 60 )

IF ftype(tablename1 'f')<>'f' OR ftype(tablename2 'f')<>'f' PAUSE "%v_no_table_message%"
IF ftype(tablename1 'f')<>'f' OR ftype(tablename2 'f')<>'f' RETURN ALL

OPEN %tablename1%

DIALOG (DIALOG TITLE "%v_AP04_dialog2_title%" WIDTH 394 HEIGHT 324 ) (BUTTONSET TITLE "&OK;&Cancel" AT 132 276 DEFAULT 1 HORZ ) (TEXT TITLE "%v_vendor_text%" AT 36 24 ) (ITEM TITLE "C" TO "vendorfield" AT 168 22 WIDTH 186 HEIGHT 186 DEFAULT "%v_choose_field%" ) (TEXT TITLE "%v_amount_text%" AT 36 72 ) (ITEM TITLE "N" TO "amountfield" AT 168 70 WIDTH 184 DEFAULT "%v_choose_field%" ) (EDIT TO "EDIT1" AT 156 166 WIDTH 214 HEIGHT 25 DEFAULT "%v_specify_start_date" DATE ) (TEXT TITLE "%v_startdate_text%" AT 36 168 ) (TEXT TITLE "%v_enddate_text%" AT 36 216 ) (EDIT TO "EDIT2" AT 156 214 WIDTH 211 HEIGHT 25 DEFAULT "%v_specify_end_date%" DATE ) (TEXT TITLE "%v_date_text%" AT 36 120 ) (ITEM TITLE "D" TO "datefield" AT 168 118 WIDTH 182 HEIGHT 69 DEFAULT "%v_choose_field%" )

IF isdefined(vendorfield)=f or isdefined(amountfield)=f OR isdefined(datefield)=f PAUSE "%v_invalid_field_message4%"
IF isdefined(vendorfield)=f or isdefined(amountfield)=f OR isdefined(datefield)=f RETURN ALL

OPEN %tablename2%

DIALOG (DIALOG TITLE "%v_AP04_dialog3_title%" WIDTH 385 HEIGHT 212 ) (BUTTONSET TITLE "&OK;&Cancel" AT 132 168 DEFAULT 1 HORZ ) (TEXT TITLE "%v_vendor_text%" AT 36 24 ) (ITEM TITLE "C" TO "vendorfield2" AT 168 22 WIDTH 185 HEIGHT 186 DEFAULT "%v_choose_field%" ) (TEXT TITLE "%v_creditlimit_text%" AT 36 72 ) (ITEM TITLE "N" TO "limitfield" AT 168 70 WIDTH 185 HEIGHT 20 DEFAULT "%v_choose_field%" )

IF isdefined(vendorfield2)=f or isdefined(limitfield)=f PAUSE "%v_invalid_field_message3%"
IF isdefined(vendorfield2)=f or isdefined(limitfield)=f RETURN ALL
RETURN
