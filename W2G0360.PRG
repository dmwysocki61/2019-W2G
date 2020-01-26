* Program Name: W2G0360
* Author:       David M. Wysocki
* Company:      Diversified Tech Systems, Inc.
* Client:       Palm Beach Kennel Club
* Purpose:      Display Transaction Data.
*
*
function w2g0360()
memvar getlist
clear
private r       := 2 
private g_total := 0.00
private f_total := 0.00
private s_total := 0.00

select 2

seek m->ssn

if eof()
   @ 24,0
   @ 24,0 say 'w2g0260.1: the social security number has no data!!!'
   wait
   clear
   return (nil)
endif

@  1, 1  say "SSN"
@  1,15  say "Date Won"
@  1,25  say "Gross Winnings"
@  1,40  say "Federal Witholding"
@  1,60  say "State Withholding"
 
@  2, 1  say '---------'
@  2,15  say '--------'
@  2,25  say '--------------'
@  2,40  say '------------------'
@  2,60  say '------------------'

do while ticket->record_id = m->ssn
   m->r = m->r + 2
   if m->r = 22
      wait
      @ 2,0 clear
      m->r = 2
   endif

   @  m->r,  1  say  ticket->record_id
   @  m->r, 15  say  ticket->date_won
   @  m->r, 25  say  ticket->gross      picture '999,999.99'
   @  m->r, 40  say  ticket->fed_with   picture '999,999.99'
   @  m->r,	60  say  ticket->sta_with   picture '999,999.99'
   
   m->g_total += ticket->gross
   m->f_total += ticket->fed_with
   m->s_total += ticket->sta_with

   skip
   
   if eof ()
      m->r = m->r + 2

      if m->r = 24
         @ 2,0 clear
         m->r = 2
      endif

      @ m->r, 25 say m->g_total picture '999,999.99'
      @ m->r, 40 say m->f_total picture '999,999.99'
      @ m->r, 60 say m->s_total picture '999,999.99'

      m->r = m->r + 1

      @ m->r,12 say "End of transaction data. Would you like to print? (y/n):"

      m->choice = ' '

      do while .not. m->choice $'YN'
         m->choice = ' '
         @ m->r, 69  get  m->choice picture '!'
         read
      enddo

      if m->choice = 'Y'
         do w2g0365
      endif
      return (nil)
   endif
enddo

m->r = m->r + 2

if m->r = 24
   @ 2,0 clear
   m->r = 4
endif

@ m->r, 25 say m->g_total picture '999,999.99'
@ m->r, 40 say m->f_total picture '999,999.99'
@ m->r, 60 say m->s_total picture '999,999.99'

m->r = m->r + 1

@ m->r,12 say "End of transaction data. Would you like to print? (y/n):"

m->choice = ' '

do while .not. m->choice $'YN'
   m->choice = ' '
   @ m->r, 69  get  m->choice picture '!'
   read
enddo

if m->choice = 'Y'
   do w2g0365
   return (nil)
else
   return (nil)
endif

return (nil)
