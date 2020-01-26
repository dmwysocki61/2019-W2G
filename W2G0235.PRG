* Program Name: W2G0235
* Author:       David M. Wysocki
* Company:      Diversified Technical Service, Inc.
* Client:       Palm Beach Kennal Club
* Purpose:      Database Reporting - Report by SSN - Summary Listing
*
*
function w2g0235()
memvar getlist

set escape on
set safety off
set exact  on

private rec_id     := space(9)
private name       := space(32)
private address    := space(30)
private city       := space(25)
private state      := space(2)
private zip        := space(5)
private gross      := 0
private fed_with   := 0
private sta_with   := 0
private ytd_gross  := 0
private ytd_fed    := 0
private ytd_state  := 0
private tkt_count  := 0
private p_number   := 0
private l_number   := 0
private r          := 4
private choice     := ' '
private time       := space (8)
clear

time = time()

@ 1,15 say 'Report start time: ' + m->time
@ 3,15 say 'Creating report. One moment please.'

select 5
use rpt0235

zap

select 2
goto top

select 1
goto top

do while .not. eof()
   m->rec_id = payee->record_id
   if payee->middle_int = ' '
      m->name = ltrim(rtrim(payee->last_name)) + ', ' + ;
    	        ltrim(rtrim(payee->first_name))
   else
      m->name = ltrim(rtrim(payee->last_name)) + ', ' + ;
	            ltrim(rtrim(payee->first_name))+ ' '  + ;
	            ltrim(rtrim(payee->middle_int))
   endif

   m->address := payee->address
   m->city    := payee->city
   m->state   := payee->state

   select 2

   seek m->rec_id

   if eof()
   else
      do while m->rec_id = ticket->record_id .and. .not. eof()

         m->gross      += ticket->gross
         m->fed_with   += ticket->fed_with
         m->sta_with   += ticket->sta_with
         
         m->ytd_gross  += ticket->gross
         m->ytd_fed    += ticket->fed_with
         m->ytd_state  += ticket->sta_with
         
         ++m->tkt_count

         skip

      enddo

   end-if

   select 5

   append blank

   replace rpt0235->record_id with m->rec_id
   replace rpt0235->name      with m->name
   replace rpt0235->address   with m->address
   replace rpt0235->city      with m->city
   replace rpt0235->state     with m->state
   replace rpt0235->zip       with m->zip
   replace rpt0235->gross     with m->gross
   replace rpt0235->fed_with  with m->fed_with
   replace rpt0235->sta_with  with m->sta_with
   
   m->rec_id   := space (9)
   m->name     := space (32)
   m->address  := space (30)
   m->city     := space (25)
   m->state    := space (2)
   m->zip      := space (5)
   m->gross    := 0
   m->fed_with := 0
   select 1
   skip
enddo

@ 5,15 say 'Spooling report to printer. One moment please.'
set device to printer

m->printer_init := 'e(10u&l1o&l8d&l5e&l66f&k2s(s8v'
@ 0,0 say m->printer_init

do w2g0232

select 5

goto top

do while .not. eof()
   @  m->l_number, 1   say rpt0235->record_id
   @  m->l_number, 11  say rpt0235->name
   @  m->l_number, 45  say rpt0235->address
   @  m->l_number, 105 say rpt0235->gross     picture '999,999.99'
   @  m->l_number, 121 say rpt0235->fed_with  picture '999,999.99'
   @  m->l_number, 136 say rpt0235->sta_with  picture '999,999.99'
   
   ++m->l_number

   @  m->l_number, 45  say ltrim(rtrim(rpt0235->city)) + ', ' + ;
                                 rpt0235->state  + ' '  + ;
				                 rpt0235->zip
   skip

   m->l_number += 2

   if m->l_number > 56 .and. .not. eof()
      do w2g0232
      select 5
   endif
enddo

m->l_number += 2

if m->l_number > 56
   do w2g0232
   select 5
endif

@ m->l_number, 1   say 'YTD totals:'
@ m->l_number, 15  say 'Ticket count: '
@ m->l_number, 30  say m->tkt_count  picture '999,999'
@ m->l_number, 102 say m->ytd_gross  picture '99,999,999.99'
@ m->l_number, 118 say m->ytd_fed    picture '99,999,999.99'
@ m->l_number, 133 say m->ytd_state  picture '99,999,999.99'

eject

select 5

zap

set device to screen

m->time := time()
@ 7,15 say 'Report complete.'
@ 9,15 say 'Report end time: ' + m->time

wait
return (nil)
* eof w2g0235.prg
