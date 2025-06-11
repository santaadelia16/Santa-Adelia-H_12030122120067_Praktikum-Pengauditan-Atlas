comment - Copyright Arbutus Software Inc. 2018
SET DEFAULT
SET ECHO NONE
SET SAFETY OFF
CLOSE PRIMARY ALL
DELETE ALL OK
DO SMARTAPPS_FC_HEADER_

DO .user_inputs

SET FOLDER \Fraud Compliance Results

EXTRACT RECORD TO %v_FC09_output% IF %inv_amt%>%goods_amt%

IF WRITE1 = 0 CLOSE
IF WRITE1 = 0 PAUSE "%v_no_invoice_exceeds_purchase%"
IF WRITE1 > 0 PAUSE "%v_invoice_exceeds_purchase%"
IF WRITE1 > 0 OPEN %v_FC09_output%
RETURN

procedure user_inputs
DIALOG (DIALOG TITLE "%v_FC04_dialog1_title%" WIDTH 438 HEIGHT 204 ) (BUTTONSET TITLE "&OK;&Cancel" AT 156 144 DEFAULT 1 HORZ ) (TEXT TITLE "%v_FC09_dialog1_text%" AT 12 36 ) (ITEM TITLE "f" TO "tablename" AT 156 32 WIDTH 220 )

IF ftype(tablename 'f') <> 'f' PAUSE "%v_no_table_message%"
IF ftype(tablename 'f') <> 'f' RETURN ALL

OPEN %tablename%

DIALOG (DIALOG TITLE "%v_FC01_dialog3_title%" WIDTH 495 HEIGHT 199 ) (BUTTONSET TITLE "&OK;&Cancel" AT 168 144 DEFAULT 1 HORZ ) (TEXT TITLE "%v_FC09_dialog2_text1%" AT 12 24 ) (ITEM TITLE "N" TO "Inv_Amt" AT 252 22 WIDTH 173 ) (TEXT TITLE "%v_FC09_dialog2_text2%" AT 12 72 ) (ITEM TITLE "N" TO "goods_amt" AT 252 70 WIDTH 175 )

IF ftype(inv_amt 'N') = 'U' OR ftype(goods_amt 'N') = 'U' PAUSE "%v_invalid_field_message2%"
IF ftype(inv_amt 'N') = 'U' OR ftype(goods_amt 'N') = 'U' RETURN ALL
RETURN
