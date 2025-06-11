COMMENT - Copyright Arbutus Software Inc. 2018
SET DEFAULT
SET ECHO NONE
SET SAFETY OFF
CLOSE PRIMARY ALL
DELETE ALL OK
DO SMARTAPPS_FA_HEADER_

DO .USER_INPUTS

SET FOLDER \Fixed Assets Results

EXTRACT RECORD TO %v_FA05_output% IF %depentry%>%costentry%

IF WRITE1=0 PAUSE "%v_FA05_results_message1%"
IF WRITE1=0 CLOSE
IF WRITE1>0 PAUSE "%v_FA05_results_message2%"
IF WRITE1>0 OPEN %v_FA05_output%
RETURN

PROCEDURE USER_INPUTS
DIALOG (DIALOG TITLE "%v_title_select_table%" WIDTH 413 HEIGHT 192 ) (BUTTONSET TITLE "&OK;&Cancel" AT 144 144 DEFAULT 1 HORZ ) (TEXT TITLE "%v_FA_text_title%" AT 36 24 ) (ITEM TITLE "f" TO "tablename" AT 144 20 WIDTH 220 HEIGHT 154 DEFAULT "%v_choose_table%" )

IF ftype(tablename 'f')<>'f' PAUSE "%v_no_table_message%"
IF ftype(tablename 'f')<>'f' RETURN ALL

OPEN %tablename%

DIALOG (DIALOG TITLE "%v_title_select_fields%" WIDTH 409 HEIGHT 240 ) (BUTTONSET TITLE "&OK;&Cancel" AT 132 192 DEFAULT 1 HORZ ) (TEXT TITLE "%v_FA05_dialog2_text1%" AT 36 48 ) (ITEM TITLE "N" TO "depentry" AT 192 46 WIDTH 178 HEIGHT 97 DEFAULT "%v_choose_field%" ) (TEXT TITLE "%v_FA05_dialog2_text2%" AT 36 132 ) (ITEM TITLE "N" TO "costentry" AT 192 130 WIDTH 175 HEIGHT 48 DEFAULT "%v_choose_field%" )

IF isdefined(depentry)=f OR isdefined(costentry)=f PAUSE "%v_invalid_field_message2%"
IF isdefined(depentry)=f OR isdefined(costentry)=f RETURN ALL
RETURN


