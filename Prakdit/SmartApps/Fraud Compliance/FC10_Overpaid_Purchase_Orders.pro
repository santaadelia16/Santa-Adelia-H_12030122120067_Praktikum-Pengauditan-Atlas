comment - Copyright Arbutus Software Inc. 2018
SET DEFAULT
SET ECHO NONE
SET SAFETY OFF
SET TEMP "TEMP_"
CLOSE PRIMARY ALL
DELETE ALL OK
DO SMARTAPPS_FC_HEADER_

DO .user_inputs

SORT ON %po_no% %po_date% TO Temp_Sorted_PO OPEN

SUMMARIZE ON %po_no% ACCUMULATE %pay_amt% OTHER %po_amt% TO Temp_Summary_On_PO_No PRESORT OPEN

SET FOLDER \Fraud Compliance Results

EXTRACT %po_no% %po_amt% %pay_amt% COUNT TO %v_FC10_output% IF %pay_amt%>%po_amt%

IF WRITE1 = 0 CLOSE
IF WRITE1 = 0 PAUSE "%v_no_payment_exceeds_po_amount%"
IF WRITE1 > 0 PAUSE "%v_payment_exceeds_po_amount%"
IF WRITE1 > 0 OPEN %v_FC10_output%

DELETE TEMP OK
RETURN

procedure user_inputs
DIALOG (DIALOG TITLE "%v_FC04_dialog1_title%" WIDTH 438 HEIGHT 201 ) (BUTTONSET TITLE "&OK;&Cancel" AT 168 144 DEFAULT 1 HORZ ) (TEXT TITLE "%v_FC10_dialog1_text%" AT 12 36 ) (ITEM TITLE "f" TO "tablename" AT 168 32 WIDTH 220 )

IF ftype(tablename 'f') <> 'f' PAUSE "%v_no_table_message%"
IF ftype(tablename 'f') <> 'f' RETURN ALL

OPEN %tablename%

DIALOG (DIALOG TITLE "%v_FC01_dialog3_title%" WIDTH 481 HEIGHT 277 ) (BUTTONSET TITLE "&OK;&Cancel" AT 228 228 DEFAULT 1 HORZ ) (TEXT TITLE "%v_FC10_dialog2_text1%" AT 12 24 ) (ITEM TITLE "C" TO "po_no" AT 228 20 WIDTH 200 ) (TEXT TITLE "%v_FC10_dialog2_text2%" AT 12 72 ) (ITEM TITLE "N" TO "po_amt" AT 228 68 WIDTH 200 ) (TEXT TITLE "%v_FC10_dialog2_text4%" AT 12 168 ) (ITEM TITLE "N" TO "pay_amt" AT 228 164 WIDTH 200 ) (TEXT TITLE "%v_FC10_dialog2_text3%" AT 12 120 ) (ITEM TITLE "D" TO "po_date" AT 228 116 WIDTH 200 )

IF ftype(po_no 'C') = 'U' OR ftype(po_amt 'N') = 'U' OR ftype(pay_amt 'N') = 'U' OR ftype(po_date 'D') = 'U' PAUSE "%v_invalid_field_message2%"
IF ftype(po_no 'C') = 'U' OR ftype(po_amt 'N') = 'U' OR ftype(pay_amt 'N') = 'U' OR ftype(po_date 'D') = 'U' RETURN ALL
RETURN

