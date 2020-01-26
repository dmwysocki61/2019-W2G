* Program Name: W2G0610
* Author:       David M. Wysocki
* Company:      Diversified Technical Services, Inc.
* Client:       Palm Beach Kennel Club
* Purpose:      DATA EDITING MODULE.
*
function w2g0610()

memvar getlist

do while m->f_name = space(15)
   @ 19,0 clear to 19,79
   @ 19,0 say "First name must be entered."
   @  9,1 get  m->f_name   picture '!!!!!!!!!!!!'
   read
   if m->m_f2 = 'Y' .or. m->m_f3 = 'Y'
      clear
      return (nil)
   endif
enddo

do while m->l_name = space(25)
   @ 19,0  clear to 19,79
   @ 19,0  say "Last name must be entered."
   @  9,18 get  m->l_name  picture '!!!!!!!!!!!!!!!!!!!!!!!!!'
   read
   if m->m_f2 = 'Y' .or. m->m_f3 = 'Y'
      clear
      return (nil)
   endif
enddo

do while m->address = space(30)
   @ 19,0  clear to 19,79
   @ 19,0  say "Address must be entered."
   @ 09,45 get  m->address
   read
   if m->m_f2 = 'Y' .or. m->m_f3 = 'Y'
      clear
      return (nil)
   endif
enddo

do while m->city = space(25)
   @ 19,0  clear to 19,79
   @ 19,0  say "City must be entered."
   @ 11,45 get  m->city
   read
   if m->m_f2 = 'Y' .or. m->m_f3 = 'Y'
      clear
      return (nil)
   endif
enddo

do while m->state = space(2)
   @ 19,0  clear to 19,79
   @ 19,0  say "State must be entered."
   @ 11,71 get  m->state picture '!!'
   read
   if m->m_f2 = 'Y' .or. m->m_f3 = 'Y'
      clear
      return (nil)
   endif
enddo

do while .t.
   m->r = 1
   do while m->r < 5 .or. m->r = 5
      if substr(m->zip,m->r,1) = '0'
	     m->r = m->r + 1
	     loop
      else
	     if val(substr(m->zip,m->r,1)) = 0
	        exit
	     else
	        m->r = m->r + 1
	        loop
	     endif
      endif
   enddo

   if m->r > 5
      exit
   else
      @ 19,0  clear to 19,79
      @ 19,0   say "Zip code must be numeric."
      @ 12,49  get  m->zip
      read
      if m->m_f2 = 'Y' .or. m->m_f3 = 'Y'
	 clear
	 return (nil)
      endif
      loop
   endif
enddo

do while m->tkt_gross < 0
   @ 19,0  clear to 19,79
   @ 19,0  say 'Gross winnings must be a positive number.'
   @ 17,1 get m->tkt_gross             picture '999,999.99'
   read
   if m->m_f2 = 'Y' .or. m->m_f3 = 'Y'
      clear
      return (nil)
   endif
   m->b_gross += m->tkt_gross
   @ 21, 65  say  m->b_gross   picture '9,999,999.99'
enddo

do while m->tkt_gross = 0
   @ 19,0  clear to 19,79
   @ 19,0  say 'Gross winnings must be entered.'
   @ 17,1 get m->tkt_gross             picture '999,999.99'
   read
   if m->m_f2 = 'Y' .or. m->m_f3 = 'Y'
      clear
      return (nil)
   endif
   m->b_gross += m->tkt_gross
   @ 21, 65  say  m->b_gross   picture '9,999,999.99'
enddo

do while m->tkt_fed < 0
   @ 19,0  clear to 19,79
   @ 19,0   say 'Federal withholding must be a positive number.'
   @ 17,22  get m->tkt_fed              picture '999,999.99'
   read
   if m->m_f2 = 'Y' .or. m->m_f3 = 'Y'
      clear
      return (nil)
   endif
   m->b_fed += m->tkt_fed
   @ 22, 65  say  m->b_fed     picture '9,999,999.99'
enddo

do while m->tkt_gross > 5000 .and. m->tkt_fed = 0
   @ 19,0  clear to 19,79
   @ 19,0   say 'Federal withholding should be entered. Enter Withholding? (Y/N)'
   m->choice = '  '
   do while .not. m->choice$'YN'
      m->choice = ' '
      @ 19,72 get m->choice picture '!'
      read
      if m->m_f2 = 'Y' .or. m->m_f3 = 'Y'
	     clear
	     return (nil)
      endif
   enddo
   if m->choice = 'Y'
      @ 17,22  get m->tkt_fed              picture '999,999.99'
      read
      if m->m_f2 = 'Y' .or. m->m_f3 = 'Y'
	     clear
	     return (nil)
      endif
      m->b_fed += m->tkt_fed
      @ 22, 65  say  m->b_fed     picture '9,999,999.99'
   else
      exit
   endif
enddo

if m->state_tax = 'Y'
	do while m->tkt_gross > 5000 .and. m->tkt_state = 0
	   @ 19,0  clear to 19,79
	   @ 19,0   say 'State Withholding should be entered. Enter Withholding? (Y/N)'
	   m->choice = '  '
	   do while .not. m->choice$'YN'
	      m->choice = ' '
	      @ 19,72 get m->choice picture '!'
	      read
	      if m->m_f2 = 'Y' .or. m->m_f3 = 'Y'
		     clear
		     return (nil)
	      endif
	   enddo
	   if m->choice = 'Y'
	      @ 17,43  get m->tkt_state   picture '999,999.99'
	      read
	      if m->m_f2 = 'Y' .or. m->m_f3 = 'Y'
		     clear
		     return (nil)
	      endif
	      m->b_state += m->tkt_state
	      @ 23, 65  say  m->b_state     picture '9,999,999.99'
	   else
	      exit
	   endif
	enddo
end-if
return (nil)
* eof w2g0610.prg
