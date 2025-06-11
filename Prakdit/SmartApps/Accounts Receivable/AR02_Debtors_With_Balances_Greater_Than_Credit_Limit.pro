COMMENT - Copyright Arbutus Software Inc. 2018
SET DEFAULT
SET ECHO NONE
SET SAFETY OFF
SET TEMP "TEMP_"
CLOSE PRIMARY ALL
DELETE ALL OK
DO SMARTAPPS_AR_HEADER_

DO .USER_INPUTS

OPEN Temp_1
OPEN %tablename2% SECONDARY

JOIN PKEY %customerfield% FIELDS %customerfield% %amountfield% SKEY %customerfield2% WITH %limitfield% TO Temp_2 OPEN PRESORT SECSORT

CLOSE SECONDARY

SET FOLDER \Accounts Receivable Results

EXTRACT RECORD TO %v_AR02_output% if %amountfield%>%limitfield%

IF WRITE1=0 PAUSE "%v_AR02_results_message1%"
IF WRITE1=0 CLOSE
IF WRITE1>0 PAUSE "%v_AR02_results_message2%"
IF WRITE1>0 OPEN %v_AR02_output%

DELETE TEMP OK
RETURN

PROCEDURE USER_INPUTS
DIALOG (DIALOG TITLE "Select Tables" WIDTH 459 HEIGHT 191 ) (BUTTONSET TITLE "&OK;&Cancel" AT 216 144 DEFAULT 1 HORZ ) (TEXT TITLE "%v_AR_text_title%" AT 36 24 ) (ITEM TITLE "f" TO "tablename1" AT 216 20 WIDTH 220 DEFAULT "%v_choose_table%" ) (ITEM TITLE "f" TO "tablename2" AT 216 56 WIDTH 220 DEFAULT "%v_choose_table%" ) (TEXT TITLE "%v_AR02_dialog1_text1%" AT 36 60 )

IF ftype(tablename1 'f')<>'f' OR ftype(tablename2 'f')<>'f' PAUSE "%v_no_table_message%"
IF ftype(tablename1 'f')<>'f' OR ftype(tablename2 'f')<>'f' RETURN ALL

OPEN %tablename1%

DIALOG (DIALOG TITLE "%v_AR02_dialog2_title%" WIDTH 364 HEIGHT 221 ) (BUTTONSET TITLE "&OK;&Cancel" AT 120 168 DEFAULT 1 HORZ ) (TEXT TITLE "%v_AR02_dialog2_text1%" AT 36 24 ) (ITEM TITLE "C" TO "customerfield" AT 180 22 WIDTH 151 HEIGHT 186 DEFAULT "%v_choose_field%" ) (TEXT TITLE "%v_AR01_dialog2_text4%" AT 36 72 ) (ITEM TITLE "N" TO "amountfield" AT 180 70 WIDTH 152 DEFAULT "%v_choose_field%" )

IF isdefined(customerfield)=f or isdefined(amountfield)=f PAUSE "%v_invalid_field_message2%"
IF isdefined(customerfield)=f or isdefined(amountfield)=f RETURN ALL

SUMMARIZE ON %customerfield% ACCUMULATE %amountfield% PRESORT TO Temp_1

OPEN %tablename2%

DIALOG (DIALOG TITLE "%v_AR02_dialog3_title%" WIDTH 364 HEIGHT 218 ) (BUTTONSET TITLE "&OK;&Cancel" AT 120 168 DEFAULT 1 HORZ ) (TEXT TITLE "%v_AR02_dialog2_text1%" AT 36 24 ) (ITEM TITLE "C" TO "customerfield2" AT 180 22 WIDTH 151 HEIGHT 186 DEFAULT "%v_choose_field%" ) (TEXT TITLE "%v_AR02_dialog3_text1%" AT 36 72 ) (ITEM TITLE "N" TO "limitfield" AT 180 70 WIDTH 152 DEFAULT "%v_choose_field%" )

IF isdefined(customerfield2)=f or isdefined(limitfield)=f PAUSE "%v_invalid_field_message2%"
IF isdefined(customerfield2)=f or isdefined(limitfield)=f RETURN ALL
RETURN
