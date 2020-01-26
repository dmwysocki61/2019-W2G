* Program Name: W2G0401
* Author:       David M. Wysocki
* Company:      Diversified Technical Services, Inc.
* Client:       Palm Beach Kennel Club
* Purpose:      MULTIPLE WINNER SPLIT BY AMOUNT. EDIT TICKET TOTALS
*
function w2g0401()   

memvar getlist
* memvar tkt_gross   
* memvar tkt_fed
* memvar m_f2
* memvar m_f3
memvar l
memvar choice

do while m->tkt_gross = 0
   @ 22,0 clear to 22,79
   @ 22,10 SAY "GROSS amount must be greater than 0."
   @  2,45 get  m->tkt_gross  picture '9,999,999.99'
   read
   IF M->M_F2 = 'Y' .OR. M->M_F3 = 'Y'
      clear
      return (nil)
   endif
enddo

do while m->tkt_gross > 5000 .and. m->tkt_fed = 0.00
   @ 21,0  clear to 23,79
   @ 21,10 say "Federal Withholding Amount should be greater than 0."
   @ 22,10 say "Would you like to enter the withholding? (y or n)"

   m->choice = ' '

   do while .not. m->choice$'YN'

      m->choice = ' '

      @ 22,65 get m->choice picture '!'

      read

      if m->m_f2 = 'Y' .or. m->m_f3 = 'Y'
         clear
         return (nil)
      endif

   enddo

   if m->choice = 'Y'
      @ 21, 0 clear to 23,79
      @  4,45 get  m->tkt_fed   picture '9,999,999.99'
      read

      if m->m_f2 = 'Y' .or. m->m_f3 = 'Y'
         clear
         return (nil)
      endif

   else
      exit
   endif

enddo

if m->state_tax = 'Y'
	do while m->tkt_gross > 5000 .and. m->tkt_state = 0.00
	   @ 21,0  clear to 23,79
	   @ 21,10 say "State Withholding Amount should be greater than 0."
	   @ 22,10 say "Would you like to enter the withholding? (y or n)"

	   m->choice = ' '

	   do while .not. m->choice$'YN'

	      m->choice = ' '

	      @ 22,65 get m->choice picture '!'

	      read

	      if m->m_f2 = 'Y' .or. m->m_f3 = 'Y'
	         clear
	         return (nil)
	      endif

	   enddo

	   if m->choice = 'Y'

	      @ 21, 0 clear to 23,79
	      @  6,45 get  m->tkt_state   picture '9,999,999.99'
	   
	      read

	      if m->m_f2 = 'Y' .or. m->m_f3 = 'Y'
	         clear
	         return (nil)
	      endif

	   else
	      exit
	   endif

	enddo
endif

return (nil)
* eof w2g0401.prg
