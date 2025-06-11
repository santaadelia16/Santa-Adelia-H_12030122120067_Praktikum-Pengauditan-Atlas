COMMENT - Copyright Arbutus Software Inc. 2018
SET DEFAULT
SET ECHO NONE
SET SAFETY OFF
CLOSE PRIMARY ALL
DELETE ALL OK
DO SMARTAPPS_GL_HEADER_

DO .USER_INPUTS

Counter = 1
Flag = t
SearchComment = Blanks(30)
DO .Get_Comments While Flag = T and Counter <= 10

OPEN %tablename%

SET FOLDER \General Ledger Results

Extract Record to %v_JE17_output% if Listfind(Comment_List %commententry%)

IF WRITE1 = 0 PAUSE "%v_JE17_noresults_message%"
IF WRITE1 = 0 CLOSE
IF WRITE1 > 0 PAUSE "%v_JE17_results_message%"
IF WRITE1 > 0 OPEN %v_JE17_output%
RETURN

PROCEDURE USER_INPUTS
DIALOG (DIALOG TITLE "%v_title_select_table%" WIDTH 388 HEIGHT 190 ) (BUTTONSET TITLE "&OK;&Cancel" AT 120 144 DEFAULT 1 HORZ ) (TEXT TITLE "%v_JE_text_title%" AT 36 24 ) (ITEM TITLE "f" TO "tablename" AT 168 22 WIDTH 200 HEIGHT 154 DEFAULT "%v_choose_table%" )

IF ftype(tablename 'f') <> 'f' PAUSE "%v_no_table_message%"
IF ftype(tablename 'f') <> 'f' RETURN ALL

OPEN %tablename%

DIALOG (DIALOG TITLE "%v_JE17_dialog2_title%" WIDTH 367 HEIGHT 211 ) (BUTTONSET TITLE "&OK;&Cancel" AT 120 168 DEFAULT 1 HORZ ) (TEXT TITLE "%v_JE17_dialog2_text1%" AT 24 24 ) (ITEM TITLE "C" TO "commententry" AT 168 22 WIDTH 174 HEIGHT 110 DEFAULT "%v_choose_field%" )

IF isdefined(commententry) = f PAUSE "%v_invalid_field_message2%"
IF isdefined(commententry) = f RETURN ALL
RETURN

PROCEDURE Get_Comments

DIALOG (DIALOG TITLE "%v_JE17_dialog3_title%" WIDTH 348 HEIGHT 215 ) (BUTTONSET TITLE "&OK" AT 144 180 DEFAULT 1 HORZ ) (TEXT TITLE "%v_JE17_dialog3_text1%" AT 24 60 WIDTH 87 HEIGHT 43 ) (RADIOBUTTON TITLE "%v_JE07b_dialog3_text2%" TO "RADIO1" AT 216 130 DEFAULT 2 HORZ ) (TEXT TITLE "%v_JE17_dialog3_text2%" AT 24 132 ) (EDIT TO "SearchComment" AT 144 60 WIDTH 185 CHAR )

Comment_List[Counter] = substring(SearchComment 1 30)
Counter = Counter + 1
Flag = F if RADIO1 = 2
SearchComment = Blanks(30)
RETURN

