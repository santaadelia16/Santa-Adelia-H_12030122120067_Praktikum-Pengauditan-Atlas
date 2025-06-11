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

SET FOLDER \Accounts Receivable Results

EXTRACT RECORD TO %v_AR03_output% if %amountfield%>%limitfield%

IF WRITE1=0 PAUSE "%v_AR03_results_message1%"
IF WRITE1=0 CLOSE
IF WRITE1>0 PAUSE "%v_AR03_results_message2%"
IF WRITE1>0 OPEN %v_AR03_output%

CLOSE SECONDARY
DELETE TEMP OK
RETURN

PROCEDURE USER_INPUTS
DIALOG (DIALOG TITLE "%v_title_select_tables%" WIDTH 459 HEIGHT 191 ) (BUTTONSET TITLE "&OK;&Cancel" AT 216 144 DEFAULT 1 HORZ ) (TEXT TITLE "%v_AR_text_title%" AT 36 24 ) (ITEM TITLE "f" TO "tablename1" AT 216 20 WIDTH 220 DEFAULT "%v_choose_table%" ) (ITEM TITLE "f" TO "tablename2" AT 216 56 WIDTH 220 DEFAULT "%v_choose_table%" ) (TEXT TITLE "%v_AR02_dialog1_text1%" AT 36 60 )

IF ftype(tablename1 'f')<>'f' OR ftype(tablename2 'f')<>'f' PAUSE "%v_no_table_message%"
IF ftype(tablename1 'f')<>'f' OR ftype(tablename2 'f')<>'f' RETURN ALL

OPEN %tablename1%

DIALOG (DIALOG TITLE "%v_AR02_dialog2_title%" WIDTH 429 HEIGHT 303 ) (BUTTONSET TITLE "&OK;&Cancel" AT 144 264 DEFAULT 1 HORZ ) (TEXT TITLE "%v_AR02_dialog2_text1%" AT 36 24 ) (ITEM TITLE "C" TO "customerfield" AT 192 22 WIDTH 200 DEFAULT "%v_choose_field%" ) (TEXT TITLE "%v_AR01_dialog2_text4%" AT 36 72 ) (ITEM TITLE "N" TO "amountfield" AT 192 70 WIDTH 200 DEFAULT "%v_choose_field%" ) (EDIT TO "EDIT1" AT 192 166 WIDTH 215 DEFAULT "%v_AR03_specify_start_date%" DATE ) (TEXT TITLE "%v_AR03_dialog2_text1%" AT 36 168 ) (TEXT TITLE "%v_AR03_dialog2_text2%" AT 36 216 ) (EDIT TO "EDIT2" AT 192 214 WIDTH 215 DEFAULT "%v_AR03_specify_end_date%" DATE ) (TEXT TITLE "%v_AR03_dialog2_text3%" AT 36 120 ) (ITEM TITLE "D" TO "datefield" AT 192 118 WIDTH 200 DEFAULT "%v_choose_field%" )

IF isdefined(customerfield)=f or isdefined(amountfield)=f OR isdefined(datefield)=f PAUSE "%v_invalid_field_message3%"
IF isdefined(customerfield)=f or isdefined(amountfield)=f OR isdefined(datefield)=f RETURN ALL

SUMMARIZE ON %customerfield% ACCUMULATE %amountfield% PRESORT TO Temp_1 IF %datefield%>=EDIT1 AND %datefield%<=EDIT2

OPEN %tablename2%

DIALOG (DIALOG TITLE "%v_AR02_dialog3_title%" WIDTH 389 HEIGHT 220 ) (BUTTONSET TITLE "&OK;&Cancel" AT 120 180 DEFAULT 1 HORZ ) (TEXT TITLE "%v_AR02_dialog2_text1%" AT 36 24 ) (ITEM TITLE "C" TO "customerfield2" AT 192 22 WIDTH 165 HEIGHT 21 DEFAULT "%v_choose_field%" ) (TEXT TITLE "%v_AR02_dialog3_text1%" AT 36 72 ) (ITEM TITLE "N" TO "limitfield" AT 192 70 WIDTH 163 HEIGHT 19 DEFAULT "%v_choose_field%" )

IF isdefined(customerfield2)=f or isdefined(limitfield)=f PAUSE "%v_invalid_field_message2%"
IF isdefined(customerfield2)=f or isdefined(limitfield)=f RETURN ALL
RETURN

