* Program Name: W2G0340
* Author:       David M. Wysocki
* Company:      Diversified Tech Systems, Inc.
* Client:       Flagler Kennel Club
* Purpose:      Select Batch Control.
*
*
function w2g0340()
memvar getlist
public key_value := space (12)

m->b_date   = date()
m->b_number = 0
m->prev_num = 0

select 1
use ticket index batchid
select 2
use batchctl index batchctl
select 1
clear

do while .t.

   m->choice = ' '
   m->b_number = 0

   @ 01,20 say "Batch Edit Screen"
   @ 03,05 say "Enter Batch Date: "
   @ 05,05 say "Enter Batch Number: "
   @ 07,05 say "F2:->Exit F5:->List all batches for the given date."
   @ 03,30 get  m->b_date	 
   @ 05,36 get  m->b_number picture '9999'

   read

   if m->m_f2 = 'Y'
      clear
      return (nil)
   endif

   if m->m_f5 = 'Y'
      m->m_f5 := ' '
      loop
   endif

   select 2

   m->key_value := dtoc (m->b_date) + str (m->b_number,4)

   seek key_value softseek

   if eof()
      @ 9,00 clear
      @ 9,05 say 'No data found for this batch. please try again.'
      wait
      @ 9,00 clear
      loop
   else
      clear
      @ 7,20 say 'working, one moment please.'
      m->b_gross  := 0.00
      m->b_fed    := 0.00
      m->b_state  := 0.00
      
      select 1
      
      seek m->key_value

      do while ticket->batch_date = m->b_date   .and. ;
	       ticket->batch_num  = m->b_number .and. .not. eof()
	           m->b_gross += ticket->gross
	           m->b_fed   += ticket->fed_with
                   m->b_state += ticket->sta_with
	           skip
      enddo
      exit
   endif
enddo
clear
return (nil)
* eof w2g0340.prg
