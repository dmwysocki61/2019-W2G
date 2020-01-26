* Program Name: W2G0810
* Author:       David M. Wysocki
* Company:      Diversified Tech Systems, Inc.
* Client:       Palm Beach Kennel Club, Inc.
* Purpose:      Create Magnetic Media - A record
*
function w2g0810()
memvar getlist
private pyr_nm1    := space(40)
private pyr_nm2    := space(40)
private pyr_adre   := space(40)
private pyr_city   := space(40)
private pyr_state  := space(02)
private pyr_zip    := space(09)
private pyr_zip1   := space(05)
private pyr_zip2   := space(04)
private nm_cntrl   := space(04)
private tcc        := space(05)
private ein        := space(09)
private ein1       := space(02)
private ein2       := space(07)
private time       := space(08)
private contact    := space(40)
private area_cd    := space(03)
private prefix     := space(03)
private suffix     := space(04)
private extnsn     := space(05)
private elec_fl_nm := space(15)
private repl_alpha := space(02)

CLEAR

select 4

m->rec_cnt := lastrec()

select 8
pyr_nm1    :=   payer->name
pyr_adre   :=   payer->address1
pyr_city   :=   rtrim(payer->city)
pyr_state  :=   payer->state
pyr_zip1   :=   substr(payer->zip,1,5)
pyr_zip2   :=   substr(payer->zip,7,4)
tcc        :=   payer->tcc
nm_cntrl   :=   payer->name_cntl
ein1       :=   substr(payer->ein,1,2)
ein2       :=   substr(payer->ein,4,7)
contact    :=   payer->contact_nm
area_cd    :=   substr(payer->contact_ph,1,3)
prefix     :=   substr(payer->contact_ph,5,3)
suffix     :=   substr(payer->contact_ph,9,4)
do while .t.
   clear
   @ 00,20 say '2019 Electronic Filing Program'
   @ 02,00 say 'Enter Legal Entity Name:'
   @ 07,00 say 'Address:'
   @ 09,00 say 'City:'
   @ 11,00 say 'State:'
   @ 11,15 say 'Zip:'
   @ 11,25 say '-'
   @ 13,00 say 'Name Control:'
   @ 13,37 say 'Replacement File: '
   @ 15,00 say 'Transmitter Control Code:'
   @ 15,37 say 'Replacement File Name:'
   @ 17,00 say 'Federal EIN:'
   @ 17,17 say '-'
   @ 19,00 say 'Enter contact name:'
   @ 22,00 say 'Enter contact phone:'
   @ 22,23 say '('
   @ 22,27 say ')'
   @ 22,31 say '-'
   @ 22,37 say 'Ext:'

   @ 03,00 get m->pyr_nm1    picture '!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!'
   @ 05,00 get m->pyr_nm2    picture '!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!'
   @ 07,10 get m->pyr_adre   picture '!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!'
   @ 09,10 get m->pyr_city   picture '!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!'
   @ 11,10 get m->pyr_state  picture '!!'
   @ 11,20 get m->pyr_zip1   picture '99999'
   @ 11,26 get m->pyr_zip2   picture '9999'
   @ 13,15 get m->nm_cntrl   picture '!!!!'
   @ 13,60 get m->repl_alpha picture '!!'
   @ 15,26 get m->tcc        picture '!!!!!'
   @ 15,60 get m->elec_fl_nm
   @ 17,15 get m->ein1       picture '99'
   @ 17,18 get m->ein2       picture '9999999'
   @ 20,00 get m->contact    picture '!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!'
   @ 22,24 get m->area_cd    picture '999'
   @ 22,28 get m->prefix     picture '999'
   @ 22,32 get m->suffix     picture '9999'
   @ 22,41 get m->extnsn     picture '99999'

   read

   @ 24,00 SAY 'Is the above information correct (Y/N), X to exit.'

   m->choice = ' '

   DO WHILE .NOT. M->CHOICE $'YNX'
      m->choice = ' '
      @ 24,52 get m->choice picture '!'
      read
   enddo

   do case
      case m->choice = 'Y'
           exit
      case m->choice = 'N'
           loop
      case m->choice = 'X'
           clear
           return (nil)
   endcase
