* Program Name: W2G0400
* Author:       David M. Wysocki
* Company:      Diversified Technical Services, Inc.
* Client:       Palm Beach Kennel Club
* Purpose:      MULTIPLE WINNER SPLIT BY AMOUNT.
*
function w2g0400()
memvar getlist

set escape on
set date american

private trans        := space (10)
private date_won     := date ()
private cashier      := 0
private window       := 0
private race         := 0
private tkt_gross    := 0
private tkt_fed      := 0
private tkt_state    := 0
private tot_gross    := 0
private tot_fed      := 0
private tot_state    := 0
private rec_id       := space (9)
private index        := 1
private choice       := ' '
private arec_id      := {}
private agross       := {}
private afed_with    := {}
private asta_with    := {}

asize (arec_id,m->payees)
asize (agross,m->payees)
asize (afed_with,m->payees)
asize (asta_with,m->payees)

afill (arec_id,space(9))
afill (agross,0.00)
afill (afed_with,0.00)
afill (asta_with,0.00)

clear

@  0, 20  say "Multiple Winner Entry - Split by Amount"
@  2, 10  say "Enter Gross Amount:"
@  4, 10  say "Enter Federal Withholding Amount:"

if m->state_tax = 'Y'
   @ 6,10 say "Enter State Withholding Amount:"
endif

@ 24, 10  say "F2:->Clear trans. F3:->Exit trans input."

m->choice = 'N'

do while m->choice = 'N'
   @  2, 45  get  m->tkt_gross  picture '9,999,999.99'
   @  4, 45  get  m->tkt_fed    picture '9,999,999.99'

   if m->state_tax = 'Y'
      @ 6,45 get m->tkt_state   picture '9,999,999.99'
   endif

   read
   
   if m->m_f2 = 'Y' .or. m->m_f3 = 'Y'
      clear
      return (nil)
   endif

* Call data editing routine

   do w2g0401

   if m->m_f2 = 'Y' .or. m->m_f3 = 'Y'
      clear
      return (nil)
   endif

* Allow user opportunity to correct data

   @ 7, 0 clear to 23,79
   @ 8,10 say "Are the above totals correct (Y OR N)?"

   m->choice = ' '

   do while .not. m->choice$'YN'
      m->choice = ' '
      @ 8,49 get m->choice picture '!'
      
      read
      
      if m->m_f2 = 'Y' .or. m->m_f3 = 'Y'
         clear
         return (nil)
      endif
   enddo

   if m->choice = 'Y'
      exit
   else
      @ 7,0 clear to 23,79
   endif
enddo

if m->state_tax = 'Y'
	@  8,0 CLEAR TO 23,79
	@  8, 10  SAY "WINNER'S    GROSS            FEDERAL WITHHOLDING  STATE WITHHOLDING"
	@  9, 10  SAY "SSN         AMOUNT           AMOUNT               AMOUNT"
else
	@  8,0 CLEAR TO 23,79
	@  8, 10  SAY "WINNER'S    GROSS            FEDERAL WITHHOLDING"
	@  9, 10  SAY "SSN         AMOUNT           AMOUNT"
end-if

m->index := 1
m->l     := 10

do while .t.
   do while m->index <= m->payees

	  if m->state_tax = 'Y'
	     @  M->L, 10  GET  aREC_ID  [M->INDEX] PICTURE '999999999'
	     @  M->L, 22  GET  aGROSS   [M->INDEX] PICTURE '9,999,999.99'
	     @  M->L, 40  GET  aFED_WITH[M->INDEX] PICTURE '9,999,999.99'
	     @  M->L, 60  GET  aSTA_WITH[M->INDEX] PICTURE '9,999,999.99'
	  else
	     @  M->L, 10  GET  aREC_ID  [M->INDEX] PICTURE '999999999'
	     @  M->L, 22  GET  aGROSS   [M->INDEX] PICTURE '9,999,999.99'
	     @  M->L, 40  GET  aFED_WITH[M->INDEX] PICTURE '9,999,999.99'
	  endif

      READ

      IF M->M_F2 = 'Y' .OR. M->M_F3 = 'Y'
         CLEAR
         RETURN (NIL)
      ENDIF

* Call data editing routine   
      do w2g0405

      if m->m_f2 = 'Y' .or. m->m_f3 = 'Y'
         clear
         return (nil)
      endif
* Add individual amounts to totals to check for footing total errors

      m->tot_gross += agross    [m->index]
      m->tot_fed   += afed_with [m->index]
	  m->tot_state += asta_with [m->index]

      ++m->l     
      ++m->index 
   enddo

   @ m->l,05 say "Totals:"
   
   if m->state_tax = 'Y'
      @ m->l,22 say m->tot_gross    picture '9,999,999.99'
      @ m->l,40 say m->tot_fed      picture '9,999,999.99'
	  @ m->l,60 say m->tot_state    picture '9,999,999.99'
   else
      @ m->l,22 say m->tot_gross    picture '9,999,999.99'
      @ m->l,40 say m->tot_fed      picture '9,999,999.99'
   endif

   m->comp1 := space(10)
   m->comp2 := space(10)
   m->comp3 := space(10)
   m->comp4 := space(10)
   m->comp5 := space(10)
   m->comp6 := space(10)

   m->comp1 = str(m->tot_gross,10,2)
   m->comp2 = str(m->tkt_gross,10,2)

   m->comp3 = str(m->tot_fed,10,2)
   m->comp4 = str(m->tkt_fed,10,2)

   m->comp5 = str(m->tot_state,10,2)
   m->comp6 = str(m->tkt_state,10,2)

   if m->comp1 = m->comp2 .and. m->comp3 = m->comp4 .and. m->comp5 = m->comp6

      m->choice := ' '
      ++m->l
      @ m->l,05 say 'Are the above totals correct (Y or N)?'
      
      do while .not. m->choice$'YN'
         m->choice = ' '
         @ m->l,45 get m->choice picture '!'
      
         read
      
         if m->m_f2 = 'Y' .or. m->m_f3 = 'Y'
            clear
            return (nil)
         endif
      enddo
      
      if m->choice = 'Y'
         exit
      else 
         @ m->l,0  clear to 23,79
         m->index     := 1
         m->l         := 10
         m->tot_gross := 0.00
         m->tot_fed   := 0.00
		 m->tot_state := 0.00
         loop
      endif
   else
      @ 21,0  clear to 22,79
      @ 22,10 say 'Sum of individual amounts must equal the totals for the ticket.'
      m->index       := 1
      m->l           := 10
      m->tot_gross   := 0.00
      m->tot_fed     := 0.00
	  m->tot_state   := 0.00
   endif
enddo

m->choice := ' '
m->index  := 1

do while m->index <= m->payees 
   m->tkt_gross  =  agross    [m->index]
   m->tkt_fed    =  afed_with [m->index]
   m->tkt_state  =  asta_with [m->index]

   do w2g0500

   if m->m_f2 = 'Y' .or. m->m_f3 = 'Y'
      clear
      return (nil)
   endif

   ++m->index

enddo
clear
return (nil)
* eof w2g0400.prg
