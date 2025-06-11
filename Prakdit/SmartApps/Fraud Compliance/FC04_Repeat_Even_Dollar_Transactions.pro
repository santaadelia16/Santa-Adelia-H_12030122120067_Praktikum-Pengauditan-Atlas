comment - Copyright Arbutus Software Inc. 2018
SET DEFAULT
SET ECHO NONE
SET SAFETY OFF
SET TEMP "TEMP_"
CLOSE PRIMARY ALL
DELETE ALL OK
DO SMARTAPPS_FC_HEADER_
SET DATE "%v_date_settings%"

DO .user_inputs

CLASSIFY ON %employee% TO TEMP_CLASSIFY_LIST IF round(%v_amount%) = %v_amount% AND %v_amount% >= threshold AND %transdate% >= startdate AND %transdate% <= enddate AND %cashtype% = code OPEN

EXTRACT RECORD TO TEMP_EXCEPTION_LIST IF COUNT > no_of_items

OPEN %tablename%
OPEN TEMP_EXCEPTION_LIST SECONDARY

SET FOLDER \Fraud Compliance Results

JOIN PKEY %employee% FIELDS ALL SKEY %employee% WITH COUNT IF round(%v_amount%) = %v_amount% AND %v_amount% >= threshold AND %transdate% >= startdate AND %transdate% <= enddate AND %cashtype% = code TO %v_FC04_output% PRESORT

CLOSE SECONDARY

IF WRITE1 = 0 CLOSE
IF WRITE1 = 0 PAUSE "%v_no_evendollar_message%"
IF WRITE1 > 0 PAUSE "%v_evendollar_message%"
IF WRITE1 > 0 OPEN %v_FC04_output%

DELETE TEMP OK
RETURN

procedure user_inputs
DIALOG (DIALOG TITLE "%v_FC04_dialog1_title%" WIDTH 469 HEIGHT 224 ) (BUTTONSET TITLE "&OK;&Cancel" AT 192 144 DEFAULT 1 HORZ ) (TEXT TITLE "%v_FC04_dialog1_text%" AT 36 24 ) (ITEM TITLE "f" TO "tablename" AT 192 20 WIDTH 220 HEIGHT 154)

IF ftype(tablename 'f') <> 'f' PAUSE "%v_no_table_message%"
IF ftype(tablename 'f') <> 'f' RETURN ALL

OPEN %tablename%

DIALOG (DIALOG TITLE "%v_FC04_dialog2_title%" WIDTH 432 HEIGHT 526 ) (BUTTONSET TITLE "&OK;&Cancel" AT 132 480 DEFAULT 1 HORZ ) (TEXT TITLE "%v_FC04_dialog2_text1%" AT 24 24 ) (TEXT TITLE "%v_FC04_dialog2_text2%" AT 24 72 ) (ITEM TITLE "C" TO "employee" AT 202 20 WIDTH 200 ) (ITEM TITLE "N" TO "v_amount" AT 204 68 WIDTH 200 ) (TEXT TITLE "%v_FC04_dialog2_text3%" AT 24 168 ) (TEXT TITLE "%v_FC04_dialog2_text4%" AT 24 120 ) (ITEM TITLE "C" TO "cashtype" AT 202 116 WIDTH 200 ) (EDIT TO "code" AT 202 168 WIDTH 200 CHAR ) (TEXT TITLE "%v_FC04_dialog2_text5%" AT 24 360 WIDTH 163 HEIGHT 29 ) (EDIT TO "no_of_items" AT 202 360 NUM ) (TEXT TITLE "%v_FC04_dialog2_text6%" AT 24 216 ) (ITEM TITLE "D" TO "transdate" AT 202 212 WIDTH 200 ) (EDIT TO "startdate" AT 204 262 WIDTH 208 DATE ) (EDIT TO "enddate" AT 204 310 WIDTH 209 DATE ) (TEXT TITLE "%v_FC04_dialog2_text7%" AT 24 264 ) (TEXT TITLE "%v_FC04_dialog2_text8%" AT 24 312 ) (TEXT TITLE "%v_FC04_dialog2_text9%" AT 24 408 ) (EDIT TO "threshold" AT 202 408 NUM )

IF ftype(employee "C") = 'U' OR ftype(v_amount "N") = 'U' OR ftype(cashtype "C") = 'U' OR ftype(transdate "D") = 'U' OR threshold = 0 or no_of_items = 0 or length(alltrim(code)) = 0 PAUSE "%v_invalid_field_message3%"
IF ftype(employee "C") = 'U' OR ftype(v_amount "N") = 'U' OR ftype(cashtype "C") = 'U' OR ftype(transdate "D") = 'U' OR threshold = 0 or no_of_items = 0 or length(alltrim(code)) = 0 RETURN ALL
RETURN
