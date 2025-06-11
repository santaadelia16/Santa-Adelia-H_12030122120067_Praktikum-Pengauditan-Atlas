comment - Copyright Arbutus Software Inc. 2018
SET DEFAULT
SET ECHO NONE
SET SAFETY OFF
CLOSE PRIMARY ALL
DELETE ALL OK
DO SMARTAPPS_FC_HEADER_

DIALOG (DIALOG TITLE "%v_FC02_dialog1_title%" WIDTH 401 HEIGHT 195 ) (BUTTONSET TITLE "&OK;&Cancel" AT 120 144 DEFAULT 1 HORZ ) (EDIT TO "v_List" AT 228 36 FILE ) (TEXT TITLE "%v_FC02_dialog1_text%" AT 12 36 )

IF v_list=" " PAUSE "%v_no_keywordlist_message%"
IF v_list=" " RETURN ALL

IMPORT FILE TO templist RECORD_LENGTH 1000 CRLF FIELDS LINE ASCII 1 500 0 END "%v_list%"
EXPORT ASCII ALLTRIM(NORMALIZE(line)) to cleanlist

DIALOG (DIALOG TITLE "%v_FC02_dialog2_title%" WIDTH 401 HEIGHT 195 ) (BUTTONSET TITLE "&OK;&Cancel" AT 144 144 DEFAULT 1 HORZ ) (TEXT TITLE "%v_FC02_dialog2_text%" AT 12 36 ) (ITEM TITLE "f" TO "v_tablename" AT 144 32 WIDTH 220 )

IF ftype(v_tablename 'f') <> 'f' PAUSE "%v_no_table_message%"
IF ftype(v_tablename 'f') <> 'f' RETURN ALL

OPEN %v_tablename%

DIALOG (DIALOG TITLE "%v_FC02_dialog3_title%" WIDTH 425 HEIGHT 295 ) (BUTTONSET TITLE "&OK;&Cancel" AT 144 252 DEFAULT 1 HORZ ) (TEXT TITLE "%v_FC02_dialog3_text1%" AT 24 24 ) (ITEM TITLE "C" TO "Field1" AT 192 20 WIDTH 200 ) (TEXT TITLE "%v_FC02_dialog3_text2%" AT 24 72 ) (ITEM TITLE "C" TO "Field2" AT 192 68 WIDTH 200 ) (TEXT TITLE "%v_FC02_dialog3_text3%" AT 24 120 ) (ITEM TITLE "C" TO "Field3" AT 192 116 WIDTH 200 ) (TEXT TITLE "%v_FC02_dialog3_text4%" AT 24 168 ) (ITEM TITLE "C" TO "Field4" AT 192 164 WIDTH 200 )

IF ftype(field1 'C') = 'U' AND ftype(field2 'C') = 'U' AND ftype(field3 'C') = 'U' AND ftype(field4 'C') = 'U' PAUSE "%v_invalid_field_message2%"
IF ftype(field1 'C') = 'U' AND ftype(field2 'C') = 'U' AND ftype(field3 'C') = 'U' AND ftype(field4 'C') = 'U' RETURN ALL

DELETE FORMAT %v_FC02_output% OK
ASSIGN COUNTER=0

IF ftype(field1 'C') <> 'U' v_fieldname=field1
IF ftype(field1 'C') <> 'U' DO .EXTRACT_KEYWORD_MATCHES
IF ftype(field1 'C') <> 'U' ASSIGN COUNTER=COUNTER+WRITE1

IF ftype(field2 'C') <> 'U' v_fieldname=field2
IF ftype(field2 'C') <> 'U' DO .EXTRACT_KEYWORD_MATCHES
IF ftype(field2 'C') <> 'U' ASSIGN COUNTER=COUNTER+WRITE1

IF ftype(field3 'C') <> 'U' v_fieldname=field3
IF ftype(field3 'C') <> 'U' DO .EXTRACT_KEYWORD_MATCHES
IF ftype(field3 'C') <> 'U' ASSIGN COUNTER=COUNTER+WRITE1

IF ftype(field4 'C') <> 'U' v_fieldname=field4
IF ftype(field4 'C') <> 'U' DO .EXTRACT_KEYWORD_MATCHES
IF ftype(field4 'C') <> 'U' ASSIGN COUNTER=COUNTER+WRITE1

IF COUNTER=0 CLOSE
IF COUNTER=0 PAUSE "%v_no_matches_message%"
IF COUNTER>0 PAUSE "%v_matches_message%"
IF COUNTER>0 OPEN %v_FC02_output%

DELETE FORMAT templist OK
DELETE TEXT cleanlist OK
RETURN

PROCEDURE EXTRACT_KEYWORD_MATCHES
SET FOLDER \Fraud Compliance Results
EXTRACT RECORD TO %v_FC02_output% IF LISTFIND("cleanlist.txt" NORMALIZE(%v_fieldname%)) APPEND
RETURN
