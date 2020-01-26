* Program Name: W2G0365
* Author:       David M. Wysocki
* Company:      Diversified Technical Service, Inc.
* Client:       Palm Beach Kennal Club
* Purpose:      Database Reporting - Detail Winnings Report
*
*
function w2g0365()

memvar getlist

private rec_id     := space(9)
private print_init := space(20)
private p_number   := 0
private l_number   := 0
private choice     := ' '
private g_total    := 0
private f_total    := 0
private s_total    := 0
private r_date     := date()

*set printer to c:\temp\rpt0365.txt
set device to printer

if m->laser = 'Y'
   m->printer_init := 'e(10u&l1o&l8d&l5e&l66f&k2s(s8v'
   @ 0,0 say m->printer_init
end-if

do w2g0367

seek m->ssn

do while ticket->record_id = m->ssn
   @  m->l_number,  1   say  ticket->record_id  
   @  m->l_number, 15   say  ticket->date_won
   @  m->l_number, 29   say  ticket->gross      picture '999,999.99'
   @  m->l_number, 49   say  ticket->fed_with   picture '999,999.99'
   @  m->l_number, 69   say  ticket->sta_with   picture '999,999.99'
   @  m->l_number, 80   say  ticket->trans
   @  m->l_number, 93   say  ticket->race
   @  m->l_number, 100  say  ticket->cashier
   @  m->l_number, 110  say  ticket->window

   
   m->g_total += ticket->gross
   m->f_total += ticket->fed_with
   m->s_total += ticket->sta_with
   
   skip

   if eof ()
      m->l_number = m->l_number + 2

      if m->l_number > 58
         do w2g0367
      endif

      @ m->l_number, 00 say 'Total: ' 
      @ m->l_number, 29 say m->g_total picture '999,999.99'
      @ m->l_number, 49 say m->f_total picture '999,999.99'
      @ m->l_number, 69 say m->s_total picture '999,999.99'
      return (nil)

   else

      m->l_number = m->l_number + 1

      if m->l_number > 58
         do w2g0367
      endif

   endif

enddo

m->l_number = m->l_number + 2

if m->l_number > 58
   do w2g0367
endif

@ m->l_number, 00 say 'Total: ' 
@ m->l_number, 29 say m->g_total picture '999,999.99'
@ m->l_number, 49 say m->f_total picture '999,999.99'
@ m->l_number, 69 say m->s_total picture '999,999.99'

eject

set device to screen

return (nil)
* eof w2g0235.prg
