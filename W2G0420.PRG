* Program Name: W2G0420
* Author:       David M. Wysocki
* Company:      Diversified Technical Service, Inc.
* Client:       Palm Beach Kennel Club
* Purpose:      TRANSACTION DATA INPUT MODULE
*
*
FUNCTION W2G0420()

memvar getlist
set escape on
set date american
set scoreboard off
private race       := 0
private cashier    := 0
private window     := 0
private ssn_format := space (11)
private rec_id     := space (09)
private trans      := space (10)
private l_name     := space (25)
private f_name     := space (15)
private init       := space (2)
private address    := space (30)
private city       := space (25)
private state      := space (02)
private zip        := space (05)
private first_id   := space (15)
private scnd_id    := space (15)
private tkt_gross  := 0.00
private tkt_fed    := 0.00
private tkt_state  := 0.00
private vld_num    := 'n'

m->choice    := ' '
m->m_f2      := 'N'
m->m_f3      := 'N'
clear

do w2g0600

@ 19,0  say 'Please enter a Taxpayer Id number.'

do while .t.

@ 11,1  get m->ssn_format picture '999-99-9999'

read

if m->m_f2 = 'Y' .or. m->m_f3 = 'Y'
   clear
   return (nil)
endif

if m->ssn_format = space(09)
   @ 19,0 clear to 19,41
   @ 19,0 Say 'Taxpayer Id is required. Please re-enter.'
   loop
else
   m->rec_id  := substr(m->ssn_format,1,3)+substr(m->ssn_format,5,2)+ ;
                 substr(m->ssn_format,8,4)
   m->vld_num := 'N'
   do editssn
   if m->vld_num = 'Y'
      exit
   else
      @ 19,0 clear to 19,41
      @ 19,0 say 'Taxpayer Id is invalid. Please re-enter.'
      loop
   end-if
end-if
enddo

@ 19,0 clear to 19,41

@ 14,  0  to 18, 79

select 1
seek m->rec_id
do while .t.
if eof()
   @ 11,  1  say  m->ssn_format
   @  5,  1  say  m->b_date    picture 'MM/DD/YY'
   @  5, 16  get  m->trans
   @  5, 45  get  m->cashier   picture '9999'
   @  5, 53  get  m->window    picture '9999'
   @  5, 65  get  m->race      picture '99'
   @  9,  1  get  m->f_name    picture '!!!!!!!!!!!'
   @  9, 14  get  m->init      picture '!!'
   @  9, 18  get  m->l_name    picture '!!!!!!!!!!!!!!!!!!!!'
   @  9, 45  get  m->address
   @ 11, 45  get  m->city
   @ 11, 71  get  m->state     picture '!!'
   @ 12, 49  get  m->zip       picture '99999'
   @ 11, 13  get  m->first_id  picture '!!!!!!!!!!!!!'
   @ 11, 27  get  m->scnd_id
   @ 21, 22  say  m->ctl_grs   picture '9,999,999.99'
   @ 22, 22  say  m->ctl_fed   picture '9,999,999.99'
   @ 21, 65  say  m->b_gross   picture '9,999,999.99'
   @ 22, 65  say  m->b_fed     picture '9,999,999.99'
   @ 17, 1   get  m->tkt_gross picture '999,999.99'
   @ 17, 22  get  m->tkt_fed   picture '999,999.99'
   if m->state_tax = 'Y'
      @ 17, 43  get  m->tkt_state picture '999,999.99'
   end-if
   read
   if m->m_f2 = 'Y' .or. m->m_f3 = 'Y'
      clear
      return (nil)
   endif
   m->b_gross += m->tkt_gross
   m->b_fed   += m->tkt_fed
   m->b_state += m->tkt_state

   @ 21, 65  say m->b_gross       picture '9,999,999.99'
   @ 22, 65  say m->b_fed         picture '9,999,999.99'

   if m->state_tax = 'Y'
      @ 23, 65  say m->b_state       picture '9,999,999.99'
   end-if

