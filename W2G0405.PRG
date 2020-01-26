* Program Name: W2G0405
* Author:       David M. Wysocki
* Company:      Diversified Technical Services, Inc.
* Client:       Palm Beach Kennel Club
* Purpose:      MULTIPLE WINNER SPLIT BY AMOUNT EDIT ROUTINE
*
function w2g0405()      
memvar getlist
MEMVAR aGROSS
MEMVAR aFED_WITH
memvar aSta_With
memvar index
memvar m_f2
memvar m_f3
memvar l

* Edit Gross Winnings amount entered.

do while agross [m->index] = 0.00
   @ 22,0  clear to 22,79
   @ 22,10 say 'Gross Winnings amount must be entered. Please try again.'
   @  m->l,22 get  agross [m->index] picture '9,999,999.99'
   read
   IF M->M_F2 = 'Y' .OR. M->M_F3 = 'Y'
      CLEAR
      RETURN (NIL)
   ENDIF
   @ 22,0  CLEAR TO 22,79
ENDDO
      
* Edit Federal Withholding when winnings greater than $5,000.00      

DO WHILE aGROSS [M->INDEX] > 5000.00 .AND. aFED_WITH [M->INDEX] = 0.00
   @ 21,0  CLEAR TO 23,79
   @ 21,10 SAY 'FEDERAL WITHHOLDING should be entered.'
   @ 22,10 SAY 'Would you like to enter the withholding? (Y OR N)'
   M->CHOICE = ' '
   DO WHILE .NOT. M->CHOICE$'YN'
      M->CHOICE = ' '
      @ 22,65 GET M->CHOICE PICTURE '!'
      READ
      IF M->M_F2 = 'Y' .OR. M->M_F3 = 'Y'
         CLEAR
         RETURN (NIL)
      ENDIF
   ENDDO
   IF M->CHOICE = 'Y'
      @  M->L,40 GET aFED_WITH[M->INDEX] PICTURE '9,999,999.99'
      READ
      IF M->M_F2 = 'Y' .OR. M->M_F3 = 'Y'
         CLEAR
         RETURN (NIL)
      ENDIF
   END-IF
ENDDO

* ALLOW OPTIONAL ENTRY OF FEDERAL WITHHOLDING WHEN NOT REQUIRED
      
DO WHILE aFED_WITH [M->INDEX] = 0.00
   @ 21,0  CLEAR TO 23,79
   @ 21,10 SAY 'Would you like to enter Federal withholding? (Y OR N)'
   M->CHOICE = ' '
   DO WHILE .NOT. M->CHOICE$'YN'
      M->CHOICE = ' '
      @ 21,65 GET M->CHOICE PICTURE '!'
      READ
      IF M->M_F2 = 'Y' .OR. M->M_F3 = 'Y'
         CLEAR
         RETURN (NIL)
      ENDIF
   ENDDO
   IF M->CHOICE = 'Y'
      @  M->L,40 GET aFED_WITH [M->INDEX] PICTURE '9,999,999.99'
      READ
      IF M->M_F2 = 'Y' .OR. M->M_F3 = 'Y'
         CLEAR
         RETURN (NIL)
      ENDIF
   ELSE
      EXIT
   ENDIF
ENDDO

* Edit State Withholding when winnings greater than $5,000.00      

if m->state_tax = 'Y'
	do while agross [m->index] > 5000.00 .and. asta_with [m->index] = 0.00
	   @ 21,0  clear to 23,79
	   @ 21,10 say 'State Withholding should be entered.'
	   @ 22,10 say 'Would you like to enter the withholding? (y or n)'
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
	      @  m->l,60 get asta_with[m->index] picture '9,999,999.99'
	      read
	      if m->m_f2 = 'Y' .or. m->m_f3 = 'Y'
	         clear
	         return (nil)
	      endif
	   end-if
	enddo

	* allow optional entry of state withholding when not required
	      
	do while asta_with [m->index] = 0.00
	   @ 21,0  clear to 23,79
	   @ 21,10 say 'Would you like to enter State Withholding? (y or n)'
	   m->choice = ' '
	   do while .not. m->choice$'YN'
	      m->choice = ' '
	      @ 21,65 get m->choice picture '!'
	      read
	      if m->m_f2 = 'Y' .or. m->m_f3 = 'Y'
	         clear
	         return (nil)
	      endif
	   enddo
	   if m->choice = 'Y'
	      @  m->l,60 get asta_with [m->index] picture '9,999,999.99'
	      read
	      if m->m_f2 = 'Y' .or. m->m_f3 = 'Y'
	         clear
	         return (nil)
	      endif
	   else
	      exit
	   endif
	enddo
end-if
RETURN (NIL)
* EOF W2g0405.PRG
