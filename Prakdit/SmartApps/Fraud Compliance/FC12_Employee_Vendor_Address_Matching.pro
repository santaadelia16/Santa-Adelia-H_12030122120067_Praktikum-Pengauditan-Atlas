COMMENT - Copyright Arbutus Software Inc. 2023
SET DEFAULT
SET ECHO NONE
SET HISTORY 0
SET SAFETY OFF
CLOSE PRIMARY ALL
DELETE ALL OK
SET TEMP "TEMP_"
DO SMARTAPPS_FC_Header_

v_ok=f
DO .input WHILE NOT v_ok
DISPLAY VERSION
IF arbutus_version>=6.10 v_100=unicode(blanks(100))
IF arbutus_version>=6.10 v_50 =unicode(blanks(50))
IF arbutus_version <6.10 v_100=blanks(100)+"ƛ"
IF arbutus_version <6.10 v_50 =blanks(50) +"ƛ"

DO .align_key_lengths
DO .build_addr_sub

OPEN %v_table%

EXTRACT %v_t1_LIST% sub(%v_eref%+v_50 1 50) as "ID" "1" as "Fl" TO temp_100

OPEN %v_table2%
EXTRACT %v_t2_LIST% sub(%v_vref%+v_50 1 50) as "ID" "2" as "Fl" TO temp_100 APPEND OPEN

DUPLICATES ON %v_dup_LIST% SIMILAR v_near OTHER ID Fl Original TO temp_101 OPEN PRESORT ERRORLIMIT 1000

SET FOLDER \Fraud Compliance Results

IF v_bmatch EXTRACT ID AS "%v_FC12_employee%" Original AS "%v_FC12_employee%;%v_FC12_original%;%v_FC12_address%" %v_fld% AS "%v_FC12_employee%;%v_FC12_address%" %v_fld%2 AS "%v_FC12_vendor%;%v_FC12_address%" Original2 AS "%v_FC12_vendor%;%v_FC12_original%;%v_FC12_address%" ID2 AS "%v_FC12_vendor%" TO %v_FC12_output1% IF Fl ='1' and Fl2 ='2'
IF v_bmatch AND WRITE1=0 PAUSE "%v_FC12_no_matched_employee_vendor_addresses%"
IF v_bmatch AND WRITE1>0 PAUSE "%v_FC12_matched_employee_vendor_addresses%"

IF v_ematch EXTRACT ID AS "%v_FC12_employee%1" Original AS "%v_FC12_employee%1;%v_FC12_original%;%v_FC12_address%" %v_fld% AS "%v_FC12_employee%1;%v_FC12_address%" %v_fld%2 AS "%v_FC12_employee%2;%v_FC12_address%" Original2 AS "%v_FC12_employee%2;%v_FC12_original%;%v_FC12_address%" ID2 AS "%v_FC12_employee%2"  TO %v_FC12_output2% IF Fl='1' and Fl2='1'
IF v_ematch AND WRITE1=0 PAUSE "%v_FC12_no_matched_employee_addresses%"
IF v_ematch AND WRITE1>0 PAUSE "%v_FC12_matched_employee_addresses%"

IF v_vmatch EXTRACT ID AS "%v_FC12_vendor%1" Original AS "%v_FC12_vendor%1;%v_FC12_original%;%v_FC12_address%" %v_fld% AS "%v_FC12_vendor%1;%v_FC12_address%" %v_fld%2 AS "%v_FC12_vendor%2;%v_FC12_address%" Original2 AS "%v_FC12_vendor%2;%v_FC12_original%;%v_FC12_address%" ID2 AS "%v_FC12_vendor%2" TO %v_FC12_output3% IF Fl='2' and Fl2='2'
IF v_vmatch AND WRITE1=0 PAUSE "%v_FC12_no_matched_vendor_addresses%"
IF v_vmatch AND WRITE1>0 PAUSE "%v_FC12_matched_vendor_addresses%"

