* Program Name: W2G0285
* Author:       David M. Wysocki
* Company:      Diversified Technical Service, Inc.
* Client:       Palm Beach Kennal Club
* Purpose:      Browse Payee file by last name.
*
function w2g0285()
memvar getlist
clear
m->old_id = space(9)
m->old_id = m->rec_id
m->rec_no = 0
m->first  = ' '
m->first  = substr(m->rec_id,1,1)
m->r  = 3
@  0, 20 say "Payee Database Browse"
@  02,01 say 'Payee SSN'
@  02,15 say 'Payee Name'
@  03,01 say '---------'
@  03,15 say '--------------------------------'
seek m->first
if eof()
   @ 23, 0 clear
   @ 23, 0 say 'W2G0285.1 - Payee information not found.'
   wait
   m->rec_id = space(09)
   clear
   return (nil)
endif
do while .t.
   do while substr(m->rec_id,1,1) = substr(payee->record_id,1,1) .and. ;
      .not. eof()
      m->r =m->r+1
      if m->r = 22
         m->r = 3
         m->choice = ' '
         @ 23, 0 clear
         @ 23, 0 say "W2G0285.2 - Press enter to continue or enter ssn."
         @ 24, 0 say "SSN: "
         @ 24,50 say "Enter x to exit"
         @ 24,10 get m->rec_id picture '999999999'
         @ 24,70 get m->choice picture '!'
         read
         if m->choice = 'X'
            m->rec_id = space(09)
            clear
            return (nil)
         endif
         if m->rec_id = m->old_id
            @ 4,0  clear
            loop
         else
            seek m->rec_id
            if eof()
               @ 23,0 clear
               @ 23,0 say 'W2G0285.3 - Requested record not found.'
               wait
               m->r = 3
               m->rec_id = m->old_id
               @ 4,0 clear
               goto m->rec_no
               loop
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
               return (nil)
            endif
         endif
      endif
      if m->r = 4
         m->rec_no = recno()
      endif
      @ m->r,01 say payee->record_id
      @ m->r,15 say ltrim(rtrim(payee->last_name))  +', '+    ;
                    ltrim(rtrim(payee->first_name)) +' ' +    ;
                    ltrim(rtrim(payee->middle_int))
      skip
   enddo
   m->choice = ' '
   @ 23,0  clear
   @ 23,0  say "W2G0285.4 - End of payee's with SSN beginning with same digit as SSN selected."
   wait
   @ 23,0  clear
   @ 23,0  say "w2g0285.5 - Enter payee's SSN exactly as displayed."
   @ 24,0  say "SSN: "
   @ 24,50 say "Enter X to exit"
   @ 24,10 get m->rec_id picture '999999999'
   @ 24,70 get m->choice picture '!'
   read
   if m->choice = 'X'
      m->rec_id = space(09)
      clear
      return (nil)
   endif
   seek m->rec_id
   if eof()
      @ 23,0 clear
      @ 23,0 say 'W2G0285.6 - Requested record not found.'
      wait
      m->r = 3
      m->rec_id = m->old_id
      goto m->rec_no
      @ 4,0 clear
      loop
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
      return (nil)
   endif
enddo
return (nil)
* eof: w2g0285.prg
