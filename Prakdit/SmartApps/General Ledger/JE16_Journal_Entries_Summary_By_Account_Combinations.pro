comment - Copyright Arbutus Software Inc. 2021
SET DEFAULT
SET ECHO NONE
SET SAFETY OFF
CLOSE PRIMARY ALL
DELETE ALL OK
DO SMARTAPPS_GL_HEADER_

DO .USER_INPUTS

SET FOLDER \General Ledger Results

SUMMARIZE ON %accountentry1% %accountentry2% %accountentry3% %accountentry4% ACCUMULATE %amountentry% to %v_JE16_output% PRESORT OPEN
RETURN

PROCEDURE USER_INPUTS
DIALOG (DIALOG TITLE "%v_title_select_table%" WIDTH 388 HEIGHT 190 ) (BUTTONSET TITLE "&OK;&Cancel" AT 120 144 DEFAULT 1 HORZ ) (TEXT TITLE "%v_JE_text_title%" AT 36 24 ) (ITEM TITLE "f" TO "tablename" AT 156 22 WIDTH 208 HEIGHT 154 DEFAULT "%v_choose_table%" )

IF ftype(tablename 'f') <> 'f' PAUSE "%v_no_table_message%"
IF ftype(tablename 'f') <> 'f' RETURN ALL

OPEN %tablename%

DIALOG (DIALOG TITLE "Select Account and Amount Fields" WIDTH 888 HEIGHT 406 ) (BUTTONSET TITLE "&OK;&Cancel" AT 384 360 DEFAULT 1 HORZ ) (TEXT TITLE "First Account Field" AT 24 72 ) (ITEM TITLE "C" TO "accountentry1" AT 24 104 WIDTH 200 HEIGHT 97 DEFAULT "Choose Field" ) (TEXT TITLE "Amount Field" AT 36 288 HEIGHT 17 ) (ITEM TITLE "N" TO "AmountEntry" AT 120 284 WIDTH 200 HEIGHT 90 DEFAULT "Choose Field" ) (TEXT TITLE "Second Account Field" AT 240 72 ) (ITEM TITLE "C" TO "AccountEntry2" AT 240 104 WIDTH 200 HEIGHT 88 DEFAULT "Choose Field" ) (TEXT TITLE "Third Account Field" AT 456 72 ) (TEXT TITLE "Fourth Account Field" AT 672 72 HEIGHT 18 ) (ITEM TITLE "C" TO "AccountEntry3" AT 456 104 WIDTH 200 DEFAULT "Choose Field" ) (ITEM TITLE "C" TO "AccountEntry4" AT 672 104 WIDTH 200 DEFAULT "Choose Field" ) (TEXT TITLE "Choose Two or More Account Fields To Summarize:" AT 24 12 WIDTH 281 ) (TEXT TITLE "*************************************************************" AT 24 36 WIDTH 242 ) (TEXT TITLE "Choose An Amount Field To Total:" AT 24 216 ) (TEXT TITLE "****************************************" AT 24 240 )

IF isdefined(accountentry1) = f accountentry1 = ""
IF isdefined(accountentry2) = f accountentry2 = ""
IF isdefined(accountentry3) = f accountentry3 = ""
IF isdefined(accountentry4) = f accountentry4 = ""
IF isdefined(AmountEntry) = f AmountEntry = ""
IF ((accountentry1 = "" AND accountentry2 = "" AND accountentry3 = "") OR AmountEntry = "") OR ((accountentry1 = "" AND accountentry2 = "" AND accountentry4 = "") OR AmountEntry = "") OR ((accountentry1 = "" AND accountentry3 = "" AND accountentry4 = "") OR AmountEntry = "") OR ((accountentry2 = "" AND accountentry3 = "" AND accountentry4 = "") OR AmountEntry = "") PAUSE "%v_invalid_field_message1%"
IF ((accountentry1 = "" AND accountentry2 = "" AND accountentry3 = "") OR AmountEntry = "") OR ((accountentry1 = "" AND accountentry2 = "" AND accountentry4 = "") OR AmountEntry = "") OR ((accountentry1 = "" AND accountentry3 = "" AND accountentry4 = "") OR AmountEntry = "") OR ((accountentry2 = "" AND accountentry3 = "" AND accountentry4 = "") OR AmountEntry = "") RETURN ALL
RETURN

