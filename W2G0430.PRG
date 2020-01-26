* Program Name: W2G0430
* Author:       David M. Wysocki
* Company:      Diversified Technical Services, Inc.
* Client:       Palm Beach Kennel Club
* Purpose:      Edit Batch Controls.
*
*
function w2g0430()
memvar getlist
private keyvalue  := space(12)
private choice    := space (01)
clear
@  1, 20  say "Batch Totals Edit Screen"
@  3, 10  say "Batch Gross Winnings:"
@  4, 10  say "Batch Federal Withholding:"
@  5, 10  say "Batch State Withholding:"

@  7, 10  say "Control Total Gross:"
@  8, 10  say "Control Total Fed Withholding:"
@  9, 10  say "Control Total State Withholding:"

@ 11, 10  say "Performance Number:"
@ 13, 10  say "F2 to exit."

@  3, 60  say  m->b_gross   picture '99,999,999.99'
@  4, 60  say  m->b_fed     picture '99,999,999.99'
@  5, 60  say  m->b_state   picture '99,999,999.99'

@  7, 60  get  m->ctl_grs   picture '99,999,999.99'
@  8, 60  get  m->ctl_fed   picture '99,999,999.99'
@  9, 60  get  m->ctl_sta   picture '99,999,999.99'

@ 11, 66  get  m->perf_num  picture '!!!!'

@ 20, 00  SAY 'The batch totals represent the total amounts of all transactions entered to date.'
@ 21, 00  SAY 'The control totals represent the amounts entered at the beginning of the batch'
@ 22, 00  SAY 'input process. Make any corrections needed so the corresponding totals are equal' 
@ 23, 00  SAY 'and press enter.'
READ
IF M->M_F2 = 'Y'
   M->M_F2 = 'N'
   CLEAR
   RETURN (NIL)
ENDIF
DO WHILE .T.

   M->M_CHOICE = ' '
   @ 15, 10 SAY "Is the above information correct (Y/N)?"
   @ 15, 67 GET M->CHOICE PICTURE '!'

   READ

   IF M->M_F2 = 'Y'
      M->M_F2 = 'N'
      CLEAR
      RETURN (NIL)
   ENDIF

   DO CASE

      CASE M->CHOICE = 'Y'
		   select 3
		   use batchctl index batchctl
		   m->keyvalue := dtoc(m->b_date)+str(m->b_number,4)
		   seek m->keyvalue
		   if eof ()
		      clear
		      @ 0,20 say 'batch control record not found'
		      @ 1,20 say 'database maintenance must be performed'
		      wait
		      return (nil)
		   endif
		   replace batchctl->total_gros with m->ctl_grs
		   replace batchctl->total_fed  with m->ctl_fed
	           replace batchctl->total_sta  with m->ctl_sta
		   replace batchctl->perf_num   with m->perf_num
		   clear
		   return (nil)

      CASE M->CHOICE = 'N'
		   m->choice = ' '
		   @  7, 60  get  m->ctl_grs   picture '99,999,999.99'
		   @  8, 60  get  m->ctl_fed   picture '99,999,999.99'
                   @  9, 60  get  m->ctl_sta   picture '99,999,999.99'
           
		   @ 11, 66  get  m->perf_num  picture '!!!!'
		   read
		   loop

      CASE M->CHOICE = 'X'
		   clear
		   return (nil)

      otherwise
		   loop

      endcase
enddo
clear
return (nil)
* eof w2g0430.prg
