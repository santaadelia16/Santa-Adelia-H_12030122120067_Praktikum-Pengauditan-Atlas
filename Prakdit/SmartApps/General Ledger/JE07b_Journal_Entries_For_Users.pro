COMMENT - Copyright Arbutus Software Inc. 2018
SET DEFAULT
SET ECHO NONE
SET SAFETY OFF
CLOSE PRIMARY ALL
DELETE ALL OK
DO SMARTAPPS_GL_HEADER_

DO .USER_INPUTS

Classify on %userentry% to Clean_Users OPEN
Flag=T
Counter=1
Save Field %userentry% to User_List
Close
Delete Format Clean_Users OK

DO .Choose_Users While Flag = T and Counter <= 10

OPEN %tablename%

SET FOLDER \General Ledger Results

Extract Record to %v_JE07b_output% if Listfind(Users %userentry%)

IF WRITE1 = 0 PAUSE "%v_JE07b_noresults_message%"
IF WRITE1 = 0 CLOSE
IF WRITE1 > 0 PAUSE "%v_JE07b_results_message%"
IF WRITE1 > 0 OPEN %v_JE07b_output%
RETURN

PROCEDURE USER_INPUTS
DIALOG (DIALOG TITLE "%v_title_select_table%" WIDTH 400 HEIGHT 180 ) (BUTTONSET TITLE "&OK;&Cancel" AT 144 132 DEFAULT 1 HORZ ) (TEXT TITLE "%v_JE_text_title%" AT 36 24 ) (ITEM TITLE "f" TO "tablename" AT 180 22 WIDTH 191 HEIGHT 154 DEFAULT "%v_choose_table%" )

IF ftype(tablename 'f') <> 'f' PAUSE "%v_no_table_message%"
IF ftype(tablename 'f') <> 'f' RETURN ALL

OPEN %tablename%

DIALOG (DIALOG TITLE "%v_JE07a_dialog2_title%" WIDTH 340 HEIGHT 225 ) (BUTTONSET TITLE "&OK;&Cancel" AT 96 180 DEFAULT 1 HORZ ) (TEXT TITLE "%v_JE07a_dialog2_text1%" AT 36 36 ) (ITEM TITLE "C" TO "userentry" AT 108 32 WIDTH 200 HEIGHT 110 DEFAULT "%v_choose_field%")

IF isdefined(userentry) = f PAUSE "%v_invalid_field_message2%"
IF isdefined(userentry) = f RETURN ALL
RETURN

PROCEDURE Choose_Users
DIALOG (DIALOG TITLE "%v_JE07b_dialog3_title%" WIDTH 340 HEIGHT 225 ) (BUTTONSET TITLE "&OK" AT 132 180 DEFAULT 1 HORZ ) (TEXT TITLE "%v_JE07b_dialog3_text1%" AT 36 60 ) (DROPDOWN TITLE User_List TO "Selected_Name" AT 168 58 WIDTH 131 HEIGHT 23 ) (RADIOBUTTON TITLE "%v_JE07b_dialog3_text2%" TO "RADIO1" AT 216 130 DEFAULT 2 HORZ ) (TEXT TITLE "%v_JE07b_dialog3_text3%" AT 36 132 )

Users[Counter] = substring(Selected_Name 1 20)
Counter = Counter + 1
Flag = F if RADIO1 = 2
RETURN

