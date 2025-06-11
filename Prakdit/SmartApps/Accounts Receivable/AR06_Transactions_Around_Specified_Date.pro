COMMENT - Copyright Arbutus Software Inc. 2018
SET DEFAULT
SET ECHO NONE
SET SAFETY OFF
CLOSE PRIMARY ALL
DELETE ALL OK
DO SMARTAPPS_AR_HEADER_

DO .USER_INPUTS

SET FOLDER \Accounts Receivable Results

EXTRACT RECORD TO %v_AR06_output% if ABS(DateVar1-%datefld%)<=n_days

IF WRITE1=0 PAUSE "%v_AR06_results_message1%"
IF WRITE1=0 CLOSE
IF WRITE1>0 PAUSE "%v_AR06_results_message2%"
IF WRITE1>0 OPEN %v_AR06_output%
RETURN

PROCEDURE USER_INPUTS
DIALOG (DIALOG TITLE "%v_title_select_table%" WIDTH 425 HEIGHT 204 ) (BUTTONSET TITLE "&OK;&Cancel" AT 156 132 DEFAULT 1 HORZ ) (TEXT TITLE "%v_AR_text_title%" AT 36 24 ) (ITEM TITLE "f" TO "tablename" AT 204 22 WIDTH 190 DEFAULT "%v_choose_table%" )

IF ftype(tablename 'f')<>'f' PAUSE "%v_no_table_message%"
IF ftype(tablename 'f')<>'f' RETURN ALL

OPEN %tablename%

DIALOG (DIALOG TITLE "%v_AR06_dialog2_title%" WIDTH 429 HEIGHT 226 ) (BUTTONSET TITLE "&OK;&Cancel" AT 192 180 DEFAULT 1 HORZ ) (TEXT TITLE "%v_AR06_dialog2_text1%" AT 36 84 ) (EDIT TO "DateVar1" AT 192 82 WIDTH 212 DATE ) (EDIT TO "n_days" AT 192 132 WIDTH 40 NUM ) (TEXT TITLE "%v_AR06_dialog2_text2%" AT 36 132 WIDTH 114 HEIGHT 36 ) (TEXT TITLE "%v_AR03_dialog2_text3%" AT 36 36 ) (ITEM TITLE "D" TO "datefld" AT 192 32 WIDTH 200 DEFAULT "%v_choose_field%" )

IF isdefined(datefld)=f PAUSE "%v_invalid_field_message5%"
IF isdefined(datefld)=f RETURN ALL

IF n_days = 0 PAUSE "%v_no_days_within_date%"
IF n_days = 0 RETURN ALL
RETURN