CLOSE PRIMARY ALL
DELETE TEMP OK
RETURN

PROCEDURE input
DIALOG (DIALOG TITLE "%v_FC12_dialog1_title%" WIDTH 486 HEIGHT 248 ) (BUTTONSET TITLE "&OK;&Cancel" AT 396 180 DEFAULT 1 ) (TEXT TITLE "%v_FC12_dialog1_text1%" AT 12 24 WIDTH 353 HEIGHT 47 ) (TEXT TITLE "%v_FC12_dialog1_text2%" AT 12 84 WIDTH 351 HEIGHT 35 ) (RADIOBUTTON TITLE "%v_FC12_dialog1_text3%" TO "V_continue" AT 12 142 DEFAULT 1 )

IF v_continue = 2 RETURN ALL

DIALOG (DIALOG TITLE "%v_FC12_dialog2_title%" WIDTH 538 HEIGHT 516 ) (BUTTONSET TITLE "&OK;&Cancel" AT 192 468 DEFAULT 1 HORZ ) (TEXT TITLE "%v_FC12_dialog2_text1%" AT 24 144 WIDTH 185 ) (ITEM TITLE "C" TO "v_fld" AT 276 142 WIDTH 155 DEFAULT " " ) (ITEM TITLE "C" TO "v_key1" AT 276 214 WIDTH 155 HEIGHT 21 DEFAULT " " ) (ITEM TITLE "C" TO "v_key2" AT 276 250 WIDTH 155 HEIGHT 23 DEFAULT " " ) (ITEM TITLE "C" TO "v_key3" AT 276 286 WIDTH 155 DEFAULT " " ) (ITEM TITLE "C" TO "v_key4" AT 276 322 WIDTH 155 DEFAULT " " ) (TEXT TITLE "%v_FC12_dialog2_text3%" AT 24 108 WIDTH 204 ) (ITEM TITLE "C" TO "v_eref" AT 276 106 WIDTH 155 DEFAULT " " ) (TEXT TITLE "%v_FC12_dialog2_text4%" AT 36 240 WIDTH 153 HEIGHT 83 ) (TEXT TITLE "%v_FC12_dialog2_text5%" AT 24 24 ) (ITEM TITLE "f" TO "v_table" AT 276 22 WIDTH 245 HEIGHT 61 DEFAULT " " OPEN ) (TEXT TITLE "%v_FC12_dialog2_text6%" AT 24 372 ) (TEXT TITLE "%v_FC12_dialog2_text7%" AT 24 408 WIDTH 370 HEIGHT 48 )

v_ok=t

IF LENGTH(%v_fld%)=0 v_ok=f
IF NOT v_ok PAUSE "%v_FC12_no_address_message%"
IF NOT v_ok RETURN
IF LENGTH(%v_eref%)=0 v_ok=f
IF NOT v_ok PAUSE "%v_FC12_no_employee_message%"
IF NOT v_ok RETURN
IF LENGTH(%v_fld%)>100 v_ok=f
IF LENGTH(v_key1)>0 IF LENGTH(%v_key1%)>50 v_ok=f
IF LENGTH(v_key2)>0 IF LENGTH(%v_key2%)>50 v_ok=f
IF LENGTH(v_key3)>0 IF LENGTH(%v_key3%)>50 v_ok=f
IF LENGTH(v_key4)>0 IF LENGTH(%v_key4%)>50 v_ok=f
IF NOT v_ok PAUSE "%v_FC12_field_too_long%"

