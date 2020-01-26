function restart()
MEMVAR GETLIST
m->choice = ' '
do while .T.
   @ 11,00 CLEAR TO 24,79
   @ 13,15 say 'SSN: '
   @ 15,15 SAY 'Enter last SSN succesfully printed. Enter F2 to exit.'

   @ 13,20 get m->ssn    PICTURE '999-99-9999'

   read

   if m->m_f2 = 'Y'
      return (nil)
   end-if

   m->key := substr(m->ssn,1,3) + substr(m->ssn,5,2) + substr(m->ssn,8,4)
   select 1
   use payee index payee
   seek m->key
   if eof()
      @ 14,20 say 'SSN not found in database. Please try again.'
      wait
	  loop
   else 
      exit
   end-if
end-while
close databases
return (NIL)