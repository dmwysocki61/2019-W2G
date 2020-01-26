* Program Name: W2G0445
* Author:       David M. Wysocki
* Company:      Diversified Technical Service, Inc.
* Client:       Palm Beach Kennal Club
* Purpose:      Batch Delete Module.
*
*
function w2g0445()

memvar getlist
memvar keyvalue
set scoreboard off
seek keyvalue
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

@  1,34 say 'Batch Delete'
@  2,34 say '   Screen   '

@  1,51 say 'Control Gross:'
@  2,51 say 'Control Fed  :'
@  3,51 say 'Control State:'

@  1,66 say m->ctl_grs   picture '9,999,999.99'
@  2,66 say m->ctl_fed   picture '9,999,999.99'
@  3,66 say m->ctl_sta   picture '9,999,999.99'

@ 24,05 say 'Press Escape to exit.'

browse(5,0,23,79)

@ 24,05 SAY 'Would you like to delete this batch? (Y or N)'

m->choice = ' '

do while .not. m->choice $'ynYN'
   m->choice = ' '
   @ 24,55 get m->choice
   read
enddo

if m->choice $ 'nN'
   zap
   clear
   return (nil)
endif

@ 24,0 clear
@ 24,05 say 'Please verify your delete request. (Y or N)'

m->choice = ' '
DO WHILE .NOT. M->CHOICE $'YN'
   M->CHOICE = ' '
   @ 24,55 GET M->CHOICE PICTURE '!'
   READ
ENDDO

IF M->CHOICE = 'N'
   zap
   clear
   return (nil)
endif

zap

select 1
seek keyvalue

do while ticket->batch_date = m->b_date   .and.                           ;
	     ticket->batch_num  = m->b_number .and. .not. eof()
         delete
         skip
enddo

@ 5,0 clear
@ 7,10 SAY 'WORKING. ONE MOMENT PLEASE.'

PACK

SELECT 2
SEEK KEYVALUE

if eof ()
   clear
   @ 7,15 say 'Warning Batch Control record not found.'
   @ 8,15 say 'Batch Control Record not deleted.'
   wait
   clear
   close databases
   return (nil)
else
   delete
   pack
   close database
   clear
   return (nil)
endif
clear
return (nil)
* eof w2g0445.prg
