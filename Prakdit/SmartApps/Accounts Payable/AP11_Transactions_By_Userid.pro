COMMENT - Copyright Arbutus Software Inc. 2018
SET DEFAULT
SET ECHO NONE
SET SAFETY OFF
CLOSE PRIMARY ALL
DELETE ALL OK
DO SMARTAPPS_AP_HEADER_

DO .USER_INPUTS

Classify on %userentry% to Temp_1 OPEN
Flag=T
Counter=1
Save Field %userentry% to User_List

DIALOG (DIALOG TITLE "%v_AP11_dialog3_title%" WIDTH 340 HEIGHT 225 ) (BUTTONSET TITLE "&OK" AT 132 180 DEFAULT 1 HORZ ) (TEXT TITLE "%v_AP11_dialog3_title%" AT 36 24 ) (DROPDOWN TITLE User_List TO "Selected_Name" AT 168 22 WIDTH 143 HEIGHT 26 )

OPEN %tablename%

SET FOLDER \Accounts Payable Results

Extract Record to %v_AP11_output% if %userentry%=selected_name

IF WRITE1=0 PAUSE "%v_no_trans_for_users%"
IF WRITE1=0 CLOSE
IF WRITE1>0 PAUSE "%v_trans_for_users%"
IF WRITE1>0 OPEN %v_AP11_output%

delete Format %v_AP11_output1% OK
delete User_List ok
RETURN

PROCEDURE USER_INPUTS
DIALOG (DIALOG TITLE "%v_title_select_table%" WIDTH 425 HEIGHT 204 ) (BUTTONSET TITLE "&OK;&Cancel" AT 180 144 DEFAULT 1 HORZ ) (TEXT TITLE "%v_AP_text_title%" AT 36 24 ) (ITEM TITLE "f" TO "tablename" AT 180 20 WIDTH 220 DEFAULT "%v_choose_table%" )

IF ftype(tablename 'f')<>'f' PAUSE "%v_no_table_message%"
IF ftype(tablename 'f')<>'f' RETURN ALL

OPEN %tablename%

DIALOG (DIALOG TITLE "%v_AP11_dialog2_title%" WIDTH 340 HEIGHT 225 ) (BUTTONSET TITLE "&OK;&Cancel" AT 96 180 DEFAULT 1 HORZ ) (TEXT TITLE "%v_user_text%" AT 36 24 ) (ITEM TITLE "C" TO "userentry" AT 132 22 WIDTH 158 HEIGHT 110 DEFAULT "%v_choose_field%" )

IF isdefined(userentry)=f PAUSE "%v_invalid_field_message5%"
IF isdefined(userentry)=f RETURN ALL
RETURN
