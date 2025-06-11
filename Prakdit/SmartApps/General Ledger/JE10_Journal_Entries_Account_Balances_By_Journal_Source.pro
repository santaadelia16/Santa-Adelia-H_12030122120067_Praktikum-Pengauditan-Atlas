COMMENT - Copyright Arbutus Software Inc. 2018
SET DEFAULT
SET ECHO NONE
SET SAFETY OFF
CLOSE PRIMARY ALL
DELETE ALL OK
DO SMARTAPPS_GL_HEADER_

DO .USER_INPUTS

Classify on %jsentry% to Clean_JS OPEN
Save Field %jsentry% to JS_List
Close
Delete Format Clean_JS OK

DIALOG (DIALOG TITLE "%v_JE09_dialog3_title%" WIDTH 358 HEIGHT 214 ) (BUTTONSET TITLE "&OK;&Cancel" AT 108 168 DEFAULT 1 HORZ ) (TEXT TITLE "%v_JE09_dialog3_text1%" AT 36 24 ) (DROPDOWN TITLE JS_LIST TO "DROPDOWN1" AT 132 20 WIDTH 200 )

OPEN %tablename%

SET FOLDER \General Ledger Results

SUMMARIZE ON %jsentry% ACCUMULATE %amountentry% to %v_JE10_output% PRESORT IF %jsentry% = dropdown1

IF WRITE1 = 0 PAUSE "%v_JE10_noresults_message%"
IF WRITE1 = 0 CLOSE
IF WRITE1 > 0 PAUSE "%v_JE10_results_message%"
IF WRITE1 > 0 OPEN %v_JE10_output%
RETURN

PROCEDURE USER_INPUTS
DIALOG (DIALOG TITLE "%v_title_select_table%" WIDTH 388 HEIGHT 190 ) (BUTTONSET TITLE "&OK;&Cancel" AT 120 144 DEFAULT 1 HORZ ) (TEXT TITLE "%v_JE_text_title%" AT 36 24 ) (ITEM TITLE "f" TO "tablename" AT 168 22 WIDTH 201 HEIGHT 154 DEFAULT "%v_choose_table%" )

IF ftype(tablename 'f') <> 'f' PAUSE "%v_no_table_message%"
IF ftype(tablename 'f') <> 'f' RETURN ALL

OPEN %tablename%

DIALOG (DIALOG TITLE "%v_JE10_dialog2_title%" WIDTH 387 HEIGHT 215 ) (BUTTONSET TITLE "&OK;&Cancel" AT 120 180 DEFAULT 1 HORZ ) (TEXT TITLE "%v_JE09_dialog2_text1%" AT 36 36 ) (ITEM TITLE "C" TO "jsentry" AT 156 32 WIDTH 200 HEIGHT 110 DEFAULT "%v_choose_field%") (TEXT TITLE "%v_JE01_dialog2_text2%" AT 36 84 ) (ITEM TITLE "N" TO "amountentry" AT 156 80 WIDTH 200 DEFAULT "%v_choose_field%")

IF isdefined(jsentry) = f or isdefined(amountentry) = f PAUSE "%v_invalid_field_message2%"
IF isdefined(jsentry) = f or isdefined(amountentry) = f RETURN ALL
RETURN


