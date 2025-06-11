COMMENT - Copyright Arbutus Software Inc. 2018
SET DEFAULT
SET ECHO NONE
SET SAFETY OFF
CLOSE PRIMARY ALL
DELETE ALL OK
DO SMARTAPPS_AP_HEADER_

DO .USER_INPUTS

x=length(%poentry%)

SET FOLDER \Accounts Payable Results

EXTRACT RECORD TO %v_AP07_output% IF %poentry%=BLANKS(x)

IF WRITE1=0 PAUSE "%v_no_vendors_without_PO_message%"
IF WRITE1=0 CLOSE
IF WRITE1>0 PAUSE "%v_vendors_without_PO_message%"
IF WRITE1>0 OPEN %v_AP07_output%
RETURN

PROCEDURE USER_INPUTS
DIALOG (DIALOG TITLE "%v_title_select_table%" WIDTH 425 HEIGHT 204 ) (BUTTONSET TITLE "&OK;&Cancel" AT 180 144 DEFAULT 1 HORZ ) (TEXT TITLE "%v_AP_text_title%" AT 36 24 ) (ITEM TITLE "f" TO "tablename" AT 180 20 WIDTH 220 DEFAULT "%v_choose_table%" )

IF ftype(tablename 'f')<>'f' PAUSE "%v_no_table_message%"
IF ftype(tablename 'f')<>'f' RETURN ALL

OPEN %tablename%

DIALOG (DIALOG TITLE "%v_AP07_dialog2_title%" WIDTH 340 HEIGHT 225 ) (BUTTONSET TITLE "&OK;&Cancel" AT 84 180 DEFAULT 1 HORZ ) (ITEM TITLE "C" TO "poentry" AT 96 20 WIDTH 200 DEFAULT "%v_choose_field%" ) (TEXT TITLE "%v_po_field_text%" AT 36 24 )

IF isdefined(poentry)=f PAUSE "%v_invalid_field_message5%"
IF isdefined(poentry)=f RETURN ALL
RETURN
