comment - Copyright Arbutus Software Inc. 2018
SET DEFAULT
SET ECHO NONE
SET SAFETY OFF
CLOSE PRIMARY ALL
DELETE ALL OK
DO SMARTAPPS_FC_HEADER_

DO .user_inputs

OPEN %vendor_tablename%
OPEN %employee_tablename% SECONDARY

SET FOLDER \Fraud Compliance Results

JOIN UNMATCHED PKEY %emp_approval% FIELDS ALL SKEY %emp_id% TO %v_FC07_output% PRESORT SECSORT

CLOSE SECONDARY

IF WRITE1 = 0 CLOSE
IF WRITE1 = 0 PAUSE "%v_no_unauthorized_vendor_changes_message%"
IF WRITE1 > 0 PAUSE "%v_unauthorized_vendor_changes_message%"
IF WRITE1 > 0 OPEN %v_FC07_output%

SET ECHO ON

procedure user_inputs
DIALOG (DIALOG TITLE "%v_FC07_dialog1_title%" WIDTH 422 HEIGHT 198 ) (BUTTONSET TITLE "&OK;&Cancel" AT 168 144 DEFAULT 1 HORZ ) (TEXT TITLE "%v_FC05_dialog1_text%" AT 12 36 ) (ITEM TITLE "f" TO "vendor_tablename" AT 168 32 WIDTH 220)

IF ftype(vendor_tablename 'f') <> 'f' PAUSE "%v_no_table_message%"
IF ftype(vendor_tablename 'f') <> 'f' RETURN ALL

OPEN %vendor_tablename%

DIALOG (DIALOG TITLE "%v_FC07_dialog2_title%" WIDTH 445 HEIGHT 192 ) (BUTTONSET TITLE "&OK;&Cancel" AT 204 144 DEFAULT 1 HORZ ) (TEXT TITLE "%v_FC07_dialog2_title%" AT 12 36 ) (ITEM TITLE "C" TO "emp_approval" AT 204 32 WIDTH 200 )

IF ftype(emp_approval 'C') = 'U' PAUSE "%v_no_employee_approval_field%"
IF ftype(emp_approval 'C') = 'U' RETURN ALL

DIALOG (DIALOG TITLE "%v_FC07_dialog3_title%" WIDTH 464 HEIGHT 216 ) (BUTTONSET TITLE "&OK;&Cancel" AT 204 144 DEFAULT 1 HORZ ) (TEXT TITLE "%v_FC07_dialog3_title%" AT 12 36 ) (ITEM TITLE "f" TO "employee_tablename" AT 204 32 WIDTH 220 )

IF ftype(employee_tablename 'f') <> 'f' PAUSE "%v_no_employee_approval_table%"
IF ftype(employee_tablename 'f') <> 'f' RETURN ALL

OPEN %employee_tablename%

DIALOG (DIALOG TITLE "%v_FC04_dialog2_text1%" WIDTH 448 HEIGHT 195 ) (BUTTONSET TITLE "&OK;&Cancel" AT 168 144 DEFAULT 1 HORZ ) (TEXT TITLE "%v_FC04_dialog2_text1%" AT 12 36 ) (ITEM TITLE "C" TO "emp_id" AT 168 32 WIDTH 200 )

IF ftype(emp_id 'C') = 'U' PAUSE "%v_no_valid_employeeID_message%"
IF ftype(emp_id 'C') = 'U' RETURN ALL
RETURN