enddo

m->time = time()
@ 19,00 clear
@ 19,00 say 'Creating A Records.... ' + m->time
m->ein = m->ein1+m->ein2

select 10

zap
append blank

replace trecord->record_typ   with   'T'
replace trecord->pymnt_year   with   '2019'
replace trecord->prior_year   with   ' '
replace trecord->trans_tin    with   m->ein
replace trecord->tcc          with   m->tcc
replace trecord->blank1       with   space(7)
replace trecord->test_ind     with   ' '
replace trecord->foreign_in   with   ' '
replace trecord->trans_nm1    with   m->pyr_nm1
replace trecord->trans_nm2    with   m->pyr_nm2
replace trecord->cmpny_nm1    with   m->pyr_nm1
replace trecord->cmpny_nm2    with   m->pyr_nm2
replace trecord->cmpny_addr   with   m->pyr_adre
replace trecord->cmpny_city   with   m->pyr_city
replace trecord->cmpny_stat   with   m->pyr_state
replace trecord->cmpny_zip    with   m->pyr_zip1 + m->pyr_zip2
replace trecord->blank2       with   space(15)

m->hold1 = space(8)
m->hold2 = space(8)

m->hold1 = transform(m->rec_cnt,"********")
m->hold2 = strtran(m->hold1,'*','0')

replace trecord->tot_payees   with   m->hold2
replace trecord->contact_nm   with   m->contact
replace trecord->contact_ph   with   m->area_cd + m->prefix + m->suffix + m->extnsn
replace trecord->contact_em   with   'jmong@magiccitycasino.com'
replace trecord->blank3       with   space(91)
replace trecord->record_seq   with   '00000001'
replace trecord->blank4       with   space(10)
replace trecord->vendor_ind   with   'V'
replace trecord->vendor_nm    with   'Diversified Tech Systems, Inc.'
replace trecord->vendor_adr   with   '14001 NW 13th Street'
replace trecord->vendor_cty   with   'Pembroke Pines'
replace trecord->vendor_st    with   'FL'
replace trecord->vendor_zip   with   '33028'
replace trecord->vendor_ctc   with   'David M Wysocki'
replace trecord->vendor_phn   with   '9543283328'
replace trecord->blank51      with   space(35)
replace trecord->vendor_frn   with   space(1)
replace trecord->blank52      with   space(10) 

goto top

copy to trecord.txt sdf
zap
close 10

select 1
zap

append blank
replace arecord->record_typ   with   'A'
replace arecord->payment_yr   with   '2019'
replace arecord->cmb_fed_st   with   space(01)
replace arecord->blank1       with   space(05)
replace arecord->payer_ein    with   m->ein
replace arecord->name_cntrl   with   m->nm_cntrl
replace arecord->lst_fil_in   with   space(01)
replace arecord->return_typ   with   'W'
replace arecord->amnt_indca   with   '127         '
replace arecord->blank2       with   space(08)

*if m->repl_alpha = '  '
*   replace arecord->orig_file with   '1'
*   replace arecord->repl_file with   ' '
*else
*   replace arecord->orig_file with   ' '
*   replace arecord->repl_file with   '1'
*end-if    

*replace arecord->corr_file    with   ' '
*replace arecord->blank3       with   ' '
replace arecord->foreign_en   with   ' ' 

replace arecord->payer_nm1    with   m->pyr_nm1
replace arecord->payer_nm2    with   m->pyr_nm2
replace arecord->trnsfr_agn   with   '0'
replace arecord->payer_addr   with   m->pyr_adre
replace arecord->payer_city   with   m->pyr_city

replace arecord->payer_st     with   m->pyr_state
replace arecord->payer_zip    with   m->pyr_zip1 + m->pyr_zip2
replace arecord->payer_phon   with   m->area_cd  + m->prefix + m->suffix + m->extnsn
replace arecord->blank3       with   space(260)
replace arecord->record_seq   with  '00000002'
replace arecord->blank4       with   space(243)

goto top
copy to arecord.txt sdf
zap
close 1
return (nil)