ELSE
   m->f_name   = payee->first_name
   m->l_name   = payee->last_name
   m->init     = payee->middle_int
   m->address  = payee->address
   m->city     = payee->city
   m->state    = payee->state
   m->zip      = payee->zip
   m->first_id = payee->first_id
   m->scnd_id  = payee->second_id
   @  9,  1  say  m->f_name	   picture '!!!!!!!!!!!!'
   @  9, 14  say  m->init
   @  9, 18  say  m->l_name	   picture '!!!!!!!!!!!!!!!!!!!!'
   @  9, 45  say  m->address
   @ 11,  1  say  m->ssn_format
   @ 11, 13  say  m->first_id
   @ 11, 27  say  m->scnd_id
   @ 11, 45  say  m->city
   @ 11, 71  say  m->state
   @ 12, 49  say  m->zip
   @  5,  1  say  m->b_date    picture 'MM/DD/YY'
   @  5, 16  get  m->trans
   @  5, 45  get  m->cashier   picture '9999'
   @  5, 53  get  m->window    picture '9999'
   @  5, 65  get  m->race      picture '99'
   @ 21, 22  say  m->ctl_grs   picture '9,999,999.99'
   @ 22, 22  say  m->ctl_fed   picture '9,999,999.99'

   @ 17,  1  get  m->tkt_gross picture '999,999.99'
   @ 17, 22  get  m->tkt_fed   picture '999,999.99'

   if m->state_tax = 'Y'
      @ 17, 43  get  m->tkt_state picture '999,999.99' 
   end-if

   READ

   if m->m_f2 = 'Y' .or. m->m_f3 = 'Y'
      clear
      return (nil)
   endif
   
   m->b_gross += m->tkt_gross
   m->b_fed   += m->tkt_fed
   m->b_state += m->tkt_state

   @ 21,65 say m->b_gross     picture '9,999,999.99'
   @ 22,65 say m->b_fed       picture '9,999,999.99'

   if m->state_tax = 'Y'
      @ 23,65 say m->b_state     picture '9,999,999.99'
   end-if

endif

do w2g0610

if m->m_f2 = 'Y' .or. m->m_f3 = 'Y'
   clear
   return (nil)
endif

m->choice := ' '

do while .not. m->choice$'YN'

   m->choice := ' '
   @ 19,  0  clear to 19,79
   @ 19, 0 say 'Is all of the data correct? (y/n)' get m->choice picture '!'

   read

   if m->m_f2 = 'Y' .or. m->m_f3 = 'Y'
      clear
      return (nil)
   endif

enddo

if m->choice = 'N'
   m->b_gross -= m->tkt_gross
   m->b_fed   -= m->tkt_fed

   @ 21, 65  say m->b_gross       picture '9,999,999.99'
   @ 22, 65  say m->b_fed         picture '9,999,999.99'

   if m->state_tax = 'Y'
	  m->b_state -= m->tkt_state
      @ 23, 65  say m->b_state    picture '9,999,999.99'
   end-if

   @ 19,  0  clear to 19,79

   loop

else

   exit

endif

enddo

select 2

append blank
replace ticket->record_id  with m->rec_id
replace ticket->gross      with m->tkt_gross
replace ticket->fed_with   with m->tkt_fed
replace ticket->sta_with   with m->tkt_state
replace ticket->date_won   with m->b_date
replace ticket->trans      with m->trans
replace ticket->race       with m->race
replace ticket->cashier    with m->cashier
replace ticket->window     with m->window
replace ticket->batch_date with m->b_date
replace ticket->batch_num  with m->b_number
replace ticket->perf_num   with m->perf_num

select 1

if eof()
   append blank
   replace payee->record_id  with m->rec_id
   replace payee->first_name with m->f_name
   replace payee->last_name  with m->l_name
   replace payee->middle_int with m->init
   replace payee->address    with m->address
   replace payee->city       with m->city
   replace payee->state      with m->state
   replace payee->zip        with m->zip
   replace payee->first_id   with m->first_id
   replace payee->second_id  with m->scnd_id
   replace payee->batch_date with m->b_date
   replace payee->batch_num  with m->b_number
   replace payee->perf_num   with m->perf_num
endif
clear
return (nil)
* eof w2g0420.prg
