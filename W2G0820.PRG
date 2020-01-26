* Program Name: W2G0820
* Author:       David M. Wysocki
* Company:      Diversified Tech Systems, Inc.
* Client:       Palm Beach Kennel Club, Inc.
* Purpose:      Create Magnetic Media
*
function w2g0820(prgm_err)
memvar getlist

private time         :=   space(08)
private hold1        :=   space(20)
private hold2        :=   space(20)
private hold3        :=   space(20)
private nm_cntl      :=   space(04)
private rec_id       :=   space(09)
private twelve_zeros :=   '000000000000'
private pyr_acctno   :=   0

set date format "yyyymmdd"
set decimals to 2

m->time           := time()

@ 20,00 say 'Creating B Records.... ' + m->time

m->rec_cnt := 0
select 2
zap

select 3
goto top

select 4
goto top

do while .not. eof()

   m->rec_id = payee->record_id

   select 4
   seek m->rec_id

   if eof()
      clear
      @ 0,0 say 'W2G0820.1: Database Error Encountered.'
      @ 1,0 say 'Record Id: ' + m->rec_id
      @ 2,0 say 'Run all database error reports, resolve discrepancies, and re-run.'
      wait
      close databases
          m->prgm_err := 'Y'
          return (prgm_err)
   endif

   do while ticket->record_id = m->rec_id

      select 2

      append blank

      replace brecord->record_typ   with   'B'
      replace brecord->payment_yr   with   '2019'
      replace brecord->corr_retrn   with   ' '

      m->nm_cntl = space(04)
      m->nm_cntl = substr(payee->last_name,1,4)
      m->nm_cntl = strtran(m->nm_cntl,"'")

      replace brecord->name_cntrl   with   m->nm_cntl
      replace brecord->type_tin     with   '2'
      replace brecord->txpyr_id     with   payee->record_id

      ++m->pyr_acctno

      m->hold1 = transform(m->pyr_acctno,"********************")
      m->hold2 = strtran(m->hold1,'*','0')
      m->hold3 = strtran(m->hold2,'.')

      replace brecord->pyr_acctno   with   m->hold3
      replace brecord->pyr_off_cd   with   space(4)
      replace brecord->blank_01     with   space(10)

      m->hold1 = space(12)
      m->hold2 = space(12)
      m->hold3 = space(12)

      m->hold1 = transform(ticket->gross,"**********.**")

      m->hold2 = strtran(m->hold1,'*','0')
      m->hold3 = strtran(m->hold2,'.')

      replace brecord->amount1      with   m->hold3
      
      m->hold1 = space(12)
      m->hold2 = space(12)
      m->hold3 = space(12)
      m->hold1 = transform(ticket->fed_with,"**********.**")
      m->hold2 = strtran(m->hold1,'*','0')
      m->hold3 = strtran(m->hold2,'.')

      replace brecord->amount2     with   m->hold3
      
      replace brecord->amount3     with   m->twelve_zeros
      replace brecord->amount4     with   m->twelve_zeros
      replace brecord->amount5     with   m->twelve_zeros
      replace brecord->amount6     with   m->twelve_zeros
      replace brecord->amount7     with   m->twelve_zeros
      replace brecord->amount8     with   m->twelve_zeros
      replace brecord->amount9     with   m->twelve_zeros
                                                                   
      replace brecord->amounta     with   m->twelve_zeros
      replace brecord->amountb     with   m->twelve_zeros
      replace brecord->amountc     with   m->twelve_zeros
      replace brecord->amountd     with   m->twelve_zeros
      replace brecord->amounte     with   m->twelve_zeros

      replace brecord->amountg     with   m->twelve_zeros
      replace brecord->amountf     with   m->twelve_zeros

      replace brecord->frgn_cntry  with   space(01)

      replace brecord->frst_nm_ln  with   payee->last_name + ' ' + ;
                                          payee->first_name

      replace brecord->scnd_nm_ln  with   space (40)
      replace brecord->blank_02    with   space (40)

      replace brecord->pye_addres  with   payee->address

      replace brecord->blank_03    with   space (40)

      replace brecord->pye_city    with   payee->city
      replace brecord->pye_state   with   payee->state
      replace brecord->pye_zip     with   payee->zip
      
      replace brecord->blank_04    with   space(01)

      m->hold1 = space(08)
      m->hold2 = space(08)
      m->hold1 = transform(m->record_seq,"********")
      m->hold2 = strtran(m->hold1,'*','0')

      replace brecord->record_seq  with   m->hold2

      ++m->record_seq

      replace brecord->blank_05    with   space(36)
      replace brecord->blank_06    with   space(03)

      replace brecord->wager_type  with   '2'
      
      m->date1 = space(10)
      m->date2 = space(8)

      m->date1 = dtoc(ticket->date_won)
      m->date2 = strtran(m->date1,'/','')

      replace brecord->date_won     with   m->date2

      replace brecord->transactio   with   ticket->trans

      m->race1 = space(5)
      m->race2 = space(5)
      m->race1 = str(ticket->race)
      m->race2 = ltrim(m->race1)

      replace brecord->race         with   m->race2

      m->cash1   = space(5)
      m->cash2   = space(5)
      m->cash1   = str(ticket->cashier)
      m->cash2   = ltrim(m->cash1)

      replace brecord->cashier      with   m->cash2

      m->wind1   = space(5)
      m->wind2   = space(5)
      m->wind1   = str(ticket->window)
      m->wind2   = ltrim(m->wind1)

      replace brecord->window       with   m->wind2
      replace brecord->first_id     with   payee->first_id
      replace brecord->second_id    with   payee->second_id

      replace brecord->blank_07     with   space (47)
      replace brecord->spcl_entry   with   space (60)

      m->hold1 := space(12)
      m->hold2 := space(12)
      m->hold3 := space(12)
      m->hold1 := transform(ticket->sta_with,"**********.**")
      m->hold2 := strtran(m->hold1,'*','0')
      m->hold3 := strtran(m->hold2,'.')

      replace brecord->state_tax   with   m->hold3
      replace brecord->local_tax   with   m->twelve_zeros     
      replace brecord->blank_08    with   space(04)

      m->tot_grs += ticket->gross
      m->tot_fed += ticket->fed_with
      m->tot_sta += ticket->sta_with
      ++m->rec_cnt 
      select 4
      skip
   enddo
   select 3
   skip
enddo
select 2
goto top
copy to brecord.txt sdf
zap
return (nil)
*eof w2g0820.prg
