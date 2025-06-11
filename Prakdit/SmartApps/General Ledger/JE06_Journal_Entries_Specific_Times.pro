COMMENT - Copyright Arbutus Software Inc. 2018
SET DEFAULT
SET ECHO NONE
SET SAFETY OFF
CLOSE PRIMARY ALL
DELETE ALL OK
DO SMARTAPPS_GL_HEADER_

DO .USER_INPUTS

start_time = ctod(hour1 + ":" + minute1 + ":" + second1 "hh:mm:ss")
end_time = ctod(hour2 + ":" + minute2 + ":" + second2 "hh:mm:ss")

SET FOLDER \General Ledger Results

EXTRACT RECORD TO %v_JE06_output% if ctod(time(%datefld%) "hh:mm:ss") >= start_time AND ctod(time(%datefld%) "hh:mm:ss") <= end_time

IF WRITE1 = 0 PAUSE "%v_JE06_noresults_message%"
IF WRITE1 = 0 CLOSE
IF WRITE1 > 0 PAUSE "%v_JE06_results_message%"
IF WRITE1 > 0 OPEN %v_JE06_output%
RETURN

PROCEDURE USER_INPUTS
DIALOG (DIALOG TITLE "%v_title_select_table%" WIDTH 388 HEIGHT 190 ) (BUTTONSET TITLE "&OK;&Cancel" AT 120 144 DEFAULT 1 HORZ ) (TEXT TITLE "%v_JE_text_title%" AT 36 24 ) (ITEM TITLE "f" TO "tablename" AT 144 20 WIDTH 220 HEIGHT 154 DEFAULT "%v_choose_table%")

IF ftype(tablename 'f') <> 'f' PAUSE "%v_no_table_message%"
IF ftype(tablename 'f') <> 'f' RETURN ALL

OPEN %tablename%

DIALOG (DIALOG TITLE "%v_JE06_dialog2_title%" WIDTH 418 HEIGHT 278 ) (BUTTONSET TITLE "&OK;&Cancel" AT 132 240 DEFAULT 1 HORZ ) (TEXT TITLE "%v_JE06_dialog2_text1%" AT 84 120 ) (TEXT TITLE "%v_JE06_dialog2_text2%" AT 84 168 ) (TEXT TITLE "%v_JE06_dialog2_text3%" AT 36 24 ) (ITEM TITLE "D" TO "datefld" AT 192 20 WIDTH 200 DEFAULT "%v_choose_field%" ) (DROPDOWN TITLE "00;01;02;03;04;05;06;07;08;09;10;11;12;13;14;15;16;17;18;19;20;21;22;23" TO "hour1" AT 204 116 WIDTH 37 HEIGHT 98 DEFAULT 1 ) (TEXT TITLE "%v_JE06_dialog2_text4%" AT 36 72 ) (DROPDOWN TITLE "00;01;02;03;04;05;06;07;08;09;10;11;12;13;14;15;16;17;18;19;20;30;31;32;33;34;35;36;37;38;39;40;41;42;43;44;45;46;47;48;49;50;51;52;53;54;55;56;57;58;59" TO "minute1" AT 276 116 WIDTH 40 DEFAULT 1 ) (DROPDOWN TITLE "00;01;02;03;04;05;06;07;08;09;10;11;12;13;14;15;16;17;18;19;20;30;31;32;33;34;35;36;37;38;39;40;41;42;43;44;45;46;47;48;49;50;51;52;53;54;55;56;57;58;59" TO "second1" AT 346 116 WIDTH 40 DEFAULT 1 ) (TEXT TITLE "%v_JE06_dialog2_text5%" AT 204 96 WIDTH 32 ) (TEXT TITLE "%v_JE06_dialog2_text6%" AT 276 96 ) (TEXT TITLE "%v_JE06_dialog2_text7%" AT 348 96 ) (DROPDOWN TITLE "00;01;02;03;04;05;06;07;08;09;10;11;12;13;14;15;16;17;18;19;20;21;22;23" TO "hour2" AT 204 164 WIDTH 37 HEIGHT 98 DEFAULT 1 ) (TEXT TITLE "%v_JE06_dialog2_text4%" AT 36 72 ) (DROPDOWN TITLE "00;01;02;03;04;05;06;07;08;09;10;11;12;13;14;15;16;17;18;19;20;30;31;32;33;34;35;36;37;38;39;40;41;42;43;44;45;46;47;48;49;50;51;52;53;54;55;56;57;58;59" TO "minute2" AT 276 168 WIDTH 40 DEFAULT 1 ) (DROPDOWN TITLE "00;01;02;03;04;05;06;07;08;09;10;11;12;13;14;15;16;17;18;19;20;30;31;32;33;34;35;36;37;38;39;40;41;42;43;44;45;46;47;48;49;50;51;52;53;54;55;56;57;58;59" TO "second2" AT 346 168 WIDTH 40 DEFAULT 1 )

IF isdefined(datefld) = f PAUSE "%v_invalid_field_message3%"
IF isdefined(datefld) = f RETURN ALL
RETURN

