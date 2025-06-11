COMMENT - Copyright Arbutus Software Inc. 2021
SET DEFAULT
SET ECHO NONE
SET SAFETY OFF
SET TEMP "TEMP_"
CLOSE PRIMARY ALL
DELETE ALL OK
DO SMARTAPPS_IN_HEADER_

DO .USER_INPUTS

SORT ON %prodnoentry% %salespriceentry% D IF %unitcostentry%>%salespriceentry% TO "Temp_Sorted_Inventory" OPEN

SET FOLDER \Inventory Results

SUMMARIZE ON %prodnoentry% OTHER %unitcostentry% %salespriceentry% %pricedateentry% TO "%v_IN11_output%" OPEN

IF WRITE1=0 PAUSE "%v_IN11_noresults_message%"
IF WRITE1=0 CLOSE
IF WRITE1>0 PAUSE "%v_IN11_results_message%"
IF WRITE1>0 OPEN %v_IN11_output%

DELETE TEMP OK
RETURN

PROCEDURE USER_INPUTS
DIALOG (DIALOG TITLE "%v_title_select_table%" WIDTH 373 HEIGHT 182 ) (BUTTONSET TITLE "&OK;&Cancel" AT 108 144 DEFAULT 1 HORZ ) (TEXT TITLE "%v_IN_text_title%" AT 36 24 ) (ITEM TITLE "f" TO "tablename" AT 156 22 WIDTH 189 HEIGHT 154 DEFAULT "%v_choose_table%" )

IF ftype(tablename 'f') <> 'f' PAUSE "%v_no_table_message%"
IF ftype(tablename 'f') <> 'f' RETURN ALL

OPEN %tablename%

DIALOG (DIALOG TITLE "%v_IN11_dialog2_title%" WIDTH 411 HEIGHT 204 ) (BUTTONSET TITLE "&OK;&Cancel" AT 132 168 DEFAULT 1 HORZ ) (TEXT TITLE "%v_IN11_dialog2_text1%" AT 36 48 ) (ITEM TITLE "D" TO "pricedateentry" AT 180 46 WIDTH 200 HEIGHT 78 DEFAULT "%v_choose_field%" ) (TEXT TITLE "%v_IN06_dialog2_text1%" AT 36 120 HEIGHT 15 ) (ITEM TITLE "N" TO "unitcostentry" AT 180 118 WIDTH 200 HEIGHT 65 DEFAULT "%v_choose_field%" ) (TEXT TITLE "%v_IN03_dialog2_text1%" AT 36 12 ) (ITEM TITLE "C" TO "prodnoentry" AT 180 10 WIDTH 200 HEIGHT 84 DEFAULT "%v_choose_field%" ) (TEXT TITLE "%v_IN11_dialog2_text2%" AT 36 84 ) (ITEM TITLE "N" TO "salespriceentry" AT 180 82 WIDTH 200 HEIGHT 76 DEFAULT "%v_choose_field%" )

IF isdefined(prodnoentry) = f or isdefined(pricedateentry) = f or isdefined(salespriceentry) = f or isdefined(unitcostentry) = f PAUSE "%v_invalid_field_message2%"
IF isdefined(prodnoentry) = f or isdefined(pricedateentry) = f or isdefined(salespriceentry) = f or isdefined(unitcostentry) = f RETURN ALL
RETURN