DIALOG (DIALOG TITLE "%v_FC12_dialog3_title%" WIDTH 549 HEIGHT 520 ) (BUTTONSET TITLE "&OK;&Cancel" AT 204 480 DEFAULT 1 HORZ ) (TEXT TITLE "%v_FC12_dialog3_text1%" AT 24 144 WIDTH 185 ) (ITEM TITLE "C" TO "v_2fld" AT 276 142 WIDTH 155 DEFAULT "" ) (TEXT TITLE "%v_FC12_dialog2_text2%" AT 24 216 WIDTH 191 HEIGHT 29 ) (ITEM TITLE "C" TO "v_2key1" AT 276 214 WIDTH 155 HEIGHT 21 DEFAULT "" ) (ITEM TITLE "C" TO "v_2key2" AT 276 250 WIDTH 155 HEIGHT 23 DEFAULT "" ) (ITEM TITLE "C" TO "v_2key3" AT 276 286 WIDTH 155 DEFAULT "" ) (ITEM TITLE "C" TO "v_2key4" AT 276 322 WIDTH 155 DEFAULT "" ) (TEXT TITLE "%v_FC12_dialog3_text2%" AT 24 108 WIDTH 204 ) (ITEM TITLE "C" TO "v_vref" AT 276 106 WIDTH 155 DEFAULT "" ) (TEXT TITLE "%v_FC12_dialog2_text4%" AT 24 264 WIDTH 153 HEIGHT 83 ) (TEXT TITLE "%v_FC12_dialog3_text3%" AT 24 24 ) (ITEM TITLE "f" TO "v_table2" AT 276 22 WIDTH 245 DEFAULT "" OPEN ) (TEXT TITLE "%v_FC12_dialog2_text6%" AT 24 360 ) (TEXT TITLE "%v_FC12_dialog3_text4%" AT 24 384 WIDTH 370 HEIGHT 72 )

v_near=1

DIALOG (DIALOG TITLE "%v_FC12_dialog4_title%" WIDTH 415 HEIGHT 140 ) (BUTTONSET TITLE "&OK;&Cancel" AT 132 96 DEFAULT 1 HORZ ) (TEXT TITLE "%v_FC12_dialog4_text1%" AT 24 24 ) (EDIT TO "v_near" AT 228 22 WIDTH 38 NUM )

IF LENGTH(%v_2fld%)=0 v_ok=f
IF NOT v_ok PAUSE "%v_FC12_no_address_message%"
IF NOT v_ok RETURN
IF LENGTH(%v_vref%)=0 v_ok=f
IF NOT v_ok PAUSE "%v_FC12_no_vendor_message%"
IF NOT v_ok RETURN
IF LENGTH(%v_2fld%)>100 v_ok=f
IF LENGTH(v_2key1)>0 IF LENGTH(%v_2key1%)>50 v_ok=f
IF LENGTH(v_2key2)>0 IF LENGTH(%v_2key2%)>50 v_ok=f
IF LENGTH(v_2key3)>0 IF LENGTH(%v_2key3%)>50 v_ok=f
IF LENGTH(v_2key4)>0 IF LENGTH(%v_2key4%)>50 v_ok=f
IF NOT v_ok PAUSE "%v_FC12_field_too_long%"
IF NOT v_ok RETURN

IF LENGTH(v_key1)>0 and LENGTH(v_2key1)=0 v_ok=f
IF LENGTH(v_key2)>0 and LENGTH(v_2key2)=0 v_ok=f
IF LENGTH(v_key3)>0 and LENGTH(v_2key3)=0 v_ok=f
IF LENGTH(v_key4)>0 and LENGTH(v_2key4)=0 v_ok=f
IF LENGTH(v_key1)=0 and LENGTH(v_2key1)>0 v_ok=f
IF LENGTH(v_key2)=0 and LENGTH(v_2key2)>0 v_ok=f
IF LENGTH(v_key3)=0 and LENGTH(v_2key3)>0 v_ok=f
IF LENGTH(v_key4)=0 and LENGTH(v_2key4)>0 v_ok=f

IF NOT v_ok PAUSE "%v_FC12_no_keys%"
IF NOT v_ok RETURN

