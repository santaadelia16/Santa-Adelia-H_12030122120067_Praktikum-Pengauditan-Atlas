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

SUMMARIZE ON %v_vendor% %v_payee% TO TEMP_CLASSIFY_LIST1 IF BETWEEN(%transdate% startdate enddate) OPEN
CLASSIFY ON %v_vendor% TO TEMP_CLASSIFY_LIST2 OPEN
COUNTER = WRITE1
EXTRACT RECORD TO TEMP_EXCEPTION_LIST IF COUNT > 1

OPEN %tablename%
OPEN TEMP_EXCEPTION_LIST SECONDARY

SET FOLDER \Fraud Compliance Results

JOIN PKEY %v_vendor% FIELDS ALL SKEY %v_vendor% WITH COUNT IF BETWEEN(%transdate% startdate enddate) TO %v_FC06_output% PRESORT

CLOSE SECONDARY

IF WRITE1 = 0 CLOSE
IF WRITE1 = 0 PAUSE "%v_no_vendor_multiple_payee_names_message%"
IF WRITE1 > 0 PAUSE "%v_vendor_multiple_payee_names_message%"
IF WRITE1 > 0 OPEN %v_FC06_output%

DELETE TEMP OK
RETURN

procedure user_inputs
DIALOG (DIALOG TITLE "%v_FC04_dialog1_title%" WIDTH 464 HEIGHT 206 ) (BUTTONSET TITLE "&OK;&Cancel" AT 216 144 DEFAULT 1 HORZ ) (TEXT TITLE "%v_FC05_dialog1_text%" AT 36 24 ) (ITEM TITLE "f" TO "tablename" AT 216 20 WIDTH 220 HEIGHT 154)

IF ftype(tablename 'f') <> 'f' PAUSE "%v_no_table_message%"
IF ftype(tablename 'f') <> 'f' RETURN ALL

OPEN %tablename%

DIALOG (DIALOG TITLE "%v_FC04_dialog2_title%" WIDTH 462 HEIGHT 320 ) (BUTTONSET TITLE "&OK;&Cancel" AT 168 276 DEFAULT 1 HORZ ) (TEXT TITLE "%v_FC05_dialog2_text1%" AT 24 24 ) (TEXT TITLE "%v_FC06_dialog2_text1%" AT 24 72 ) (ITEM TITLE "C" TO "v_vendor" AT 216 22 WIDTH 183 ) (ITEM TITLE "C" TO "v_payee" AT 216 70 WIDTH 182 ) (TEXT TITLE "%v_FC05_dialog2_text3%" AT 24 120 ) (ITEM TITLE "D" TO "transdate" AT 216 118 WIDTH 182 ) (EDIT TO "startdate" AT 216 166 WIDTH 218 DATE ) (EDIT TO "enddate" AT 216 214 WIDTH 214 DATE ) (TEXT TITLE "%v_FC04_dialog2_text7%" AT 24 168 ) (TEXT TITLE "%v_FC04_dialog2_text8%" AT 24 216 )

IF ftype(v_vendor "C") = 'U' OR ftype(v_payee "C") = 'U' OR ftype(transdate "D") = 'U' PAUSE "%v_invalid_field_message2%"
IF ftype(v_vendor "C") = 'U' OR ftype(v_payee "C") = 'U' OR ftype(transdate "D") = 'U' RETURN ALL
RETURN



