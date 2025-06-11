COMMENT - Copyright Arbutus Software Inc. 2020
SET DEFAULT
SET ECHO NONE
SET SAFETY OFF
CLOSE PRIMARY ALL
DELETE ALL OK
SET TEMP "TEMP_"
DO SMARTAPPS_MISC_HEADER_

DO .USER_INPUTS

OPEN %v_tablename%

SUMMARIZE ON %v_key% FIELDS %v_amount% SUMMTYPE STDDEV AS 'STDDEV_Amount' %v_amount% SUMMTYPE AVG AS 'AVG_Amount' %v_amount% SUMMTYPE MEDIAN AS 'MEDIAN_Amount' %v_amount% SUMMTYPE MODE AS 'MODE_Amount' %v_amount% SUMMTYPE Q1 AS 'Q1_Amount' %v_amount% SUMMTYPE Q3 AS 'Q3_Amount' PRESORT TO "Temp_SummaryStatistics"

OPEN Temp_SummaryStatistics SECONDARY

JOIN PKEY %v_key% FIELDS %v_key% %v_amount% SKEY %v_key% WITH STDDEV_Amount AVG_Amount MEDIAN_Amount MODE_Amount Q1_Amount Q3_Amount TO "Temp_SummaryStats_JOIN" OPEN PRESORT SECSORT

CLOSE SECONDARY

SET FILTER TO %v_amount% < (MEDIAN_Amount-(v_STD*STDDEV_Amount)) OR %v_amount% > (MEDIAN_Amount+(v_STD*STDDEV_Amount))

SET FOLDER \Miscellaneous

EXTRACT FIELDS v_STD AS "No_Of_STD_Used" ALL TO %v_output%

IF WRITE1=0 PAUSE "%v_no_outliers_message%"
IF WRITE1=0 CLOSE
IF WRITE1>0 PAUSE "%v_outliers_message%"
IF WRITE1>0 OPEN %v_output%

DELETE TEMP OK
DELETE ALL OK
RETURN

PROCEDURE USER_INPUTS
DIALOG (DIALOG TITLE "%v_dialog_title%" WIDTH 590 HEIGHT 479 ) (BUTTONSET TITLE "&OK;&Cancel" AT 492 408 DEFAULT 1 ) (ITEM TITLE "f" TO "v_tablename" AT 240 22 WIDTH 192 DEFAULT " " OPEN ) (TEXT TITLE "%v_text1%" AT 60 24 ) (TEXT TITLE "%v_text2%" AT 60 228 ) (ITEM TITLE "N" TO "v_amount" AT 240 226 WIDTH 186 DEFAULT "" ) (TEXT TITLE "%v_text3%" AT 60 120 ) (ITEM TITLE "C" TO "v_key" AT 240 118 WIDTH 189 DEFAULT "" ) (RADIOBUTTON TITLE "1;2;3;4" TO "v_STD" AT 72 334 DEFAULT 2 ) (TEXT TITLE "%v_text4%" AT 60 300 )

IF ftype(v_tablename 'f')<>'f' PAUSE "%v_no_table_message%"
IF ftype(v_tablename 'f')<>'f' RETURN ALL

IF isblank(v_key) or isblank(v_amount) PAUSE "%v_invalid_field_message%"
IF isblank(v_key) or isblank(v_amount) RETURN ALL
RETURN
