* program name: w2g0350
* author:       david m. wysocki
* company:      diversified technical service, inc.
* client:       palm beach kennel club
* purpose:      batch edit control
*
*
function w2g0350()
memvar getlist
set escape on
m->choice   = ' '
m->rec_id   = space (9)
m->city     = space(25)
m->state    = space(2)
m->zip      = space(5)
m->ctl_grs  = 0.00
m->ctl_fed  = 0.00
m->ctl_sta  = 0.00

m->comp1    = space(13)
m->comp2    = space(13)
m->comp3    = space(13)
m->comp4    = space(13)
m->comp5    = space(13)
m->comp6    = space(13)

m->perf_num = '   '
m->date_won = date()

select 2
seek dtoc(m->b_date)+str(m->b_number,4)

if eof ()
   clear
   @ 0,20 say 'Batch Control Record not found'
   @ 1,20 say 'Database Maintenance must be performed'
   wait
   return (nil)
else
   m->ctl_grs  = batchctl->total_gros
   m->ctl_fed  = batchctl->total_fed
   m->ctl_sta  = batchctl->total_sta
   m->perf_num = batchctl->perf_num
endif

do while .t.
   clear
   @ 00,32 say "Batch Edit Screen"

   @ 02,15 say "Batch Date:"
   @ 02,44 say  m->b_date

   @ 03,15 say "Batch Number:"
   @ 03,50 say  m->b_number picture '9999'

   @ 05,15 say "Batch Gross:"
                                           
   @ 05,40 say  m->b_gross        picture '99,999,999.99'

   @ 06,15 say "Batch Federal:"
   @ 06,40 say  m->b_fed          picture '99,999,999.99'

   @ 07,15 say "Batch State: "    
   @ 07,40 say  m->b_state        picture '99,999,999.99'
   
   @ 09,15 say "Control Total Gross:"
   @ 09,40 say  m->ctl_grs        picture '99,999,999.99'

   @ 10,15 say "Control Total Federal:"
   @ 10,40 say  m->ctl_fed        picture '99,999,999.99'

   @ 11,15 say "Control Total State:"
   @ 11,40 say m->ctl_sta      picture '99,999,999.99'

   @ 13,15 say "A - Add Transactions to Batch"
   @ 14,15 say "B - Browse Transactions"
   @ 15,15 say "D - Delete Transactions"
   @ 16,15 say "E - Edit Transactions"
   @ 17,15 say "T - Edit Batch Totals"
   @ 18,15 say "X - Exit Batch Edit"

   m->comp1 = str (m->b_gross,10,2)
   m->comp2 = str (m->ctl_grs,10,2)
   m->comp3 = str (m->b_fed  ,10,2)
   m->comp4 = str (m->ctl_fed,10,2)
   m->comp5 = str (m->ctl_sta,10,2)
   m->comp6 = str (m->b_state,10,2)


   if (m->comp1 = m->comp2) .and. (m->comp3 = m->comp4)
      @ 24,15 say 'Batch in balance.'
   else
      @ 24,15 say 'Batch out of balance.'
   endif

   m->choice = ' '

   do while .not. m->choice $'ABDETX'
      m->choice = ' '
      @ 20,15 get  m->choice picture '!'
      read
   enddo

   close databases

   select 1
   use payee index payee, name

   select 2
   use ticket index ticket, batchid

   select 4
   use temp

   zap

   do case

      case m->choice = 'A'

		   select 2
		   set index to ticket, batchid

		   m->limit    = 0
		   m->loop_cnt = 0

		   @ 24, 0 clear to 24,79
                   @ 24, 0 say 'Enter the number of transactions to add:'
		   @ 24,40 get m->limit picture '99'

		   read

		   do while m->loop_cnt < m->limit

		      do w2g0420

		      if m->m_f2 = 'Y'
			     loop
		      endif

		      if m->m_f3 = 'Y'
			     exit
		      endif

		      ++m->loop_cnt
		   enddo

		   do w2g0470

      case m->choice = 'B'

		   select 2
		   set index to batchid

		   do w2g0435

      case m->choice = 'E'
		   select 2

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

		   select 2
		   set index to batchid
		   do w2g0460
		   do w2g0470

      case m->choice = 'T'

    	   do w2g0430

      case m->choice = 'X'

	       clear
	       return (nil)

   endcase
enddo
close database
clear
return (nil)
* eof w2g0350.prg
