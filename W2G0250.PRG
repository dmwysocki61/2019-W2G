* Program Name: W2G0250
* Author:       David M. Wysocki
* Company:      Diversified Tech Systems, Inc.
* Client:       Palm Beach Kennel Club
* Purpose:      Database Reporting - Report by Batch Date and Number
*
*
function w2g0250()
memvar getlist
clear
public  m_f5      := space (01) 
private b_date    := date()
private b_number  := 0
private tot_gross := 0
private tot_fed   := 0
private tot_state := 0

private gross     := 0
private fed_with  := 0
private sta_with  := 0

private p_number  := 0
private perf_num  := space(4)
private rec_id    := space(9)
private choice    := ' '
private vld_btch  := ' '
private r         := 4

set escape on
set date american
do while .t.

   clear
   select 3

   m->choice = ' '
   m->b_number = 0

   @ 01,20 say "Batch Selection Screen"
   @ 03,05 say "Enter date of batch to select"
   @ 05,05 say "Enter number of batch to select:"
   @ 07,05 say "F2:->Exit F5:->View batches for a given date."

   @ 03,55 get m->b_date
   @ 05,59 get m->b_number picture '9999'

   read

   if m->m_f2 = 'Y'
      clear
      return (nil)
   endif

   if m->m_f5 = 'Y'
      m->m_f5 = 'N'      
      loop
   endif

   select 2

   set index to batchid
   seek dtoc(m->b_date)+str(m->b_number,4)

   if eof()
      @ 23,0  clear
      @ 23,0  say 'w2g0250.2: no data found for this batch.'
      wait
*  set active database back to batchctl so that f4 key will work
*  when it calls proc030
      select 3
      loop
   else
      m->rec_id := ticket->record_id
      exit
   endif
enddo

select 3
seek dtoc(m->b_date)+str(m->b_number,4)

if eof()
   @ 23,0  clear
   @ 23,10 say 'w2g0250.3 database index error. perform database maintenance.'
   wait
   return (nil)
endif

m->perf_num = batchctl->perf_num

select 2

clear
@ 7,15 say 'Report generation in progress. One moment please!!!'

* set printer to c:\temp\w2g0250.rpt

set device to printer

if m->laser = 'Y'
   m->printer_init := 'e(10u&l1o&l8d&l5e&l66f&k2s(s8v'
*   printcodes (m->printer_init)
end-if

do w2g0255

select 2
do while ticket->batch_date = m->b_date   .and. ;
	     ticket->batch_num  = m->b_number .and. .not. eof()
   select 1
   seek m->rec_id

   if eof()
      set device to screen
      @ 23,0 clear
      @ 23,0 say 'w2g0250.4 - database index error. contact system programmer.'
      wait
      close databases
      quit
   endif

   @  m->l_number, 01  say payee->record_id

   if payee->middle_int = ' '
      @  m->l_number, 11  say ltrim(rtrim(payee->first_name))+' '+ ;
			                  ltrim(rtrim(payee->last_name))
   else
      @  m->l_number, 11  say ltrim(rtrim(payee->first_name))+' '+ ;
			                  ltrim(rtrim(payee->middle_int))+' '+ ;
			                  ltrim(rtrim(payee->last_name))
   endif
   
   @  m->l_number, 45  say payee->address
   @  m->l_number, 75  say ltrim(rtrim(payee->city)) + ',' + ;
			               ltrim(rtrim(payee->state))

   select 2

   do while ticket->record_id = m->rec_id .and. .not. eof()

      m->gross     += ticket->gross
      m->fed_with  += ticket->fed_with
      m->tot_gross += ticket->gross
      m->tot_fed   += ticket->fed_with
      m->tot_state += ticket->sta_with
      
      @  m->l_number, 103 say ticket->gross     picture '999,999.99'
      @  m->l_number, 117 say ticket->fed_with	picture '999,999.99'
      @  m->l_number, 130 say ticket->sta_with  picture '999,999.99'
      
      ++m->l_number

      if m->l_number > 58
	     do w2g0255
	     select 2
      endif

      skip
   enddo
   m->rec_id = ticket->record_id

   ++m->l_number

   if m->l_number > 58
      do w2g0255
   endif

   @  m->l_number, 085  say 'Payee Totals: '
   @  m->l_number, 103  say m->gross	  picture '999,999.99'
   @  m->l_number, 117  say m->fed_with	  picture '999,999.99'
   @  m->l_number, 130  say m->sta_with   picture '999,999.99'

   m->l_number += 2

   if m->l_number > 58
      do w2g0255
   endif

   m->gross    := 0
   m->fed_with := 0
   m->sta_with := 0

   select 2

enddo

m->l_number += 2

if m->l_number > 58
   do w2g0255
endif

@ m->l_number, 085  say 'Batch totals: '
@ m->l_number, 103  say m->tot_gross picture '999,999.99'
@ m->l_number, 117  say m->tot_fed	 picture '999,999.99'
@ m->l_number, 130  say m->tot_state picture '999,999.99'
eject
set device to screen
return (nil)
* eof: w2g0250.prg
