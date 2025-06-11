comment - Copyright Arbutus Software Inc. 2018
SET DEFAULT
SET ECHO NONE
SET SAFETY OFF
SET TEMP "TEMP_"
CLOSE PRIMARY ALL
DELETE ALL OK
DO SMARTAPPS_FC_HEADER_

DO .user_inputs

SUMMARIZE ON %v_vendor% %v_employee% ACCUMULATE %v_amount% AS "TOTAL_AMOUNT" TO Temp_Payment_Summary_On_Vendor_Employee IF %v_type% = v_code OPEN
EXTRACT RECORD TO Temp_Vendor_Employee_Multiple_Payments IF COUNT >= 2

OPEN %v_tablename%
OPEN Temp_Vendor_Employee_Multiple_Payments SECONDARY
JOIN PKEY %v_vendor% %v_employee% FIELDS ALL SKEY %v_vendor% %v_employee% WITH TOTAL_AMOUNT TO "Temp_Vendors_With_Multiple_Payments_Same_Employee" PRESORT SECSORT OPEN

CLOSE SECONDARY

SET FOLDER \Fraud Compliance Results

EXTRACT RECORD TO %v_FC08_output% IF TOTAL_AMOUNT >%v_limit% OR (TOTAL_AMOUNT < %v_limit% AND (%v_limit%-TOTAL_AMOUNT/%v_limit%*1.00) >= v_percent/100.00)

IF WRITE1 = 0 CLOSE
IF WRITE1 = 0 PAUSE "%v_no_payments_exceeding_limit_same_employee%"
IF WRITE1 > 0 PAUSE "%v_payments_exceeding_limit_same_employee%"
IF WRITE1 > 0 OPEN %v_FC08_output%

DELETE TEMP OK
RETURN

PROCEDURE user_inputs
DIALOG (DIALOG TITLE "%v_FC04_dialog1_title%" WIDTH 413 HEIGHT 200 ) (BUTTONSET TITLE "&OK;&Cancel" AT 144 144 DEFAULT 1 HORZ ) (TEXT TITLE "%v_FC02_dialog2_title%" AT 12 36 ) (ITEM TITLE "f" TO "v_tablename" AT 144 32 WIDTH 220)

IF ftype(v_tablename 'f') <> 'f' PAUSE "%v_no_table_message%"
IF ftype(v_tablename 'f') <> 'f' RETURN ALL

OPEN %v_tablename%

DIALOG (DIALOG TITLE "%v_FC08_dialog2_title%" WIDTH 475 HEIGHT 443 ) (BUTTONSET TITLE "&OK;&Cancel" AT 180 396 DEFAULT 1 HORZ ) (TEXT TITLE "%v_FC05_dialog2_text1%:" AT 12 36 ) (ITEM TITLE "C" TO "v_vendor" AT 216 34 WIDTH 200 ) (TEXT TITLE "%v_FC08_dialog2_text1%" AT 12 84 ) (TEXT TITLE "%v_FC04_dialog2_text4%" AT 12 132 ) (TEXT TITLE "%v_FC08_dialog2_text2%" AT 12 228 ) (ITEM TITLE "C" TO "v_employee" AT 216 82 WIDTH 200 ) (ITEM TITLE "C" TO "v_type" AT 216 130 WIDTH 200 ) (TEXT TITLE "%v_FC08_dialog2_text3%" AT 12 180 ) (EDIT TO "v_code" AT 216 178 CHAR ) (ITEM TITLE "N" TO "v_amount" AT 216 226 WIDTH 200 ) (TEXT TITLE "%v_FC08_dialog2_text4%" AT 12 276 ) (ITEM TITLE "N" TO "v_limit" AT 216 274 WIDTH 200 ) (TEXT TITLE "%v_FC08_dialog2_text5%" AT 12 324 WIDTH 198 HEIGHT 62 ) (EDIT TO "v_percent" AT 216 322 NUM )

IF ftype(v_vendor 'C') = 'U' OR ftype(v_employee 'C') = 'U' OR ftype(v_type 'C') = 'U' OR ftype(v_amount 'N') = 'U' OR ftype(v_limit 'N') = 'U' OR length(alltrim(v_code)) = 0 OR NOT BETWEEN(v_percent 1 99) PAUSE "%v_invalid_field_message1%."
IF ftype(v_vendor 'C') = 'U' OR ftype(v_employee 'C') = 'U' OR ftype(v_type 'C') = 'U' OR ftype(v_amount 'N') = 'U' OR ftype(v_limit 'N') = 'U' OR length(alltrim(v_code)) = 0 OR NOT BETWEEN(v_percent 1 99) RETURN ALL
RETURN

