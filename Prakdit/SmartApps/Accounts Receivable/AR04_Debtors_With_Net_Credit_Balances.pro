COMMENT - Copyright Arbutus Software Inc. 2018
SET DEFAULT
SET ECHO NONE
SET SAFETY OFF
SET TEMP "TEMP_"
CLOSE PRIMARY ALL
DELETE ALL OK
DO SMARTAPPS_AR_HEADER_

DO .USER_INPUTS

SUMMARIZE ON %customerfield% ACCUMULATE %amountfield% PRESORT TO Temp_1 OPEN

SET FOLDER \Accounts Receivable Results

EXTRACT RECORD TO %v_AR04_output% if %amountfield%<0

IF WRITE1=0 PAUSE "%v_AR04_results_message1%"
IF WRITE1=0 CLOSE
IF WRITE1>0 PAUSE "%v_AR04_results_message2%"
IF WRITE1>0 OPEN %v_AR04_output%

DELETE TEMP OK
RETURN

PROCEDURE USER_INPUTS
DIALOG (DIALOG TITLE "%v_title_select_table%" WIDTH 425 HEIGHT 204 ) (BUTTONSET TITLE "&OK;&Cancel" AT 156 144 DEFAULT 1 HORZ ) (TEXT TITLE "%v_AR_text_title%" AT 36 24 ) (ITEM TITLE "f" TO "tablename" AT 204 22 WIDTH 196 DEFAULT "%v_choose_table%" )

IF ftype(tablename 'f')<>'f' PAUSE "%v_no_table_message%."
IF ftype(tablename 'f')<>'f' RETURN ALL

OPEN %tablename%

DIALOG (DIALOG TITLE "%v_AR02_dialog2_title%" WIDTH 387 HEIGHT 216 ) (BUTTONSET TITLE "&OK;&Cancel" AT 132 168 DEFAULT 1 HORZ ) (TEXT TITLE "%v_AR02_dialog2_text1%" AT 36 24 ) (ITEM TITLE "C" TO "customerfield" AT 192 22 WIDTH 166 HEIGHT 23 DEFAULT "%v_choose_field%" ) (TEXT TITLE "%v_AR01_dialog2_text4%" AT 36 72 ) (ITEM TITLE "N" TO "amountfield" AT 192 70 WIDTH 164 HEIGHT 19 DEFAULT "%v_choose_field%" )

IF isdefined(customerfield)=f or isdefined(amountfield)=f PAUSE "%v_invalid_field_message2%"
IF isdefined(customerfield)=f or isdefined(amountfield)=f RETURN ALL
RETURN
