* Program Name: W2G0330
* Author:       David M. Wysocki
* Company:      Diversified Tech Systems, Inc.
* Client:       Palm Beach Kennel Club
* Purpose:      Batch Balance Module.
*
*
function w2g0330()
memvar getlist
m->choice   := ' '
m->rec_id   := space (9)
m->city     := space (25)
m->state    := space (2)
m->zip      := space (5)
do while .t.
   clear
   @  0, 29  say "Balance Batch Screen"
   @  1, 15  say "Batch Date:"
   @  1, 48  say m->b_date      picture 'mm/dd/yy'

   @  2, 15  say "Batch Number:"
   @  2, 54  say m->b_number picture '9999'

   @  4, 15  say "Batch Gross:"
   @  4, 44  say m->b_gross picture '$9,999,999.99'

   @  5, 15  say "Batch Federal:"
   @  5, 44  say m->b_fed   picture '$9,999,999.99'

   @  8, 15  say "Control Total Gross:"
   @  8, 44  say m->ctl_grs picture '$9,999,999.99'

   @  9, 15  say "Control Total Federal:"
   @  9, 44  say m->ctl_fed picture '$9,999,999.99'

   if m->state_tax = 'Y'
      @  6, 15   say "Batch State:"
      @  6, 44   say m->b_state   picture '$9,999,999.99'
      @ 10, 15   say "Control Total State:"
	  @ 10, 44   say m->ctl_sta   picture '$9,999,999.99'
   end-if

   m->comp1 := space(10)
   m->comp2 := space(10)
   m->comp3 := space(10)
   m->comp4 := space(10)
   m->comp5 := space(10)
   m->comp6 := space(10)

   m->comp1 = str(m->ctl_grs,10,2)
   m->comp2 = str(m->b_gross,10,2)

   m->comp3 = str(m->ctl_fed,10,2)
   m->comp4 = str(m->b_fed,10,2)

   m->comp5 = str(m->ctl_sta,10,2)
   m->comp6 = str(m->b_state,10,2)

   @ 24,00 clear
   if m->comp1 = m->comp2 .and. m->comp3 = m->comp4 .and. m->comp5 = m->comp6
      @  24, 15 say "Batch in balance. Press any key to continue."
   else
      @  24, 15 say "Batch out of balance."
   endif

   @  12, 15 say "A - Add transaction to batch."
   @  13, 15 say "B - Browse transactions in batch."
   @  14, 15 say "D - Delete transaction in batch."
   @  15, 15 say "E - Edit transactions in batch."
   @  16, 15 say "T - Edit batch totals"
   @  17, 15 say "X - Exit."

   m->choice = ' '

   do while .not. m->choice $'ABDETX'
      m->choice = ' '
      @  19, 15 get m->choice picture '!'
      read
   enddo

   select 1
   use payee index payee, name

   select 2
   use ticket index ticket, batchid exclusive

   select 4
   use temp exclusive
   zap

   select 2

   do case
      case m->choice = 'A'

           m->limit    := 0
	       m->loop_cnt := 0
	       @ 24,15 say 'Enter the number of transactions to add:'
	       @ 24,58 get m->limit picture '99'

	       read
	       do while m->loop_cnt < m->limit
	          do w2g0420

	          if m->m_f2 = 'Y'
		         loop
	          endif

	          if m->m_f3 = 'Y'
    		     exit
	          endif

	          m->loop_cnt += 1

	       enddo

	       do w2g0470

      case m->choice = 'B'

	       set index to batchid
	       do w2g0435

      case m->choice = 'E'

           set index to batchid
	       do while .t.

	          do w2g0450

	          if m->m_f2 = 'Y'
		         loop
	          endif

    	      if m->m_f3 = 'Y'
		         exit
	          endif
	       enddo

	       do w2g0470

      case m->choice = 'D'
	       set index to batchid
	       do w2g0460
	       do w2g0470

      case m->choice = 'T'
	       do w2g0430

      case m->choice = 'X'
    	   exit
   endcase
enddo
clear
return (nil)
