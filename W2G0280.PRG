* Program Name: W2G0280
* Author:       David M. Wysocki
* Company:      Diversified Technical Service, Inc.
* Client:       Palm Beach Kennal Club
* Purpose:      Browse Payee file by SSN.
*
function w2g0280 ()
memvar getlist
m->rec_id = space(9)
@ 10,15 say 'Enter payee social security number:'
@ 10,55 get m->rec_id picture '999999999'
read
set index to payee
set exact on
seek m->rec_id
set exact off
if eof()
   @ 12,0 clear
   @ 12,10 say 'Payee not currently on file.'
   @ 14,10 say 'Would you like to browse the payee file (y/n)?'
   m->choice = ' '
   do while .not. m->choice $'YN'
      m->choice = ' '
      @ 16,10 get m->choice picture '!'
      read
   enddo
   if m->choice = 'Y'
      do w2g0285
   else
      m->rec_id = space(09)
   endif
else
   m->l_name   = payee->last_name
   m->f_name   = payee->first_name
   m->int      = payee->middle_int
   m->address  = payee->address
   m->city     = payee->city
   m->state    = payee->state
   m->zip      = payee->zip
   m->first_id = payee->first_id
   m->scnd_id  = payee->second_id
endif
clear
return (nil)
* eof: w2g0280.prg
