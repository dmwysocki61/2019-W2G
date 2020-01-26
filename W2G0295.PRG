* Program Name: W2G0295
* Author:       David M. Wysocki
* Company:      Diversified Technical Service, Inc.
* Client:       Palm Beach Kennal Club
* Purpose:      Browse Payee file by last name.
*
function w2g0295()
#define pEsc 27
memvar getlist
set escape on
m->f_name := space(15)
m->init   := space(2)
m->r      := 3

clear

@  0, 20 say "Payee Database Browse"
@  02,01 say 'Payee Name'
@  02,40 say 'Payee SSN'
@  03,01 say '--------------------------------'
@  03,40 say '---------'

m->name = m->l_name

seek m->name

if eof()
   m->name = substr(m->name,1,1)
   seek m->name
   if eof()
      @ 24,0 clear
      @ 24,10 say 'w2g0295.1 - payee information not found.'
      read
      clear
      return (nil)
   endif
endif

do while substr(m->name,1,1) = substr(payee->last_name,1,1) .and. ;
   .not. eof()
   m->r = m->r+1

   if m->r = 23

      @ 23,0  clear
      @ 23,05 say "Press enter to continue or enter name exactly as displayed."
      @ 24,00 say "Last name:"
      @ 24,30 say "First name:"
      @ 24,55 say "Middle initial:"

      @ 24,10 get m->l_name         picture '!!!!!!!!!!!!!!!'
      @ 24,36 get m->f_name         picture '!!!!!!!!!!!!!!!'
      @ 24,70 get m->init           picture '!!'

      read

	  if (lastkey() == pEsc)
         return(nil)
      endif

      if m->f_name <> space(15)
         return (nil)
      endif

      @  4,0  clear

      m->r =  4

   endif

   @ m->r, 1 say ltrim(rtrim(payee->last_name))  +', '+;
                 ltrim(rtrim(payee->first_name)) +' ' +;
                 ltrim(rtrim(payee->middle_int))

   @ m->r,40 say payee->record_id

   skip
enddo

@ 23,0  clear
@ 23,0  say "End of payee's with last name beginning with same letter as name requested."

wait

@ 23,0  clear
@ 23,0  say "Please enter payee's name exactly as it is displayed."

@ 24,00 say "Last name:"
@ 24,30 say "First name:"
@ 24,55 say "Middle initial:"

@ 24,10 get m->l_name  picture '!!!!!!!!!!!!!!!'
@ 24,36 get m->f_name  picture '!!!!!!!!!!!!!!!'
@ 24,70 get m->init picture '!!'
read
return (nil)
* Eof: w2g0295.prg