DIALOG (DIALOG TITLE "%v_FC12_dialog5_title%" WIDTH 560 HEIGHT 237 ) (BUTTONSET TITLE "&OK;&Cancel" AT 456 156 DEFAULT 1 ) (CHECKBOX TITLE "%v_FC12_dialog5_checkbox1%" TO "v_bmatch" AT 36 59 ) (CHECKBOX TITLE "%v_FC12_dialog5_checkbox2%" TO "v_ematch" AT 36 95 ) (CHECKBOX TITLE "%v_FC12_dialog5_checkbox3%" TO "v_vmatch" AT 36 131 ) (TEXT TITLE "%v_FC12_dialog5_text1%" AT 108 24 )

DIALOG (DIALOG TITLE "%v_FC12_dialog6_title%" WIDTH 468 HEIGHT 275 ) (BUTTONSET TITLE "&OK" AT 204 228 DEFAULT 1 ) (TEXT TITLE "%v_FC12_dialog6_text1%" AT 12 12 WIDTH 344 HEIGHT 29 ) (TEXT TITLE "%v_FC12_dialog6_text2%" AT 120 72 ) (TEXT TITLE "%v_FC12_dialog6_text3%" AT 120 108 ) (TEXT TITLE "%v_FC12_dialog6_text4%" AT 120 144 HEIGHT 16 ) (TEXT TITLE "%v_FC12_dialog6_text5%" AT 12 192 )
RETURN

PROCEDURE align_key_lengths
v_t1_LIST=""
v_t2_LIST=""
v_dup_LIST=""

OPEN %v_table%

IF LENGTH(v_key1)>0 v_dup_LIST=v_dup_LIST+"%v_key1% "
IF LENGTH(v_key2)>0 v_dup_LIST=v_dup_LIST+"%v_key2% "
IF LENGTH(v_key3)>0 v_dup_LIST=v_dup_LIST+"%v_key3% "
IF LENGTH(v_key4)>0 v_dup_LIST=v_dup_LIST+"%v_key4% "

v_dup_LIST=v_dup_LIST+"%v_fld% "

IF LENGTH(v_key1)>0 v_t1_LIST=v_t1_LIST+"Normalize(sub(%v_key1%+v_50 1 50)) as '%v_key1%' "
IF LENGTH(v_key2)>0 v_t1_LIST=v_t1_LIST+"Normalize(sub(%v_key2%+v_50 1 50)) as '%v_key2%' "
IF LENGTH(v_key3)>0 v_t1_LIST=v_t1_LIST+"Normalize(sub(%v_key3%+v_50 1 50)) as '%v_key3%' "
IF LENGTH(v_key4)>0 v_t1_LIST=v_t1_LIST+"Normalize(sub(%v_key4%+v_50 1 50)) as '%v_key4%' "

v_t1_LIST=v_t1_LIST+"SortNormalize(sub(%v_fld% +v_100 1 100) 'addr.sub') as '%v_fld%' sub(%v_fld% +v_100 1 100) as 'Original'"

OPEN %v_table2%

IF LENGTH(v_2key1)>0 v_t2_LIST=v_t2_LIST+"Normalize(sub(%v_2key1%+v_50 1 50)) as '%v_key1%' "
IF LENGTH(v_2key2)>0 v_t2_LIST=v_t2_LIST+"Normalize(sub(%v_2key2%+v_50 1 50)) as '%v_key2%' "
IF LENGTH(v_2key3)>0 v_t2_LIST=v_t2_LIST+"Normalize(sub(%v_2key3%+v_50 1 50)) as '%v_key3%' "
IF LENGTH(v_2key4)>0 v_t2_LIST=v_t2_LIST+"Normalize(sub(%v_2key4%+v_50 1 50)) as '%v_key4%' "

v_t2_LIST=v_t2_LIST+"SortNormalize(sub(%v_2fld%+v_100 1 100) 'addr.sub') as '%v_fld%' sub(%v_2fld% +v_100 1 100) as 'Original'"
RETURN

