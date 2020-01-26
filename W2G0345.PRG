* Program Name: W2G0345
* Author:       David M. Wysocki
* Company:      Diversified Technical Service, Inc.
* Client:       Palm Beach Kennel Club
* Purpose:      Select Batch Control.
*
*
function w2g0345()

memvar getlist
public  b_gross  := 0
public  b_fed    := 0
public  b_state  := 0
public  b_date   := date()
public  b_number := 0
public  prev_num := 0
private m_f2     := ' '
public  key_value := space(12)

select 1
use ticket index batchid,ticket

select 2
use batchctl index batchctl

select 1

do while .T.
   clear
   m->choice = ' '
   m->b_number = 0
   @ 01,20 say "Batch Delete Screen"
   @ 03,05 say "Enter Batch Date:"
   @ 05,05 say "Enter Batch Number:"
   @ 07,05 say "F2:->Exit F5->List all batches for the given date."
   @ 03,55 get m->b_date
   @ 05,59 get m->b_number picture '9999'

   read

   if m->m_f2 = 'Y'
      clear
      return (nil)
   endif

   if m->m_f5 = 'Y'
      m->m_f5 = 'N'
      loop
   endif

   set exact off
   key_value := dtoc(m->b_date)
   seek key_value softseek

   if eof()
      @ 24,0  clear
      @ 24,10 say 'no batches exist for this date'
      wait
      loop
   else
      m->key_value := dtoc (m->b_date) + str (m->b_number,4)
      seek m->keyvalue softseek
      clear
	  @ 7,20 say 'working, one moment please.'
	  m->b_gross := 0
	  m->b_fed   := 0
	  m->b_state := 0
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
close database
return (nil)
* eof w2g0345.prg
