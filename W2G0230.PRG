* Program Name: W2G0230
* Author:       David M. Wysocki
* Company:      Diversified Technical Service, Inc.
* Client:       Palm Beach Kennal Club
* Purpose:      Database Reporting - Report by SSN - Detail Listing
*
*
function w2g0230()
memvar getlist
set escape on
private rec_id     := space(9)
private gross      := 0
private fed_with   := 0
private sta_with   := 0
private ytd_gross  := 0
private ytd_fed    := 0
private ytd_state  := 0
private tkt_count  := 0
private p_number   := 0
private r          := 4
private choice     := ' '

clear

@ 0 ,20 say "Report by Social Security Number"
@ 02,20 say "D - detail listing"
@ 03,20 say "S - summary listing"
@ 04,20 say "X - exit"

@ 05,20 get  m->choice picture '!'

read

do while .not. m->choice$'DSX'
   m->choice := ' '
   @ 05,20 get m->choice
   read
enddo

if m->choice = 'X'
   clear
   return (nil)
endif

select 2
goto top
select 1
goto top

* set printer to c:\temp\w2g0230.rpt

if m->choice = 'S'
   do w2g0235
   return (nil)
endif
clear

m->time := space(8)
m->time := time()

@ 1,15 say 'Report start time: ' + m->time
@ 3,15 say 'Creating report. One moment please.'

set device to printer

m->printer_init := 'e(10u&l1o&l8d&l5e&l66f&k2s(s8v'
@ 0,0 say m->printer_init

do w2g0232

select 1

do while .not. eof()

   m->rec_id = payee->record_id

   @m->l_number, 00  say payee->record_id

   if payee->middle_int = ' '
      @m->l_number, 10  say ltrim(rtrim(payee->last_name))  + ', ' + ;
			   ltrim(rtrim(payee->first_name))
   else
      @m->l_number, 10  say ltrim(rtrim(payee->last_name))  + ', ' + ;
			   ltrim(rtrim(payee->first_name)) + ' '  + ;
			   ltrim(rtrim(payee->middle_int))
   endif

   @m->l_number, 45  say payee->address

   select 2

   seek m->rec_id

   if eof()

   else
      m->loop_cnt := 1

      do while m->rec_id = ticket->record_id .and. .not. eof()

         ++m->loop_cnt 
         ++m->tkt_count 

         m->gross      += ticket->gross
         m->fed_with   += ticket->fed_with
         m->sta_with   += ticket->sta_with

         m->ytd_gross  += ticket->gross
         m->ytd_fed    += ticket->fed_with
         m->ytd_state  += ticket->sta_with

         @  m->l_number, 077 say ticket->date_won
         @  m->l_number, 087 say ticket->perf_num picture '9999'
         @  m->l_number, 095 say ticket->cashier  picture '9999'
         @  m->l_number, 105 say ticket->gross    picture '999,999.99'
         @  m->l_number, 121 say ticket->fed_with picture '999,999.99'
         @  m->l_number, 136 say ticket->sta_with picture '999,999.99'

         m->l_number := m->l_number + 1

         if m->l_number > 56
	        do w2g0232
	        select 2
         endif

         if m->loop_cnt = 2
	        @  m->l_number, 45  say ltrim(rtrim(payee->city)) + ', ' + ;
                                                    payee->state  + ' '  + ;
					            payee->zip
         endif
         skip
      enddo

      @  m->l_number, 085  say 'Payee totals: '
      @  m->l_number, 105  say m->gross            picture '999,999.99'
      @  m->l_number, 121  say m->fed_with         picture '999,999.99'
      @  m->l_number, 136  say m->sta_with         picture '999,999.99'
      
      m->gross    := 0
      m->fed_with := 0
      m->sta_with := 0
      
   end-if

   select 1

   skip
   m->l_number := m->l_number + 2

   if m->l_number > 56 .and. .not. eof()
      do w2g0232
      select 1
   endif
enddo

m->l_number = m->l_number + 2

if m->l_number > 56 .and. .not. eof()
   do w2g0232
endif

@  m->l_number, 001  say 'YTD Totals:'
@  m->l_number, 015  say 'Ticket Count'
@  m->l_number, 030  say m->tkt_count   picture '999,999'
@  m->l_number, 102  say m->ytd_gross   picture '99,999,999.99'
@  m->l_number, 118  say m->ytd_fed     picture '99,999,999.99'
@  m->l_number, 133  say m->ytd_state   picture '99,999,999.99'

eject

set device to screen

@ 5,15 say 'Report complete.'

m->time := time()

@ 7,15 say 'Report end time: ' + m->time

wait

return (nil)
* eof w2g0230.prg
