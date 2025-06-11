COMMENT - Copyright Arbutus Software Inc. 2021
SET DEFAULT
SET ECHO NONE
SET SAFETY OFF
CLOSE PRIMARY ALL
DELETE ALL OK
WRITE1 = 0
DO SMARTAPPS_AP_HEADER_

DO .USER_INPUTS

SET FOLDER \Accounts Payable Results

IF RADIO1=1 DUPLICATES ON %vendorentry% %invoiceentry% %dateentry% %amountentry% OTHER ALL TO "%v_AP02_output1%" PRESORT
IF RADIO1=1 AND WRITE1=0 PAUSE "%v_AP02_no_dupes_message1%"
IF RADIO1=1 AND WRITE1>0 PAUSE "%v_AP02_dupes_message1%"

IF RADIO2=1 DUPLICATES ON %vendorentry% %invoiceentry% %dateentry% %amountentry% NEAR ABS(INT(EDIT2)) TO "%v_AP02_output2%" Errorlimit %v_percent% PRESORT
IF RADIO2=1 AND WRITE1=0 PAUSE "%v_AP02_no_dupes_message2%"
IF RADIO2=1 AND WRITE1>0 PAUSE "%v_AP02_dupes_message2%"

IF RADIO3=1 DUPLICATES ON %vendorentry% %invoiceentry% %amountentry% %dateentry% NEAR ABS(INT(EDIT3)) TO "%v_AP02_output3%" Errorlimit %v_percent% PRESORT
IF RADIO3=1 AND WRITE1=0 PAUSE "%v_AP02_no_dupes_message3%"
IF RADIO3=1 AND WRITE1>0 PAUSE "%v_AP02_dupes_message3%"

IF RADIO4=1 DUPLICATES ON %vendorentry% %dateentry% %amountentry% %invoiceentry% SIMILAR ABS(INT(EDIT4)) TO "%v_AP02_output4%" Errorlimit %v_percent% PRESORT
IF RADIO4=1 AND WRITE1=0 PAUSE "%v_AP02_no_dupes_message4%"
IF RADIO4=1 AND WRITE1>0 PAUSE "%v_AP02_dupes_message4%"

IF RADIO5=1 DUPLICATES ON %invoiceentry% %dateentry% %amountentry% %vendorentry% SIMILAR ABS(INT(EDIT5)) TO "%v_AP02_output5%" Errorlimit %v_percent% PRESORT
IF RADIO5=1 AND WRITE1=0 PAUSE "%v_AP02_no_dupes_message5%"
IF RADIO5=1 AND WRITE1>0 PAUSE "%v_AP02_dupes_message5%"

PAUSE "Check the Accounts Payable Results folder for results"

CLOSE
RETURN

PROCEDURE USER_INPUTS
DIALOG (DIALOG TITLE "%v_title_select_table%" WIDTH 425 HEIGHT 204 ) (BUTTONSET TITLE "&OK;&Cancel" AT 180 144 DEFAULT 1 HORZ ) (TEXT TITLE "%v_AP_text_title%" AT 36 24 ) (ITEM TITLE "f" TO "tablename" AT 180 20 WIDTH 220 DEFAULT "%v_choose_table%" )

IF ftype(tablename 'f')<>'f' PAUSE "%v_no_table_message%"
IF ftype(tablename 'f')<>'f' RETURN ALL

OPEN %tablename%

