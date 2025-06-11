COMMENT - Copyright Arbutus Software Inc. 2018
SET DEFAULT
SET ECHO NONE
SET SAFETY OFF
CLOSE PRIMARY ALL
DELETE ALL OK
DO SMARTAPPS_AP_HEADER_

DO .USER_INPUTS

SET FOLDER \Accounts Payable Results

EXTRACT RECORD TO %v_AP13_output% if round(%amount_entry%)=%amount_entry%

IF WRITE1=0 PAUSE "%v_no_rounded_trans%"
IF WRITE1=0 CLOSE
IF WRITE1>0 PAUSE "%v_rounded_trans%"
IF WRITE1>0 OPEN %v_AP13_output%
RETURN

PROCEDURE USER_INPUTS
DIALOG (DIALOG TITLE "%v_title_select_table%" WIDTH 425 HEIGHT 204 ) (BUTTONSET TITLE "&OK;&Cancel" AT 180 144 DEFAULT 1 HORZ ) (TEXT TITLE "%v_AP_text_title%" AT 36 24 ) (ITEM TITLE "f" TO "tablename" AT 180 20 WIDTH 220 DEFAULT "%v_choose_table%" )

IF ftype(tablename 'f')<>'f' PAUSE "%v_no_table_message%"
IF ftype(tablename 'f')<>'f' RETURN ALL

OPEN %tablename%

DIALOG (DIALOG TITLE "%v_AP13_dialog2_title%" WIDTH 373 HEIGHT 219 ) (BUTTONSET TITLE "&OK;&Cancel" AT 120 168 DEFAULT 1 HORZ ) (ITEM TITLE "N" TO "amount_entry" AT 144 32 WIDTH 200 HEIGHT 152 DEFAULT "%v_choose_amount_text%" ) (TEXT TITLE "%v_select_amount_text%" AT 24 36 )

IF isdefined(amount_entry)=f PAUSE "%v_invalid_field_message5%"
IF isdefined(amount_entry)=f RETURN ALL
RETURN

