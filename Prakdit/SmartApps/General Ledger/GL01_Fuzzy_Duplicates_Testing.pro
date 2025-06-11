COMMENT - Copyright Arbutus Software Inc. 2018
SET DEFAULT
SET ECHO NONE
SET SAFETY OFF
DELETE ALL OK
ASSIGN CHECKBOX1=F
CLOSE PRIMARY ALL
DO SMARTAPPS_GL_HEADER_

DO .USER_INPUTS

IF RADIO1 = 1 DIALOG (DIALOG TITLE "%v_GL01_dialog4_title%" WIDTH 382 HEIGHT 186 ) (BUTTONSET TITLE "&OK;&Cancel" AT 120 144 DEFAULT 1 HORZ ) (TEXT TITLE "%v_GL01_dialog4_text1%" AT 60 48 WIDTH 213 HEIGHT 38 ) (EDIT TO "errorentry" AT 288 46 WIDTH 63 DEFAULT "20" NUM )

IF RADIO1 = 2 and ftype(key4)='C' DIALOG (DIALOG TITLE "%v_GL01_dialog4_title%" WIDTH 418 HEIGHT 243 ) (BUTTONSET TITLE "&OK;&Cancel" AT 144 204 DEFAULT 1 HORZ ) (TEXT TITLE "%v_GL01_dialog4_text1%" AT 60 48 WIDTH 110 HEIGHT 38 ) (EDIT TO "errorentry" AT 228 48 DEFAULT "20" NUM ) (TEXT TITLE "%v_GL01_dialog4_text2%" AT 60 96 WIDTH 147 HEIGHT 36 ) (CHECKBOX TITLE "%v_suppress_matches%" TO "CHECKBOX1" AT 60 143 ) (EDIT TO "diffentry" AT 228 96 DEFAULT "1" NUM )

IF RADIO1 = 2 and ftype(key4)='N' DIALOG (DIALOG TITLE "%v_GL01_dialog4_title%" WIDTH 418 HEIGHT 243 ) (BUTTONSET TITLE "&OK;&Cancel" AT 144 204 DEFAULT 1 HORZ ) (TEXT TITLE "%v_GL01_dialog4_text1%" AT 60 48 WIDTH 212 HEIGHT 38 ) (EDIT TO "errorentry" AT 288 46 WIDTH 56 DEFAULT "20" NUM ) (TEXT TITLE "%v_GL01_dialog4_text3%" AT 60 96 WIDTH 209 HEIGHT 36 ) (CHECKBOX TITLE "%v_suppress_matches%" TO "CHECKBOX1" AT 60 143 ) (EDIT TO "diffentry" AT 288 94 WIDTH 60 DEFAULT "100" NUM )

IF RADIO1 = 2 and ftype(key4)='D' DIALOG (DIALOG TITLE "%v_GL01_dialog4_title%" WIDTH 418 HEIGHT 243 ) (BUTTONSET TITLE "&OK;&Cancel" AT 144 204 DEFAULT 1 HORZ ) (TEXT TITLE "%v_GL01_dialog4_text1%" AT 60 48 WIDTH 228 HEIGHT 38 ) (EDIT TO "errorentry" AT 300 46 WIDTH 47 DEFAULT "20" NUM ) (TEXT TITLE "%v_GL01_dialog4_text4%" AT 60 96 WIDTH 226 HEIGHT 36 ) (CHECKBOX TITLE "%v_suppress_matches%" TO "CHECKBOX1" AT 60 143 ) (EDIT TO "diffentry" AT 300 94 WIDTH 48 DEFAULT "7" NUM )

IF RADIO1 = 3 and ftype(key4)='C' DIALOG (DIALOG TITLE "%v_GL01_dialog4_title%" WIDTH 418 HEIGHT 243 ) (BUTTONSET TITLE "&OK;&Cancel" AT 144 204 DEFAULT 1 HORZ ) (TEXT TITLE "%v_GL01_dialog4_text1%" AT 60 48 WIDTH 230 HEIGHT 38 ) (EDIT TO "errorentry" AT 300 46 WIDTH 49 DEFAULT "20" NUM ) (TEXT TITLE "%v_GL01_dialog4_text2%" AT 60 96 WIDTH 227 HEIGHT 36 ) (CHECKBOX TITLE "%v_suppress_matches%" TO "CHECKBOX1" AT 60 143 ) (EDIT TO "diffentry" AT 300 94 WIDTH 48 DEFAULT "1" NUM )

IF RADIO1 = 3 and ftype(key4)='N' DIALOG (DIALOG TITLE "%v_GL01_dialog4_title%" WIDTH 418 HEIGHT 243 ) (BUTTONSET TITLE "&OK;&Cancel" AT 144 204 DEFAULT 1 HORZ ) (TEXT TITLE "%v_GL01_dialog4_text1%" AT 60 48 WIDTH 226 HEIGHT 38 ) (EDIT TO "errorentry" AT 300 46 WIDTH 46 DEFAULT "20" NUM ) (TEXT TITLE "%v_GL01_dialog4_text3%" AT 60 96 WIDTH 227 HEIGHT 36 ) (CHECKBOX TITLE "%v_suppress_matches%" TO "CHECKBOX1" AT 60 143 ) (EDIT TO "diffentry" AT 300 94 WIDTH 47 DEFAULT "100" NUM )

