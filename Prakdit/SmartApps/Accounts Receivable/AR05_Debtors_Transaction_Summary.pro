COMMENT - Copyright Arbutus Software Inc. 2018
SET DEFAULT
SET ECHO NONE
SET SAFETY OFF
SET TEMP "TEMP_"
CLOSE PRIMARY ALL
DELETE ALL OK
DO SMARTAPPS_AR_HEADER_

DO .USER_INPUTS

Classify on %customerentry% to Temp_1 OPEN
Save Field %customerentry% to User_List

OPEN %tablename%

DIALOG (DIALOG TITLE "%v_AR05_dialog3_title%" WIDTH 343 HEIGHT 221 ) (BUTTONSET TITLE "&OK;&Cancel" AT 96 180 DEFAULT 1 HORZ ) (TEXT TITLE "%v_AR05_dialog3_text1%" AT 36 24 ) (DROPDOWN TITLE User_List TO "DROPDOWN1" AT 156 22 WIDTH 161 HEIGHT 20 )

SET FOLDER \Accounts Receivable Results

EXTRACT RECORD TO %v_AR05_output% IF %customerentry%=dropdown1

IF WRITE1=0 PAUSE "%v_AR05_results_message1%"
IF WRITE1=0 PAUSE CLOSE
IF WRITE1>0 PAUSE "%v_AR05_results_message2%"
IF WRITE1>0 OPEN %v_AR05_output%

DELETE TEMP OK
delete User_List ok
RETURN

PROCEDURE USER_INPUTS
DIALOG (DIALOG TITLE "%v_title_select_table%" WIDTH 425 HEIGHT 204 ) (BUTTONSET TITLE "&OK;&Cancel" AT 144 132 DEFAULT 1 HORZ ) (TEXT TITLE "%v_AR_text_title%" AT 36 24 ) (ITEM TITLE "f" TO "tablename" AT 204 22 WIDTH 198 DEFAULT "%v_choose_table%" )

IF ftype(tablename 'f')<>'f' PAUSE "%v_no_table_message%"
IF ftype(tablename 'f')<>'f' RETURN ALL

OPEN %tablename%

DIALOG (DIALOG TITLE "%v_AR05_dialog2_title%" WIDTH 381 HEIGHT 212 ) (BUTTONSET TITLE "&OK;&Cancel" AT 156 180 DEFAULT 1 HORZ ) (TEXT TITLE "%v_AR05_dialog2_text1%" AT 36 24 ) (ITEM TITLE "C" TO "customerentry" AT 156 20 WIDTH 200 DEFAULT "%v_choose_field%" )

IF isdefined(customerentry)=f PAUSE "%v_invalid_field_message4%"
IF isdefined(customerentry)=f RETURN ALL
RETURN
