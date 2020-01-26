* Program Name: W2G0500
* Author:       David M. Wysocki
* Company:      Diversified Technical Service, Inc.
* Client:       Palm Beach Kennal Club
* Purpose:      PAYEE DATA INPUT MODULE - MULTIPLE WINNER
*
function w2g0500()
memvar getlist
memvar arec_id
private rec_key  := space (09)
private l_name   := space (25)
private f_name   := space (15)
private init     := space (2)
private address  := space (30)
private city     := space (25)
private state    := space (02)
private zip      := space (05)
private first_id := space (15)
private scnd_id  := space (15)
private choice   := ' '

m->b_gross  += m->tkt_gross
m->b_fed    += m->tkt_fed
m->b_state  += m->tkt_state

select 1

seek arec_id [m->index]

if eof()
   do w2g0600
   @ 11,  1  say  arec_id [m->index]
   if m->index = 1
      @  5,  1  get  m->date_won
      @  5, 16  get  m->trans
      @  5, 45  get  m->cashier   picture '9999'
      @  5, 53  get  m->window    picture '9999'
      @  5, 65  get  m->race      picture '99'
   else
      @  5,  1  say  m->date_won
      @  5, 16  say  m->trans     picture '!!!!!!!!!!'
      @  5, 45  say  m->cashier   picture '9999'
      @  5, 53  say  m->window    picture '9999'
      @  5, 65  say  m->race      picture '99'
   endif

   @ 17,  1  say  m->tkt_gross    picture '999,999.99'
   @ 17, 22  say  m->tkt_fed      picture '999,999.99'

   if m->state_tax = 'Y'
      @ 17, 43  say  m->tkt_state    picture '999,999.99'
   end-if

   @  9,  1  get  m->f_name       picture '!!!!!!!!!!!'
   @  9, 14  get  m->init         picture '!!'
   @  9, 18  get  m->l_name       picture '!!!!!!!!!!!!!!!!!!!!'
   @  9, 45  get  m->address
   @ 11, 45  get  m->city
   @ 11, 71  get  m->state        picture '!!'
   @ 12, 49  get  m->zip		  
   @ 11, 13  get  m->first_id     picture '!!!!!!!!!!!!!'
   @ 11, 27  get  m->scnd_id

   read

   if m->m_f2 = 'Y' .or. m->m_f3 = 'Y'
      m->b_gross  -= m->tkt_gross
      m->b_fed    -= m->tkt_fed
	  m->b_state  -= m->tkt_state
      clear
      return (nil)
   endif

   do w2g0610

   if m->m_f2 = 'Y' .or. m->m_f3 = 'Y'
      m->b_gross  -= m->tkt_gross
      m->b_fed    -= m->tkt_fed
	  m->b_state  -= m->tkt_state
      clear
      return (nil)
   endif

   append blank

   replace payee->record_id  with arec_id [m->index]
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

else

   if m->index = 1

      do w2g0600

      m->f_name   = payee->first_name
      m->init     = payee->middle_int
      m->l_name   = payee->last_name
      m->address  = payee->address
      m->city     = payee->city
      m->state    = payee->state
      m->zip      = payee->zip
      m->first_id = payee->first_id
      @  9,  1  say  payee->first_name
      @  9, 14  say  payee->middle_int
      @  9, 17  say  payee->last_name picture '!!!!!!!!!!!!!!!!!!!!'
      @  9, 45  say  payee->address
      @ 11,  1  say  payee->record_id
      @ 11, 45  say  payee->city
      @ 11, 71  say  payee->state
      @ 12, 49  say  payee->zip
      @ 11, 13  say  payee->first_id
      @ 11, 27  say  payee->second_id
      @ 17,  1  say  m->tkt_gross picture '999,999.99'
      @ 17, 22  say  m->tkt_fed   picture '999,999.99'
      if m->state_tax = 'Y'
   	     @ 17, 43  say  m->tkt_state picture '999,999.99'
      end-if
      @  5,  1  get  m->date_won
      @  5, 16  get  m->trans
      @  5, 45  get  m->cashier   picture '9999'
      @  5, 53  get  m->window    picture '9999'
      @  5, 65  get  m->race      picture '99'

      read
      
      if m->m_f2 = 'Y' .or. m->m_f3 = 'Y'
         m->b_gross  -= m->tkt_gross
         m->b_fed    -= m->tkt_fed
		 m->b_state  -= m->tkt_state
         clear
         return (nil)
      endif
      
      do w2g0610
      
      if m->m_f2 = 'Y' .or. m->m_f3 = 'Y'
         m->b_gross  -= m->tkt_gross
         m->b_fed    -= m->tkt_fed
		 m->b_state  -= m->tkt_state
         clear
         return (nil)
      endif
   endif
endif

select 2
append blank

replace ticket->record_id  with arec_id [m->index]
replace ticket->gross      with m->tkt_gross
replace ticket->fed_with   with m->tkt_fed
replace ticket->sta_with   with m->tkt_state
replace ticket->date_won   with m->date_won
replace ticket->trans      with m->trans
replace ticket->race       with m->race
replace ticket->cashier    with m->cashier
replace ticket->window     with m->window
replace ticket->batch_date with m->b_date
replace ticket->batch_num  with m->b_number
replace ticket->perf_num   with m->perf_num
clear
return (nil)
* eof w2g0500.prg