IF RADIO1 = 3 and ftype(key4)='D' DIALOG (DIALOG TITLE "%v_GL01_dialog4_title%" WIDTH 418 HEIGHT 243 ) (BUTTONSET TITLE "&OK;&Cancel" AT 144 204 DEFAULT 1 HORZ ) (TEXT TITLE "%v_GL01_dialog4_text1%" AT 60 48 WIDTH 221 HEIGHT 38 ) (EDIT TO "errorentry" AT 300 46 WIDTH 43 DEFAULT "20" NUM ) (TEXT TITLE "%v_GL01_dialog4_text4%" AT 60 96 WIDTH 226 HEIGHT 36 ) (CHECKBOX TITLE "%v_suppress_matches%" TO "CHECKBOX1" AT 60 143 ) (EDIT TO "diffentry" AT 300 94 WIDTH 45 DEFAULT "7" NUM )

SET FOLDER \General Ledger Results

IF RADIO1 = 1 DUPLICATES ON %key1% %key2% %key3% %key4% DIFFERENT TO %v_GL01_output1% PRESORT errorlimit errorentry

IF RADIO1 = 2 and CHECKBOX1=T DUPLICATES ON %key1% %key2% %key3% %key4% NEAR diffentry TO %v_GL01_output2% PRESORT SUPPRESS errorlimit errorentry

IF RADIO1 = 2 and CHECKBOX1=F DUPLICATES ON %key1% %key2% %key3% %key4% NEAR diffentry TO %v_GL01_output2% PRESORT errorlimit errorentry

IF RADIO1 = 3 and CHECKBOX1=T DUPLICATES ON %key1% %key2% %key3% %key4% SIMILAR diffentry TO %v_GL01_output3% PRESORT SUPPRESS errorlimit errorentry

IF RADIO1 = 3 and CHECKBOX1=F DUPLICATES ON %key1% %key2% %key3% %key4% SIMILAR diffentry TO %v_GL01_output3% PRESORT errorlimit errorentry

IF WRITE1 = 0 PAUSE "%v_GL01_noresults_message%"
IF WRITE1 = 0 CLOSE
IF WRITE1 > 0 PAUSE "%v_GL01_results_message%"
IF WRITE1 > 0 AND RADIO1 = 1 OPEN %v_GL01_output1%
IF WRITE1 > 0 AND RADIO1 = 2 OPEN %v_GL01_output2%
IF WRITE1 > 0 AND RADIO1 = 3 OPEN %v_GL01_output3%
RETURN

PROCEDURE USER_INPUTS
DIALOG (DIALOG TITLE "%v_title_select_table%" WIDTH 410 HEIGHT 194 ) (BUTTONSET TITLE "&OK;&Cancel" AT 144 144 DEFAULT 1 HORZ ) (TEXT TITLE "%v_title_select_table%" AT 36 24 ) (ITEM TITLE "f" TO "tablename" AT 144 20 WIDTH 220 HEIGHT 154 DEFAULT "%v_choose_table%" )

IF ftype(tablename 'f') <> 'f' PAUSE "%v_no_table_message%"
IF ftype(tablename 'f') <> 'f' RETURN ALL

OPEN %tablename%

DIALOG (DIALOG TITLE "%v_GL01_dialog2_title%" WIDTH 741 HEIGHT 479 ) (BUTTONSET TITLE "&OK;&Cancel" AT 324 432 DEFAULT 1 HORZ ) (TEXT TITLE "%v_GL01_dialog2_text1%" AT 72 96 ) (TEXT TITLE "%v_GL01_dialog2_text2%" AT 300 96 ) (TEXT TITLE "%v_GL01_dialog2_text3%" AT 516 96 ) (TEXT TITLE "%v_GL01_dialog2_text4%" AT 72 276 ) (ITEM TITLE "CND" TO "Key1" AT 72 128 WIDTH 200 DEFAULT "%v_choose_field%" ) (ITEM TITLE "CND" TO "key2" AT 300 128 WIDTH 200 DEFAULT "%v_choose_field%" ) (ITEM TITLE "CND" TO "key3" AT 516 128 WIDTH 200 DEFAULT "%v_choose_field%" ) (ITEM TITLE "CND" TO "key4" AT 72 308 WIDTH 200 DEFAULT "%v_choose_field%" ) (TEXT TITLE "%v_GL01_dialog2_text5%" AT 72 48 ) (TEXT TITLE "**********************************************************" AT 72 72 WIDTH 230 ) (TEXT TITLE "**********************************************************" AT 72 252 ) (TEXT TITLE "%v_GL01_dialog2_text6%" AT 72 228 )

IF isdefined(key1) = f key1 = ""
IF isdefined(key2) = f key2 = ""
IF isdefined(key3) = f key3 = ""
IF isdefined(key4) = f key4 = ""
IF (key1 = "" AND key2 = "" AND key3 = "") OR key4 = "" PAUSE "%v_invalid_field_message1%"
IF (key1 = "" AND key2 = "" AND key3 = "") OR key4 = "" RETURN ALL

DIALOG (DIALOG TITLE "%v_GL01_dialog3_title%" WIDTH 345 HEIGHT 187 ) (BUTTONSET TITLE "&OK;&Cancel" AT 96 144 DEFAULT 1 HORZ ) (TEXT TITLE "%v_GL01_dialog3_text1%" AT 84 36 ) (RADIOBUTTON TITLE "%v_GL01_dialog3_text2%" TO "RADIO1" AT 144 70 DEFAULT 1 )
RETURN