PROCEDURE build_addr_sub
IF FILESIZE("addr.sub")>0 RETURN
LIST UNFORMATTED TO addr.sub FIRST 1     'ALLEE ALY'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'ALLEY ALY'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'ALLY ALY'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'ANEX  ANX'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'ANNEX ANX'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'ANNX ANX'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'ARCADE ARC'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'AV AVE'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'AVEN AVE'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'AVENU AVE'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'AVENUE AVE'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'AVN AVE'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'AVNUE AVE'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'BAYOO BYU'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'BAYOU BYU'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'BEACH BCH'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'BEND BND'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'BLUF BLF'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'BLUFF BLF'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'BLUFFS BLFS'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'BOT BTM'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'BOTTM BTM'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'BOTTOM BTM'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'BOUL BLVD'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'BOULEVARD BLVD'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'BOULV BLVD'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'BRANCH BR'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'BRNCH BR'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'BRDGE BRG'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'BRIDGE BRG'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'BROOK BRK'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'BROOKS BRKS'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'BURG BG'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'BURGS BGS'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'BYPA BYP'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'BYPAS BYP'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'BYPASS BYP'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'BYPS BYP'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'CAMP CP'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'CMP CP'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'CANYN CYN'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'CANYON CYN'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'CNYN CYN'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'CAPE CPE'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'CAUSEWAY CSWY'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'CAUSWAY CSWY'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'CEN CTR'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'CENT CTR'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'CENTER  CTR'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'CENTR  CTR'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'CENTRE CTR'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'CNTER  CTR'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'CNTR  CTR'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'CENTERS  CTRS'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'CIRC  CIR'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'CIRCL  CIR'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'CIRCLE  CIR'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'CRCL  CIR'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'CRCLE  CIR'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'CIRCLES  CIRS'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'CLIFF  CLF'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'CLIFFS  CLFS'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'CLUB  CLB'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'COMMON  CMN'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'CORNER  COR'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'CORNERS  CORS'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'COURSE  CRSE'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'COURT  CT'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'CRT  CT'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'COURTS  CTS'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'COVE  CV'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'COVES  CVS'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'CK  CRK'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'CR  CRK'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'CREEK  CRK'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'CRECENT  CRES'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'CRESCENT  CRES'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'CRESENT  CRES'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'CRSCNT  CRES'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'CRSENT  CRES'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'CRSNT  CRES'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'CREST  CRST'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'CROSSING  XING'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'CRSSING  XING'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'CRSSNG  XING'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'CROSSROAD  XRD'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'CURVE  CURV'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'DALE DL'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'DAM DM'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'DIV DV'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'DIVIDE DV'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'DVD DV'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'DRIV DR'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'DRIVE DR'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'DRV DR'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'DRIVES DRS'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'ESTATE EST'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'ESTATES ESTS'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'EXP EXPY'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'EXPR EXPY'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'EXPRESS EXPY'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'EXPRESSWAY EXPY'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'EXPW EXPY'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'EXTENSION EXT'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'EXTN EXT'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'EXTNSN EXT'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'EXTENSIONS EXTS'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'FALLS FLS'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'FERRY FRY'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'FRRY FRY'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'FIELD FLD'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'FIELDS FLDS'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'FLAT FLT'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'FLATS FLTS'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'FORD FRD'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'FORDS FRDS'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'FOREST FRST'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'FORESTS FRST'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'FORG FRG'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'FORGE FRG'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'FORGES FRGS'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'FORK FRK'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'FORKS FRKS'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'FORT FT'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'FRT FT'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'FREEWAY FWY'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'FREEWY FWY'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'FRWAY FWY'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'FRWY FWY'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'GARDEN GDN'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'GARDN GDN'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'GRDEN GDN'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'GRDN GDN'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'GARDENS GDNS'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'GRDNS GDNS'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'GATEWAY GTWY'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'GATEWY GTWY'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'GATWAY GTWY'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'GTWAY GTWY'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'GLEN GLN'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'GLENS GLNS'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'GREEN GRN'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'GREENS GRNS'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'GROV GRV'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'GROVE GRV'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'GROVES GRVS'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'HARB HBR'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'HARBOR HBR'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'HARBR HBR'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'HRBOR HBR'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'HARBORS HBRS'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'HAVEN HVN'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'HAVN HVN'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'HEIGHT HTS'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'HEIGHTS HTS'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'HGTS HTS'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'HT HTS'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'HIGHWAY HWY'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'HIGHWY HWY'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'HIWAY HWY'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'HIWY HWY'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'HWAY HWY'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'HILL HL'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'HILLS HLS'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'HLLW HOLW'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'HOLLOW HOLW'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'HOLLOWS HOLW'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'HOLWS HOLW'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'INLET INLT'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'ISLAND IS'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'ISLND IS'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'ISLANDS ISS'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'ISLNDS ISS'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'ISLES ISLE'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'JCTION JCT'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'JCTN JCT'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'JUNCTION JCT'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'JUNCTN JCT'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'JUNCTON JCT'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'JCTNS JCTS'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'JUNCTIONS JCTS'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'KEY KY'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'KEYS KYS'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'KNOL KNL'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'KNOLL KNL'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'KNOLLS KNLS'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'LAKE LK'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'LAKES LKS'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'LANDING LNDG'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'LNDNG LNDG'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'LA LN'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'LANE LN'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'LANES LN'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'LIGHT LGT'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'LIGHTS LGTS'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'LOAF LF'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'LOCK LCK'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'LOCKS LCKS'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'LDGE LDG'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'LODG LDG'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'LODGE LDG'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'LOOPS LOOP'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'MANOR MNR'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'MANORS MNRS'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'MEADOW MDW'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'MEADOWS MDWS'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'MEDOWS MDWS'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'MILL ML'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'MILLS MLS'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'MISSION MSN'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'MISSN MSN'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'MSSN MSN'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'MOTORWAY MTWY'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'MNT MT'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'MOUNT MT'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'MNTAIN MTN'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'MNTN MTN'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'MOUNTAIN MTN'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'MOUNTIN MTN'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'MTIN MTN'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'MNTNS MTNS'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'MOUNTAINS MTNS'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'NECK NCK'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'ORCHARD ORCH'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'ORCHRD ORCH'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'OVL OVAL'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'OVERPASS OPAS'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'PK PARK'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'PRK PARK'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'PARKS PARK'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'PARKWAY PKWY'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'PARKWY PKWY'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'PKWAY PKWY'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'PKY PKWY'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'PARKWAYS PKWY'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'PKWYS PKWY'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'PASSAGE PSGE'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'PATHS PATH'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'PIKES PIKE'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'PINE PNE'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'PINES PNES'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'PNES PNES'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'PLACE PL'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'PLAIN PLN'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'PLAINES PLNS'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'PLAINS PLNS'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'PLNS PLNS'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'PLAZA PLZ'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'PLZA PLZ'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'POINT PT'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'POINTS PTS'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'PORT PRT'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'PORTS PRTS'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'PRAIRIE PR'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'PRARIE PR'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'PRR PR'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'RAD RADL'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'RADIAL RADL'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'RADIEL RADL'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'RANCH RNCH'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'RANCHES RNCH'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'RNCHS RNCH'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'RAPID RPD'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'RAPIDS RPDS'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'REST RST'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'RDGE RDG'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'RIDGE RDG'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'RIDGES RDGS'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'RIVER RIV'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'RIVR RIV'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'RVR RIV'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'ROAD RD'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'ROADS RDS'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'ROUTE RTE'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'SHOAL SHL'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'SHOALS SHLS'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'SHOAR SHR'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'SHORE SHR'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'SHOARS SHRS'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'SHORES SHRS'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'SKYWAY SKWY'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'SPNG SPG'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'SPRING SPG'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'SPRNG SPG'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'SPNGS SPGS'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'SPRINGS SPGS'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'SPRNGS SPGS'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'SPURS SPUR'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'SQR SQ'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'SQRE SQ'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'SQU SQ'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'SQUARE SQ'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'SQRS SQS'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'SQUARES SQS'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'STATION STA'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'STATN STA'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'STN STA'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'STRAV STRA'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'STRAVE STRA'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'STRAVEN STRA'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'STRAVENUE STRA'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'STRAVN STRA'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'STRVN STRA'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'STRVNUE STRA'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'STREAM STRM'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'STREME STRM'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'STR ST'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'STREET ST'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'STRT ST'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'STREETS STS'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'SUMIT SMT'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'SUMITT SMT'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'SUMMIT SMT'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'TERR TER'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'TERRACE TER'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'THROUGHWAY TRWY'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'TRACE TRCE'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'TRACES TRCE'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'TRACK TRAK'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'TRACKS TRAK'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'TRAK TRAK'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'TRK TRAK'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'TRKS TRAK'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'TRAFFICWAY TRFY'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'TR TRL'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'TRAIL TRL'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'TRAILS TRL'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'TRLS TRL'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'TUNEL TUNL'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'TUNLS TUNL'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'TUNNEL TUNL'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'TUNNELS TUNL'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'TUNNL TUNL'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'TPK TPKE'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'TRNPK TPKE'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'TRPK TPKE'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'TURNPIKE TPKE'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'TURNPK TPKE'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'UNDERPASS UPAS'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'UNION UN'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'UNIONS UNS'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'VALLEY VLY'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'VALLY VLY'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'VLLY VLY'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'VALLEYS VLYS'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'VDCT VIA'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'VIADCT VIA'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'VIADUCT VIA'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'VIEW VW'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'VIEWS VWS'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'VILL VLG'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'VILLAG VLG'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'VILLAGE VLG'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'VILLG VLG'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'VILLIAGE VLG'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'VILLAGES VLGS'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'VILLE VL'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'VIST VIS'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'VISTA VIS'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'VST VIS'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'VSTA VIS'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'WALKS WALK'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'WY WAY'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'WELL WL'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'WELLS WLS'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'APARTMENT APT'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'APPT APT'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'BASEMENT BSMT'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'BUILDING BLDG'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'DEPARTMENT DEPT'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'FLOOR FL'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'FLR FL'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'FRONT FRNT'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'HANGAR HNGR'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'LOBBY LBBY'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'LOWER LOWR'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'OFFICE OFC'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'PENTHOUSE PH'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'ROOM RM'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'SPACE SPC'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'SUITE'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'UNIT'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'TRAILER TRLR'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'UPPER UPPR'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'NORTH N'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'SOUTH S'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'EAST E'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'WEST W'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'NORTHWEST NW'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'NORTHEAST NE'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'SOUTHWEST SW'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'SOUTHEAST SE'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND '"NORTH WEST" NW'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND '"NORTH EAST" NE'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND '"SOUTH WEST" SW'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND '"SOUTH EAST" SE'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'FIRST 1ST'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'SECOND 2ND'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'THIRD 3RD'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'FOURTH 4TH'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'FIFTH 5TH'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'SIXTH 6TH'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'SEVENTH 7TH'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'EIGHTH 8TH'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'NINTH 9TH'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'TENTH 10TH'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'ELEVENTH 11TH'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'TWELFTH 12TH'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'THIRTEENTH 13TH'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'FOURTEENTH 14TH'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'FIFTEENTH 15TH'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'SIXTEENTH 16TH'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'SEVENTEENTH 17TH'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'EIGHTEENTH 18TH'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'NINETEENTH 19TH'
LIST UNFORMATTED TO addr.sub FIRST 1 APPEND 'TWENTITH 20TH'
RETURN
