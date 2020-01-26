* Program Name: W2G0470
* Author:       David M. Wysocki
* Company:      Diversified Tech Systems, Inc.
* Client:       Palm Beach Kennel Club
* Purpose:      Find Batch and calculate summary totals.
*
*

function w2g0470()
memvar getlist
set escape on
clear
@ 7,20 say 'working, one moment please.'

m->b_gross = 0.00
m->b_fed   = 0.00
m->b_state = 0.00

select 2
set index to batchid
seek dtoc(m->b_date)+str(m->b_number,4)

do while ticket->batch_date = m->b_date   .and. ;
     	 ticket->batch_num  = m->b_number .and. .not. eof()
         m->b_gross += ticket->gross
         m->b_fed   += ticket->fed_with
		 m->b_state += ticket->sta_with
         skip
enddo
return (nil)
* eof w2g0470.prg
