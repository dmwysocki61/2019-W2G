* Program Name: W2G0440
* Author:       David M. Wysocki
* Company:      Diversified Technical Service, Inc.
* Client:       Palm Beach Kennal Club
* Purpose:      Transaction Browse Module.
*
*
*
function w2g0440()
memvar getlist
memvar keyvalue
set scoreboard off
seek keyvalue
if eof()
   clear
   @ 7,15 say 'w2g0440.1 transaction data not found.'
   @ 8,15 say 'report message number to system programmer.'
   wait
   clear
   close databases
   return (nil)
endif

do while ticket->batch_date = m->b_date .and. ;
	     ticket->batch_num  = m->b_number
   select 3
   append blank
   replace temp->record_id  with ticket->record_id
   replace temp->gross      with ticket->gross
   replace temp->fed_with   with ticket->fed_with
   replace temp->sta_with   with ticket->sta_with
   replace temp->date_won   with ticket->date_won
   replace temp->trans      with ticket->trans
   replace temp->race       with ticket->race
   replace temp->cashier    with ticket->cashier
   replace temp->window     with ticket->window
   replace temp->batch_date with ticket->batch_date
   replace temp->batch_num  with ticket->batch_num
   replace temp->perf_num   with ticket->perf_num
   select 1
   skip
enddo
select 3
goto top
clear
@ 0,0  to 4,28 double
@ 0,29 to 4,48 double
@ 0,49 to 4,79 double

@  1, 2 say 'Batch Gross: '
@  2, 2 say 'Batch Fed  : '
@  3, 2 say 'Batch State: '

@  1,15 say m->b_gross   picture '9,999,999.99'
@  2,15 say m->b_fed     picture '9,999,999.99'
@  3,15 say m->b_state   picture '9,999,999.99'

@  1,34 say 'Transaction'
@  2,33 say 'Browse Screen'

@  1,51 say 'Control Gross:'
@  2,51 say 'Control Fed  :'
@  3,51 say 'Control State:'

@  1,66 say m->ctl_grs   picture '9,999,999.99'
@  2,66 say m->ctl_fed   picture '9,999,999.99'
@  3,66 say m->ctl_sta   picture '9,999,999.99'

@ 24, 0 say 'press escape to exit at anytime.'
browse(5,0,23,79)
zap
clear
return (nil)
* eof w2g0440.prg
