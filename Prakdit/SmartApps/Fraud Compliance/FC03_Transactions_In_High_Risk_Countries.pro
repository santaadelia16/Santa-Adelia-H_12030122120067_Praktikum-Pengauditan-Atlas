comment - Copyright Arbutus Software Inc. 2018
SET DEFAULT
SET ECHO NONE
SET SAFETY OFF
CLOSE PRIMARY ALL
DELETE ALL OK
DO SMARTAPPS_FC_HEADER_

DO .user_inputs

SET FOLDER \Fraud Compliance Results

EXTRACT RECORD TO %v_FC03_output% IF LISTFIND("cleanlist.txt" NORMALIZE(%v_country%))

IF WRITE1=0 CLOSE
IF WRITE1=0 PAUSE "%v_no_highrisk_transactions_message%"
IF WRITE1>0 PAUSE "%v_highrisk_transactions_message%"
IF WRITE1>0 OPEN %v_FC03_output%

DELETE FORMAT templist OK
DELETE TEXT cleanlist OK
RETURN

procedure user_inputs
DIALOG (DIALOG TITLE "%v_FC03_dialog1_title%" WIDTH 401 HEIGHT 195 ) (BUTTONSET TITLE "&OK;&Cancel" AT 120 144 DEFAULT 1 HORZ ) (EDIT TO "v_List" AT 228 36 FILE ) (TEXT TITLE "%v_FC03_dialog1_text%" AT 12 36)

IF v_list = " " PAUSE "%v_no_country_list_message%"
IF v_list = " " RETURN ALL

IMPORT FILE TO templist RECORD_LENGTH 1000 CRLF FIELDS LINE ASCII 1 500 0 END "%v_list%"
EXPORT ASCII ALLTRIM(NORMALIZE(line)) to cleanlist

DIALOG (DIALOG TITLE "%v_FC02_dialog2_title%" WIDTH 401 HEIGHT 195 ) (BUTTONSET TITLE "&OK;&Cancel" AT 120 144 DEFAULT 1 HORZ ) (TEXT TITLE "%v_FC02_dialog2_text%" AT 12 36 ) (ITEM TITLE "f" TO "v_tablename" AT 168 34 WIDTH 180 HEIGHT 25 )

IF ftype(v_tablename 'f') <> 'f' PAUSE "%v_no_table_message%"
IF ftype(v_tablename 'f') <> 'f' RETURN ALL

OPEN %v_tablename%

DIALOG (DIALOG TITLE "%v_FC03_dialog3_title%" WIDTH 401 HEIGHT 195 ) (BUTTONSET TITLE "&OK;&Cancel" AT 120 144 DEFAULT 1 HORZ ) (TEXT TITLE "%v_FC03_dialog3_text%" AT 12 36 ) (ITEM TITLE "C" TO "v_country" AT 156 32 WIDTH 200 )

IF ftype(v_country 'C') = 'U' PAUSE "%v_invalid_country_field_message%"
IF ftype(v_country 'C') = 'U' RETURN ALL
RETURN

