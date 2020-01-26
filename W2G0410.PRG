* Program Name: W2G0410
* Author:       David M. Wysocki
* Company:      Diversified Technical Service, Inc.
* Client:       Palm Beach Kennal Club
* Purpose:      MULTIPLE WINNER SPLIT BY PERCENTAGE.
*
*
function w2g0410()
memvar getlist
set escape on
set date american
clear
private tkt_gross := 0
private tkt_fed   := 0
private tkt_state := 0
private trans     := space (10)
private date_won  := date()
private cashier   := 0
private window    := 0
private race      := 0
private tot_gross := 0
private tot_fed   := 0
private tot_state := 0
private tot_prcnt := 0.00
private rec_id    := space (9)
private choice    := ' '
private l         := 12
private r         := 0
private index     := 1
private arec_id   := {}
private apercent  := {}
private agross    := {}
private afed_with := {}
private asta_with := {}

asize (arec_id,m->payees)
asize (apercent,m->payees)
asize (agross,m->payees)
asize (afed_with,m->payees)
asize (asta_with,m->payees)

afill (arec_id,space(9))
afill (apercent,0.00)
afill (agross,0.00)
afill (afed_with,0.00)
afill (asta_with,0.00)

clear

@  0, 15  SAY "Multiple Winner Entry - Split By Percentage"
@  2, 10  SAY "Enter Gross Amount of Ticket:"
@  4, 10  SAY "Enter Federal Withholding Amount of Ticket:"

if m->state_tax = 'Y'
   @ 6, 10 say "Enter State Withholding Amount of Ticket:"
end-if

m->choice = 'N'

do while m->choice = 'N'

   @  7,  0  clear
   @  2, 55  get  m->tkt_gross picture '9,999,999.99'
   @  4, 55  get  m->tkt_fed   picture '9,999,999.99'

   if m->state_tax = 'Y'
      @  6, 55 get m->tkt_state picture '9,999,999.99'
   end-if

   read

   do while m->tkt_gross = 0
      @  2,55 get  m->tkt_gross picture '9,999,999.99'
      @ 24, 0 clear
      @ 24,10 SAY "GROSS amount must be greater than 0."
      read
   enddo

   do while m->tkt_gross > 5000 .and. m->tkt_fed = 0
      @ 23, 0 clear
      @ 23, 0 SAY "FEDERAL WITHOLDING amount should be greater than 0."
      @ 24, 0 SAY "Would you like to override the withholding? (Y or N)"
   
      m->choice = ' '
   
      do while .not. m->choice$'YN'
         m->choice = ' '
         @ 24,55 get m->choice picture '!'
         read
      enddo

      if m->choice = 'N'
         @ 23,  0 clear
         @  4, 55 get  m->tkt_fed   picture '9,999,999.99'
         read
      else
         exit
      endif
   enddo

   if m->state_tax = 'Y'
	  do while m->tkt_gross > 5000 .and. m->tkt_state = 0
	      @ 23, 0 clear
	      @ 23, 0 SAY "State Withholding amount should be greater than 0."
	      @ 24, 0 SAY "Would you like to override the withholding? (Y or N)"
	   
	      m->choice = ' '
	   
	      do while .not. m->choice$'YN'
	         m->choice = ' '
	         @ 24,55 get m->choice picture '!'
	         read
	      enddo

	      if m->choice = 'N'
	         @ 23,  0 clear
	         @  6, 55 get  m->tkt_state   picture '9,999,999.99'
	         read
	      else
	         exit
	      endif
	   enddo
   end-if

   @ 8, 0 clear
   @ 8,10 SAY "Are the above totals correct (Y OR N)?"

   m->choice = ' '

   do while .not. m->choice$'YN'
      m->choice = ' '
      @ 8,64 get m->choice picture '!'
      read
   enddo

enddo

@  8, 0   clear
@  9, 00  say "Taxpayer    Percentage       Gross         Federal Withholding"
@ 10, 00  say "Id Number   of Winnings      Amount        Amount"

if m->state_tax = 'Y'
   @  9,64 say "State Withholding"
   @ 10,64 say "Amount"
end-if

do while .t.

   do while m->index <= m->payees

      @  m->l, 00  get  arec_id     [m->index] picture '999999999'
      @  m->l, 13  get  apercent    [m->index] picture '9999'

      read

      do while apercent [m->index] = .00
         @  m->l, 13  get  apercent [m->index]   picture '9999'
         @ 24,  0  clear
         @ 24,  0  SAY "PERCENTAGE OF WINNINGS must be entered. Please try again."
         read
         loop
      enddo

      agross    [m->index] := m->tkt_gross * (apercent  [m->index] / 100)
      afed_with [m->index] := m->tkt_fed   * (apercent  [m->index] / 100)
      asta_with [m->index] := m->tkt_state * (apercent  [m->index] / 100)

      m->tot_gross         += agross    [m->index]
      m->tot_fed           += afed_with [m->index]
      m->tot_state	   += asta_with [m->index]
      
      m->tot_prcnt         += (apercent  [m->index] / 100)

      @ m->l,30 say agross    [m->index]        picture '9,999,999.99'
      @ m->l,47 say afed_with [m->index]        picture '9,999,999.99'

      if m->state_tax = 'Y'
         @m->l,64 say asta_with [m->index]      picture '9,999,999.99'
      end-if

      ++m->index
      ++m->l

   enddo

   if m->tot_prcnt <> 1.00
      @  m->l,12 say m->tot_prcnt picture '99.9999'
      @ 23,0 clear
      @ 24,0 say 'Percentages Entered must Total 1.00. Please try again.'
      m->index     := 1
      m->l         := 12
      m->tot_gross := 0
      m->tot_fed   := 0
	  m->tot_state := 0
      m->tot_prcnt := 0
      loop
   endif

   @ m->l,12 say m->tot_prcnt      picture '99.9999'
   @ m->l,30 say m->tot_gross      picture '9,999,999.99'
   @ m->l,47 say m->tot_fed        picture '9,999,999.99'

   if m->state_tax = 'Y'
      @ m->l,64 say m->tot_state   picture '9,999,999.99'
   end-if

   m->l += 2
   @ m->l, 0 clear

   @ M->L,10 SAY 'Are the above totals correct (Y or N)?'

   m->choice = ' '

   do while .not. m->choice$'YN'
      m->choice = ' '
      @ m->l,60 get m->choice picture '!'
      read
   enddo

   if m->choice = 'Y'
      exit
   else
      afill(agross,0)
      afill(afed_with,0)
      afill(asta_with,0)
      afill(apercent,0)
	
      m->tot_gross := 0
      m->tot_fed   := 0
	  m->tot_state := 0
      m->tot_prcnt := 0
      m->index     := 1
      m->l         := 12
      loop
   endif
enddo

m->choice := ' '
m->index  := 1

do while m->index <= m->payees
   m->tkt_gross := agross    [m->index]
   m->tkt_fed   := afed_with [m->index]
   m->tkt_state := asta_with [m->index]

   do w2g0500
   
   if m->choice = 'x'
      clear
      return (nil)
   end-if
   
   ++m->index

enddo

clear

return (nil)
* eof w2g0410.prg
