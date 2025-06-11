comment - Copyright Arbutus Software Inc. 2018
SET DEFAULT
SET ECHO NONE
SET SAFETY OFF
CLOSE PRIMARY ALL
DELETE ALL OK
DO SMARTAPPS_FC_HEADER_

DO .user_inputs

SET FOLDER \Fraud Compliance Results

EXTRACT RECORD TO %v_FC01_output% IF (%v_expensetype%<>"%v_mealcode%" and LISTFIND("cleanlist.txt" NORMALIZE(%v_vendor%))) OR (%v_expensetype%="%v_mealcode%" and LISTFIND("cleanlist.txt" NORMALIZE(%v_attendee%)))

IF WRITE1 = 0 CLOSE
IF WRITE1 = 0 PAUSE "%v_no_matches_message%"
IF WRITE1 > 0 PAUSE "%v_matches_message%"
IF WRITE1 > 0 OPEN %v_FC01_output%

DELETE FORMAT templist OK
DELETE TEXT "cleanlist" OK
RETURN

procedure user_inputs
DIALOG (DIALOG TITLE "Select Sanctioned Provider List" WIDTH 525 HEIGHT 175 ) (BUTTONSET TITLE "&OK;&Cancel" AT 192 132 DEFAULT 1 HORZ ) (EDIT TO "v_list" AT 372 34 FILE ) (TEXT TITLE "Select the text file containing the list of Sanctioned Providers" AT 24 36 )

IF v_list = " " PAUSE "%v_no_providerlist_message%"
IF v_list = " " RETURN

IMPORT FILE TO templist RECORD_LENGTH 1000 CRLF FIELDS LINE ASCII 1 500 0 END "%v_list%"
EXPORT ASCII ALLTRIM(NORMALIZE(line)) to cleanlist

DIALOG (DIALOG TITLE "%v_FC01_dialog2_title%" WIDTH 379 HEIGHT 194 ) (BUTTONSET TITLE "&OK;&Cancel" AT 132 144 DEFAULT 1 HORZ ) (TEXT TITLE "%v_FC01_dialog2_text%" AT 12 36 ) (ITEM TITLE "f" TO "v_tablename" AT 144 32 WIDTH 200 )

IF ftype(v_tablename 'f') <> 'f' PAUSE "%v_no_table_message%"
IF ftype(v_tablename 'f') <> 'f' RETURN ALL

OPEN %v_tablename%

DIALOG (DIALOG TITLE "%v_FC01_dialog3_title%" WIDTH 425 HEIGHT 295 ) (BUTTONSET TITLE "&OK;&Cancel" AT 144 252 DEFAULT 1 HORZ ) (TEXT TITLE "%v_FC01_dialog3_text1%" AT 24 24 ) (TEXT TITLE "%v_FC01_dialog3_text2%" AT 24 72 ) (ITEM TITLE "C" TO "v_vendor" AT 204 22 WIDTH 186 ) (ITEM TITLE "C" TO "v_attendee" AT 204 70 WIDTH 186 ) (TEXT TITLE "%v_FC01_dialog3_text4%" AT 24 168 ) (TEXT TITLE "%v_FC01_dialog3_text3%" AT 24 120 ) (EDIT TO "v_mealcode" AT 204 166 WIDTH 108 CHAR ) (ITEM TITLE "C" TO "v_expensetype" AT 204 118 WIDTH 185 )

IF isdefined(v_vendor) = f or isdefined(v_attendee) = f or isdefined(v_expensetype) = f or length(alltrim(v_mealcode)) = 0 PAUSE "%v_invalid_field_message1%"
IF isdefined(v_vendor) = f or isdefined(v_attendee) = f or isdefined(v_expensetype) = f or length(alltrim(v_mealcode)) = 0 RETURN ALL
RETURN