DIALOG (DIALOG TITLE "%v_AP02_dialog2_title%" WIDTH 364 HEIGHT 302 ) (BUTTONSET TITLE "&OK;&Cancel" AT 120 252 DEFAULT 1 HORZ ) (TEXT TITLE "%v_AP02_field1%" AT 36 72 ) (ITEM TITLE "C" TO "invoiceentry" AT 132 68 WIDTH 200 HEIGHT 63 DEFAULT "%v_choose_field%" ) (TEXT TITLE "%v_AP02_field2%" AT 36 132 ) (ITEM TITLE "D" TO "dateentry" AT 132 128 WIDTH 200 HEIGHT 56 DEFAULT "%v_choose_field%" ) (TEXT TITLE "%v_AP02_field3%" AT 36 180 ) (ITEM TITLE "N" TO "amountentry" AT 132 176 WIDTH 200 HEIGHT 39 DEFAULT "%v_choose_field%" ) (ITEM TITLE "C" TO "vendorentry" AT 132 20 WIDTH 200 HEIGHT 38 DEFAULT "%v_choose_field%" ) (TEXT TITLE "%v_AP02_field4%" AT 36 24 )

IF isdefined(vendorentry)=f OR isdefined(invoiceentry)=f OR isdefined(dateentry)=f OR isdefined(amountentry)=f PAUSE "%v_invalid_field_message2%"
IF isdefined(vendorentry)=f OR isdefined(invoiceentry)=f OR isdefined(dateentry)=f OR isdefined(amountentry)=f RETURN ALL

DIALOG (DIALOG TITLE "%v_AP02_dialog3_title%" WIDTH 529 HEIGHT 198 ) (BUTTONSET TITLE "&OK" AT 240 144 DEFAULT 1 HORZ ) (TEXT TITLE "%v_AP02_field5%" AT 12 36 ) (DROPDOWN TITLE "10;15;20;25;30" TO "v_percent" AT 324 32 DEFAULT 1 ) (TEXT TITLE "%v_AP02_dialog3_note%" AT 24 72 WIDTH 253 HEIGHT 51 )

DIALOG (DIALOG TITLE "%v_AP02_dialog4_title%" WIDTH 696 HEIGHT 310 ) (BUTTONSET TITLE "&OK;&Cancel" AT 300 264 DEFAULT 1 HORZ ) (TEXT TITLE "%v_AP02_DupeTest1%" AT 24 60 ) (TEXT TITLE "%v_AP02_DupeTest2%" AT 24 96 ) (TEXT TITLE "%v_AP02_DupeTest3%" AT 24 132 ) (TEXT TITLE "%v_AP02_DupeTest4%" AT 24 168 ) (TEXT TITLE "%v_AP02_DupeTest5%" AT 24 204 ) (RADIOBUTTON TITLE "Yes;No" TO "RADIO1" AT 324 58 DEFAULT 1 HORZ ) (RADIOBUTTON TITLE "Yes;No" TO "RADIO2" AT 324 94 DEFAULT 1 HORZ ) (RADIOBUTTON TITLE "Yes;No" TO "RADIO3" AT 324 130 DEFAULT 1 HORZ ) (RADIOBUTTON TITLE "Yes;No" TO "RADIO4" AT 324 166 DEFAULT 1 HORZ ) (RADIOBUTTON TITLE "Yes;No" TO "RADIO5" AT 324 202 DEFAULT 1 HORZ ) (EDIT TO "EDIT2" AT 624 94 WIDTH 43 HEIGHT 20 DEFAULT "100" NUM ) (TEXT TITLE "%v_AP02_entry1%" AT 420 96 ) (EDIT TO "EDIT3" AT 624 130 WIDTH 36 DEFAULT "5" NUM ) (TEXT TITLE "%v_AP02_entry2%" AT 420 132 ) (EDIT TO "EDIT4" AT 624 166 WIDTH 34 DEFAULT "0" NUM ) (TEXT TITLE "%v_AP02_entry3%" AT 420 168 WIDTH 142 HEIGHT 27 ) (EDIT TO "EDIT5" AT 624 202 WIDTH 33 DEFAULT "0" NUM ) (TEXT TITLE "%v_AP02_entry3%" AT 420 204 WIDTH 152 HEIGHT 33 ) (TEXT TITLE "%v_AP02_dialog4_heading%" AT 228 24 HEIGHT 14 ) (TEXT TITLE "%v_AP02_dialog4_note%" AT 588 36 WIDTH 93 HEIGHT 46 )
RETURN


