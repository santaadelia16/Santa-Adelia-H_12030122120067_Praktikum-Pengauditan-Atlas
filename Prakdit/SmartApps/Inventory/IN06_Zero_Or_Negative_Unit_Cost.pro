COMMENT - Copyright Arbutus Software Inc. 2018
SET DEFAULT
SET ECHO NONE
SET SAFETY OFF
CLOSE PRIMARY ALL
DELETE ALL OK
DO SMARTAPPS_IN_HEADER_

DO .USER_INPUTS

SET FOLDER \Inventory Results

EXTRACT RECORD TO %v_IN06_output% IF %invententry1% <= 0

IF WRITE1=0 PAUSE "%v_IN06_noresults_message%"
IF WRITE1=0 CLOSE
IF WRITE1>0 PAUSE "%v_IN06_results_message%"
IF WRITE1>0 OPEN %v_IN06_output%
RETURN

PROCEDURE USER_INPUTS
DIALOG (DIALOG TITLE "%v_title_select_table%" WIDTH 373 HEIGHT 182 ) (BUTTONSET TITLE "&OK;&Cancel" AT 108 144 DEFAULT 1 HORZ ) (TEXT TITLE "%v_IN_text_title%" AT 36 24 ) (ITEM TITLE "f" TO "tablename" AT 156 22 WIDTH 187 HEIGHT 154 DEFAULT "%v_choose_table%" )

IF ftype(tablename 'f') <> 'f' PAUSE "%v_no_table_message%"
IF ftype(tablename 'f') <> 'f' RETURN ALL

OPEN %tablename%

DIALOG (DIALOG TITLE "%v_IN06_dialog2_title%" WIDTH 362 HEIGHT 211 ) (BUTTONSET TITLE "&OK;&Cancel" AT 120 168 DEFAULT 1 HORZ ) (TEXT TITLE "%v_IN06_dialog2_text1%" AT 36 36 ) (ITEM TITLE "N" TO "invententry1" AT 156 34 WIDTH 174 HEIGHT 97 DEFAULT "%v_choose_field%" )

IF isdefined(invententry1) = f PAUSE "%v_invalid_field_message2%"
IF isdefined(invententry1) = f RETURN ALL
RETURN

