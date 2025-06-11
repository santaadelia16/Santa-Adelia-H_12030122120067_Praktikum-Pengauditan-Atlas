comment - Copyright Arbutus Software Inc. 2018
SET DEFAULT
SET ECHO NONE
SET SAFETY OFF
SET TEMP "TEMP_"
CLOSE PRIMARY ALL
DELETE ALL OK
DO SMARTAPPS_FC_HEADER_

DELETE FORMAT Word_Count_Summary OK

table_flag = f
field_flag = f

do .select_table while table_flag = f

open %tablename%

do .select_field while field_flag = f

group
  assign x = length(include(compact(alltrim(%fieldname%) " ") " "))
  y = 1
  loop while y <= x+1
    classify upper(split(compact(alltrim(%fieldname%) " ")" " y)) as "Word" to temp_word_count
    y = y+1
  end
end

open temp_word_count

SET FOLDER \Fraud Compliance Results

extract fields word count presort count D TO %v_FC11_output% OPEN

DELETE TEMP OK
RETURN







procedure select_table
DIALOG (DIALOG TITLE "Select Table" WIDTH 702 HEIGHT 94 ) (BUTTONSET TITLE "&OK;&Cancel" AT 576 24 DEFAULT 1 ) (TEXT TITLE "Select Table to Perform Word Count" AT 24 24 ) (ITEM TITLE "f" TO "tablename" AT 288 22 WIDTH 230 )

assign table_flag = t if length(alltrim(tablename)) > 0
return





procedure select_field
DIALOG (DIALOG TITLE "%v_FC11_dialog2_title%" WIDTH 578 HEIGHT 76 ) (BUTTONSET TITLE "&OK;&Cancel" AT 480 12 DEFAULT 1 ) (TEXT TITLE "%v_FC11_dialog2_text%" AT 24 24 ) (ITEM TITLE "C" TO "fieldname" AT 288 22 WIDTH 155 HEIGHT 17 )

assign field_flag = t if length(alltrim(fieldname)) > 0
return
