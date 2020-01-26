* Program Name: W2G0260
* Author:       David M. Wysocki
* Company:      Diversified Technical Service, Inc.
* Client:       Palm Beach Kennel Club
* Purpose:      Database Reporting - Report by Date Range.
*
*
function w2g0260()
memvar getlist
private b_date     := date()
private e_date     := date()
private hold_date  := date()
private hold_num   := 0
private b_gross    := 0
private b_fed_with := 0
private b_sta_with := 0
private rpt_gross  := 0
private rpt_fed    := 0
private rpt_state  := 0
private perf_num   := space (04)
private choice     := ' '
select 2
set index to batchid
clear
@ 7,15 say 'Rebuilding indexes. One moment please...'
pack
clear
@ 01,20 say "Batch Selection Screen"
@ 03,10 say "Enter begin date"
@ 05,10 say "Enter end date:"
@ 07,10 say "Enter x to exit:"

do while .t.
   @ 03,30 get m->b_date
   @ 05,30 get m->e_date
   @ 07,30 get m->choice picture '!'

   read

   if m->choice = 'x'

      clear
      return (nil)

   else

      if m->b_date > m->e_date
	     @ 24,0  clear
	     @ 24,0  say 'w2g0260.1: ending date must be after beginning date'
	     loop
      endif

   endif

   seek dtoc(m->b_date) softseek

   if eof()
      @ 23,0  clear
      @ 23,0  say 'w2g0260.2: beginning date is beyond the end of the file.'
      @ 24,0  say 'please enter an earlier begin date.'
      loop

   else

      m->hold_num   := ticket->batch_num
      m->hold_date  := ticket->batch_date
      exit

   endif

enddo

clear

@ 0 ,20 say "Report by date range"
@ 02,20 say "D - Detail listing"
@ 03,20 say "S - Summary listing"
@ 04,20 say "X - Exit"
@ 05,20 get  m->choice picture '!'

read

do while .not. m->choice$'DSX'
   m->choice = ' '
   @ 05,20 get m->choice
   read
enddo

if m->choice = 'x'
   clear
   return (nil)
endif

set index to batchid

seek dtoc(m->hold_date)+str(m->hold_num,4)

if eof()
   @ 24,0 clear
   @ 24,0 say 'w2g0260.3: database index error. notify system programmer.'
   wait
   clear
   return (nil)
endif

select 3
seek dtoc(m->hold_date)+str(m->hold_num,4)

if eof()
   @ 24,0 clear
   @ 24,0 say 'w2g0260.4: database index error. notify system programmer.'
   wait
   clear
   return (nil)
else
   m->perf_num = batchctl->perf_num
endif

select 2

clear

@ 7,15 say 'Generating report. One moment please !!!'

* set printer to c:\temp\w2g0270.rpt

if m->choice = 'S'
   do w2g0270
   return (nil)
endif

set device to printer

if m->laser = 'Y'
   m->printer_init := 'e(10u&l1o&l8d&l5e&l66f&k2s(s8v'
*   printcodes (m->printer_init)
end-if

do w2g0265

select 2

do while (ticket->batch_date <= m->e_date)
   do while (ticket->batch_date = m->hold_date .and. ;
	         ticket->batch_num  = m->hold_num) .and. .not. eof()

      m->b_gross    += ticket->gross
      m->b_fed_with += ticket->fed_with
      m->b_sta_with += ticket->sta_with

      m->rpt_gross  += ticket->gross
      m->rpt_fed    += ticket->fed_with
      m->rpt_state  += ticket->sta_with

      if m->l_number > 58
	     do w2g0265
	     select 2
      endif

      @  m->l_number, 001 say ticket->record_id
      @  m->l_number, 011 say ticket->batch_date
      @  m->l_number, 025 say ticket->batch_num
      @  m->l_number, 034 say ticket->gross      picture '999,999.99'
      @  m->l_number, 052 say ticket->fed_with   picture '999,999.99'
      @  m->l_number, 065 say ticket->sta_with   picture '999,999.99'
      @  m->l_number, 080 say m->perf_num        picture '!!!!'

      skip

      ++m->l_number

   enddo

   m->hold_date = ticket->batch_date
   m->hold_num  = ticket->batch_num

   m->l_number += 2

   if m->l_number > 58
      do w2g0265
   endif

   @  m->l_number, 001  say 'Batch Totals: '
   @  m->l_number, 034  say m->b_gross     picture '999,999.99'
   @  m->l_number, 052  say m->b_fed_with  picture '999,999.99'
   @  m->l_number, 065  say m->b_sta_with  picture '999,999.99'

   if eof()
      exit
   endif

   m->l_number += 2

   if m->l_number > 58
      do w2g0265
   endif

   m->b_gross    := 0
   m->b_fed_with := 0
   m->b_sta_with := 0

   select 3
   seek dtoc(m->hold_date)+str(m->hold_num,4)

   if eof()
      set device to screen
      @ 07,0 clear
      @ 07,0 say 'w2g0260.5: database index error. notify system programmer.'
      wait
      clear
      return (nil)
   else
      m->perf_num = batchctl->perf_num
   endif
   select 2
enddo

m->l_number += 2

if m->l_number > 58
   do w2g0265
endif

@  m->l_number, 001  say 'Report totals: '
@  m->l_number, 031  say m->rpt_gross   picture '99,999,999.99'
@  m->l_number, 049  say m->rpt_fed     picture '99,999,999.99'
@  m->l_number, 062  say m->rpt_state   picture '99,999,999.99'
eject
close databases
set device to screen
return (nil)
* eof: w2g0260.prg
