* Program Name: W2G0270
* Author:       David M. Wysocki
* Company:      Diversified Technical Service, Inc.
* Client:       Palm Beach Kennel Club
* Purpose:      Database Reporting - Report by Date Range.
*
*
function w2g0270()

memvar getlist

set safety off

select 5
use rpt0270
zap

select 2

m->p_date   := ticket->batch_date
m->b_number := ticket->batch_num
do while   (ticket->batch_date <= m->e_date)
   do while ticket->batch_num  = m->b_number .and. ;
	        ticket->batch_date = m->p_date   .and. .not. eof()
	    m->b_gross    += ticket->gross
	    m->b_fed_with += ticket->fed_with
        m->b_sta_with += ticket->sta_with
	    m->rpt_gross  += ticket->gross
	    m->rpt_fed    += ticket->fed_with
        m->rpt_state  += ticket->sta_with
        
	    skip
   enddo

   select 5

   append blank
   replace  rpt0270->batch_date with m->p_date
   replace  rpt0270->batch_num  with m->b_number
   replace  rpt0270->gross      with m->b_gross
   replace  rpt0270->fed_with   with m->b_fed_with
   replace  rpt0270->sta_with   with m->b_sta_with
   
   select 2

   if eof()
      exit
   endif
   m->p_date     := ticket->batch_date
   m->b_number   := ticket->batch_num
   m->b_gross    := 0
   m->b_fed_with := 0
   m->b_sta_with := 0
   
enddo

select 5
goto top

m->l_number = 7

set device to printer

if m->laser = 'Y'
   m->printer_init := 'e(10u&l1o&l8d&l5e&l66f&k2s(s8v'
*   printcodes (m->printer_init)
end-if

do w2g0275

select 5

do while .not. eof()
   @  m->l_number, 001  say rpt0270->batch_date
   @  m->l_number, 010  say rpt0270->batch_num
   @  m->l_number, 020  say rpt0270->gross     picture '999,999.99'
   @  m->l_number, 035  say rpt0270->fed_with  picture '999,999.99'
   @  m->l_number, 050  say rpt0270->sta_with  picture '999,999.99'

   skip

   ++m->l_number

   if m->l_number > 58 .and. .not. eof()
      do w2g0275
      select 5
   endif

enddo

m->l_number += 2

if m->l_number > 58
   do w2g0275
   select 5
endif

@ m->l_number,001 say 'Report Totals: '
@ m->l_number,017 say m->rpt_gross       picture '99,999,999.99'
@ m->l_number,032 say m->rpt_fed         picture '99,999,999.99'
@ m->l_number,047 say m->rpt_state		 picture '99,999,999.99'

eject

set device to screen
return (nil)
* eof: w2g0270.prg
