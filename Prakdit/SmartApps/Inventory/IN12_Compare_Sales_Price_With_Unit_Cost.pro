COMMENT - Copyright Arbutus Software Inc. 2018
SET DEFAULT
SET ECHO NONE
SET SAFETY OFF
CLOSE PRIMARY ALL
DELETE ALL OK
DO SMARTAPPS_IN_HEADER_

DO .USER_INPUTS

SET FOLDER \Inventory Results

EXTRACT RECORD TO %v_IN12_output% IF %unitcostentry%>%salespriceentry%

IF WRITE1=0 PAUSE "%v_IN12_noresults_message%"
IF WRITE1=0 CLOSE
IF WRITE1>0 PAUSE "%v_IN12_results_message%"
IF WRITE1>0 OPEN %v_IN12_output%
RETURN

PROCEDURE USER_INPUTS
DIALOG (DIALOG TITLE "%v_title_select_table%" WIDTH 373 HEIGHT 182 ) (BUTTONSET TITLE "&OK;&Cancel" AT 108 144 DEFAULT 1 HORZ ) (TEXT TITLE "%v_IN_text_title%" AT 36 24 ) (ITEM TITLE "f" TO "tablename" AT 144 22 WIDTH 195 HEIGHT 154 DEFAULT "%v_choose_table%" )

IF ftype(tablename 'f') <> 'f' PAUSE "%v_no_table_message%"
IF ftype(tablename 'f') <> 'f' RETURN ALL

OPEN %tablename%

DIALOG (DIALOG TITLE "%v_IN11_dialog2_title%" WIDTH 384 HEIGHT 211 ) (BUTTONSET TITLE "&OK;&Cancel" AT 132 180 DEFAULT 1 HORZ ) (TEXT TITLE "%v_IN06_dialog2_text1%" AT 36 120 HEIGHT 15 ) (ITEM TITLE "N" TO "unitcostentry" AT 156 116 WIDTH 200 HEIGHT 65 DEFAULT "%v_choose_field%" ) (TEXT TITLE "%v_IN11_dialog2_text2%" AT 36 48 ) (ITEM TITLE "N" TO "salespriceentry" AT 156 44 WIDTH 200 HEIGHT 76 DEFAULT "%v_choose_field%" )

IF isdefined(salespriceentry) = f or isdefined(unitcostentry) = f PAUSE "%v_invalid_field_message2%"
IF isdefined(salespriceentry) = f or isdefined(unitcostentry) = f RETURN ALL
RETURN

