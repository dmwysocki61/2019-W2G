* Program Name: W2G290
* Author:       David M. Wysocki
* Company:      Diversified Technical Service, Inc.
* Client:       Palm Beach Kennal Club
* Purpose:      Access PAYEE database by last name.
*
*
function w2g0290()
#define pEsc 27
memvar getlist
set index to name
m->l_name  := space(15)
m->f_name  := space(15)
m->init    := space(2)

@ 6,0  clear

@ 6,15 SAY "Enter LAST name:"
@ 7,15 SAY "Enter FIRST name:"
@ 8,15 SAY "Enter MIDDLE INITIAL:"

@ 6,40 get m->l_name  picture '!!!!!!!!!!!!!!!'
@ 7,40 get m->f_name  picture '!!!!!!!!!!!!!!!'
@ 8,40 get m->init    picture '!!'

read

if (lastkey() == pEsc)
   return(nil)
endif

do while .t.
	m->name := padr(m->l_name,25) + padr(m->f_name,12) + padr(m->init,2)
	seek m->name
	if eof()
	   do w2g0295
	   if (lastkey() == pEsc)
	      return(nil)
	   endif
	else
	   m->rec_id   = payee->record_id
	   m->l_name   = payee->last_name
	   m->f_name   = payee->first_name
	   m->int      = payee->middle_int
	   m->address  = payee->address
	   m->city     = payee->city
	   m->state    = payee->state
	   m->zip      = payee->zip
	   m->first_id = payee->first_id
	   m->scnd_id  = payee->second_id
	   exit
	endif
enddo
return (nil)
* eof: w2g0290.prg
