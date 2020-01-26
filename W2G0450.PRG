* Program Name: W2G0450
* Author:       David M. Wysocki
* Company:      Diversified Technical Service, Inc.
* Client:       Palm Beach Kennal Club
* Purpose:      Transaction Update Module.
*

function w2g0450()

memvar getlist

set escape on
set date american

private rec_id     := space (9)
private ssn_format := space(11)
private key_value  := space(21)

m->choice := ' '
m->m_f2   := 'N'
m->m_f3   := 'N'

do w2g0600

@ 19,  0  say 'Please enter a Taxpayer Id number.'

do while .t.
   @ 11,  1  get m->ssn_format picture '999-99-9999'

   read

   if m->m_f2 = 'Y' .or. m->m_f3 = 'Y'
      clear
      return (nil)
   endif

   m->rec_id := substr(m->ssn_format,1,3)+substr(m->ssn_format,5,2)+ ;
		        substr(m->ssn_format,8,4)

   select 2
   set index to batchid

   key_value := dtoc(m->b_date)+str(m->b_number,4)+m->rec_id

   seek key_value

   if eof()
      @ 19,  0  say  space (42)
      @ 19,  0  SAY  'Taxpayer not found in current batch. Please try again.'
      loop
   else
      exit
   endif
enddo

@ 14,  0  to 18, 79

do while ticket->record_id  = m->rec_id   .and. ;
         ticket->batch_date = m->b_date   .and.	;
         ticket->batch_num  = m->b_number
         
   m->date_won  = date()
   m->race      = 0
   m->cashier   = 0
   m->window    = 0
   m->choice    = ' '
   m->vld_num   = ' '
   m->trans     = space (10)
   m->l_name    = space (25)
   m->f_name    = space (12)
   m->init      = space (2)
   m->address   = space (30)
   m->city      = space (25)
   m->state     = space (2)
   m->zip       = space (5)
   m->first_id  = space (15)
   m->scnd_id   = space (15)
   m->tkt_gross = 0.00
   m->tkt_fed   = 0.00
   m->tkt_state = 0.00
   m->tkt_gross = ticket->gross
   m->tkt_fed   = ticket->fed_with
   m->tkt_state = ticket->sta_with
   m->date_won  = ticket->date_won
   m->trans     = ticket->trans
   m->race      = ticket->race
   m->cashier   = ticket->cashier
   m->window    = ticket->window

   select 1
   seek m->rec_id
   if eof()
      clear
      set escape on
      @ 14, 0 say 'W2G0450.1:Payee data not found for: ' + M->REC_ID
      quit
   endif

   m->f_name   = payee->first_name
   m->l_name   = payee->last_name
   m->init     = payee->middle_int
   m->address  = payee->address
   m->city     = payee->city
   m->state    = payee->state
   m->zip      = payee->zip
   m->first_id = payee->first_id
   m->scnd_id  = payee->second_id
   @  5,  1  get  m->date_won
   @  5, 16  get  m->trans
   @  5, 45  get  m->cashier    picture '9999'
   @  5, 53  get  m->window     picture '9999'
   @  5, 65  get  m->race       picture '99'
   @  9,  1  get  m->f_name     picture '!!!!!!!!!!!!'
   @  9, 14  get  m->init       picture '!!'
   @  9, 17  get  m->l_name     picture '!!!!!!!!!!!!!!!!!!!!!!!!!'
   @  9, 45  get  m->address
   @ 11, 45  get  m->city
   @ 11, 71  get  m->state      picture '!!'
   @ 12, 49  get  m->zip
   @ 11,  1  get  m->ssn_format picture '999-99-9999'
   @ 11, 13  get  m->first_id
   @ 11, 27  get  m->scnd_id

   @ 21, 22  say m->ctl_grs picture '9,999,999.99'
   @ 22, 22  say m->ctl_fed picture '9,999,999.99'
   @ 21, 65  say m->b_gross picture '9,999,999.99'
   @ 22, 65  say m->b_fed   picture '9,999,999.99'

   if m->state_tax = 'Y'
      @23,22 say m->ctl_sta picture '9,999,999.99'
      @23,65 say m->b_state picture '9,999,999.99'
   end-if

   m->b_gross -= ticket->gross
   m->b_fed   -= ticket->fed_with
   m->b_state -= ticket->sta_with


   @ 17, 01  get m->tkt_gross     picture '999,999.99'
   @ 17, 22  get m->tkt_fed       picture '999,999.99'

   if m->state_tax = 'Y'
      @17,43 get m->tkt_state     picture '999,999.99'
   end-if
   
   read

   if m->m_f2 = 'Y' .or. m->m_f3 = 'Y'
      clear
      return (nil)
   endif
   
   m->rec_id := substr(m->ssn_format,1,3)+substr(m->ssn_format,5,2)+ ;
         		substr(m->ssn_format,8,4)

   m->b_gross += m->tkt_gross
   m->b_fed   += m->tkt_fed
   m->b_state += m->tkt_state

   do w2g0610

   if m->m_f2 = 'Y' .or. m->m_f3 = 'Y'
      clear
      return (nil)
   endif

   @ 21,65  say m->b_gross          picture '9,999,999.99'
   @ 22,65  say m->b_fed            picture '9,999,999.99'

   if m->state_tax = 'Y'
      @ 23,65 say m->b_state        picture '9,999,999.99'
   end-if

   @ 19, 0  clear to 19,79
   @ 19, 0  say 'Update complete. Press any key to continue.'

   m->i=0

   do while m->i=0
      m->i=inkey()
   enddo

   select 1
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

   select 2
   replace ticket->record_id  with m->rec_id
   replace ticket->gross      with m->tkt_gross
   replace ticket->fed_with   with m->tkt_fed
   replace ticket->sta_with   with m->tkt_state
   replace ticket->date_won   with m->date_won
   replace ticket->trans      with m->trans
   replace ticket->race       with m->race
   replace ticket->cashier    with m->cashier
   replace ticket->window     with m->window
   skip
enddo
clear
return (nil)
* eof w2g0450.prg
