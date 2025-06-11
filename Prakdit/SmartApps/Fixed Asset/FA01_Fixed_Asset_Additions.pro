COMMENT - Copyright Arbutus Software Inc. 2018
SET DEFAULT
SET ECHO NONE
SET SAFETY OFF
CLOSE PRIMARY ALL
DELETE ALL OK
DO SMARTAPPS_FA_HEADER_
SET DATE "YYYYMMDD"

DO .USER_INPUTS

SET FOLDER \Fixed Assets Results

EXTRACT RECORD TO %v_FA01_output% IF %dateentry1%>DATE1

IF WRITE1=0 PAUSE "%v_FA01_results_message1%"
IF WRITE1=0 CLOSE
IF WRITE1>0 PAUSE "%v_FA01_results_message2%"
IF WRITE1>0 OPEN %v_FA01_output%
RETURN

PROCEDURE USER_INPUTS
DIALOG (DIALOG TITLE "%v_title_select_table%" WIDTH 418 HEIGHT 198 ) (BUTTONSET TITLE "&OK;&Cancel" AT 156 144 DEFAULT 1 HORZ ) (TEXT TITLE "%v_FA_text_title%" AT 36 24 ) (ITEM TITLE "f" TO "tablename" AT 156 20 WIDTH 220 HEIGHT 154 DEFAULT "%v_choose_table%" )

IF ftype(tablename 'f')<>'f' PAUSE "%v_no_table_message%"
IF ftype(tablename 'f')<>'f' RETURN ALL

OPEN %tablename%

DIALOG (DIALOG TITLE "%v_title_select_fields%" WIDTH 357 HEIGHT 216 ) (BUTTONSET TITLE "&OK;&Cancel" AT 108 180 DEFAULT 1 HORZ ) (TEXT TITLE "%v_FA01_dialog2_text1%" AT 36 36 ) (ITEM TITLE "D" TO "dateentry1" AT 156 34 WIDTH 178 HEIGHT 97 DEFAULT "%v_choose_field%" ) (EDIT TO "Date1" AT 132 106 WIDTH 211 HEIGHT 20 DEFAULT "%v_specify_cutoff_date%" DATE ) (TEXT TITLE "%v_FA01_dialog2_text2%" AT 36 108 )

IF isdefined(dateentry1)=f PAUSE "%v_invalid_field_message1%"
IF isdefined(dateentry1)=f RETURN ALL
RETURN
