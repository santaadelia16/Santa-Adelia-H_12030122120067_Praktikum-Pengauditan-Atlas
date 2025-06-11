COMMENT - Copyright Arbutus Software Inc. 2018
SET DEFAULT
SET ECHO NONE
SET SAFETY OFF
CLOSE PRIMARY ALL
DELETE ALL OK
DO SMARTAPPS_IN_HEADER_

DO .USER_INPUTS

SET FOLDER \Inventory Results

EXTRACT RECORD TO %v_IN09_output% if %amount_entry% >= EDIT1

IF WRITE1=0 PAUSE "%v_IN09_noresults_message%"
IF WRITE1=0 CLOSE
IF WRITE1>0 PAUSE "%v_IN09_results_message%"
IF WRITE1>0 OPEN %v_IN09_output%
RETURN

PROCEDURE USER_INPUTS
DIALOG (DIALOG TITLE "%v_title_select_table%" WIDTH 373 HEIGHT 182 ) (BUTTONSET TITLE "&OK;&Cancel" AT 108 144 DEFAULT 1 HORZ ) (TEXT TITLE "%v_IN_text_title%" AT 36 24 ) (ITEM TITLE "f" TO "tablename" AT 144 22 WIDTH 192 HEIGHT 154 DEFAULT "%v_choose_table%" )

IF ftype(tablename 'f') <> 'f' PAUSE "%v_no_table_message%"
IF ftype(tablename 'f') <> 'f' RETURN ALL

OPEN %tablename%

DIALOG (DIALOG TITLE "%v_IN09_dialog2_title%" WIDTH 391 HEIGHT 209 ) (BUTTONSET TITLE "&OK;&Cancel" AT 132 168 DEFAULT 1 HORZ ) (TEXT TITLE "%v_IN09_dialog2_text1%" AT 24 60 WIDTH 111 HEIGHT 48 ) (ITEM TITLE "N" TO "amount_entry" AT 168 20 WIDTH 200 HEIGHT 152 DEFAULT "%v_choose_field%" ) (EDIT TO "EDIT1" AT 168 60 WIDTH 126 DEFAULT "1000" NUM ) (TEXT TITLE "%v_IN09_dialog2_text2%" AT 24 24 )

IF isdefined(amount_entry) = f PAUSE "%v_invalid_field_message2%"
IF isdefined(amount_entry) = f RETURN ALL
RETURN


