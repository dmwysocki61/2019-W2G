* Program Name: W2G0310
* Author:       David M. Wysocki
* Company:      Diversified Tech Systems, Inc.
* Purpose:      Accept Batch Controls.
*
*
function w2g0310()

memvar getlist

use batchctl index batchctl

public ctl_grs  := 0.00
public ctl_fed  := 0.00
public ctl_sta  := 0.00
public tkt_cnt  := 0
public mtpl_cnt := 0
public perf_num := space(04)
m->m_f2         := 'N'
m->m_f3         := 'N'
m->choice       := ' '
@  5,0  clear

@  6, 10  SAY "Enter Total Gross Winnings:"
@  8, 10  SAY "Enter Total Federal Witholding:"

if m->state_tax = 'Y'
   @ 10, 10  SAY "Enter Total State Withholding:"
   @ 12, 10  SAY "Enter the Total Number of Tickets:"
   @ 14, 10  SAY "Enter the Number of Mulitple Payee Tickets:"
   @ 15, 10  SAY "(Skip if no Multiple Winner Tickets exist.)"
   @ 17, 10  SAY "Enter Performance Number:"
   @ 24, 10  SAY "F2:->Exit. F3:->Clear Input."
else
   @ 10, 10  SAY "Enter the Total Number of Tickets:"
   @ 12, 10  SAY "Enter the Number of Mulitple Payee Tickets:"
   @ 13, 10  SAY "(Skip if no Multiple Winner Tickets exist.)"
   @ 15, 10  SAY "Enter Performance Number:"
   @ 24, 10  SAY "F2:->Exit. F3:->Clear Input."
end-if

do while .t.
   m->m_f2 = 'N'
   m->m_f3 = 'N'

   if m->state_tax = 'Y'
      @  6, 60  get  m->ctl_grs       picture '999,999,999.99'
      @  8, 60  get  m->ctl_fed       picture '999,999,999.99'
      @ 10, 60  get  m->ctl_sta       picture '999,999,999.99'
      @ 12, 69  get  m->tkt_cnt       picture '99,999'
      @ 14, 69  get  m->mtpl_cnt      picture '99,999'
      @ 17, 68  get  m->perf_num      picture '!!!!'

   else

      @  6, 58  get  m->ctl_grs       picture '999,999,999.99'
      @  8, 58  get  m->ctl_fed       picture '999,999,999.99'
      @ 10, 66  get  m->tkt_cnt       picture '99,999'
      @ 12, 66  get  m->mtpl_cnt      picture '99,999'
      @ 15, 68  get  m->perf_num      picture '!!!!'
   endif

   read

   if m->m_f2 = 'Y'
      clear
      return (nil)
   endif

   if m->m_f3 = 'Y'
      m->ctl_grs  = 0
      m->ctl_fed  = 0
      m->ctl_sta  = 0
      m->tkt_cnt  = 0
      m->mtpl_cnt = 0
      m->perf_num = space(04)
      loop
   endif

   do while m->ctl_grs = 0
      @  6,60  get  m->ctl_grs     picture '9,999,999.99'
      @ 23, 0  clear
      @ 24,10  SAY 'Total GROSS AMOUNT must be entered.'

      read

      if m->m_f2 = 'Y' .or. m->m_f3 = 'Y'
         exit
      endif
   enddo

   if m->m_f2 = 'Y'
      clear
      return (nil)
   endif

   if m->m_f3 = 'Y'
      m->ctl_grs  = 0
      m->ctl_fed  = 0
      m->ctl_sta  = 0
      m->tkt_cnt  = 0
      m->mtpl_cnt = 0
      m->perf_num = space(04)
      loop
   endif

   do while m->tkt_cnt = 0
	  if m->state_tax = 'Y'
         @ 12, 69 get  m->tkt_cnt       picture '999'
	  else
	     @ 10, 69 get  m->tkt_cnt       picture '999'
	  endif

      @ 23,  0 clear
      @ 24, 10 say 'Number of Tickets must be greater than 0.'

      read
      
      if m->m_f2 = 'Y' .or. m->m_f3 = 'Y'
	     exit
      endif

   enddo

   if m->m_f2 = 'Y'
      clear
      return (nil)
   endif

   if m->m_f3 = 'Y'
      m->ctl_grs  = 0
      m->ctl_fed  = 0
      m->ctl_sta  = 0
      m->tkt_cnt  = 0
      m->mtpl_cnt = 0
      m->perf_num = space(04)
      loop
   endif

   do while m->mtpl_cnt > m->tkt_cnt

      if m->state_tax = 'Y'
	     @ 14, 69 get m->mtpl_cnt     picture '999'
	  else
	     @ 12, 69 get m->mtpl_cnt     picture '999'
	  end-if

      @ 23,  0 CLEAR
      @ 23, 10 say 'Number of mulitple payee tickets must be less than or'
      @ 24, 10 say 'equal to the total number of tickets.'
      
      read
      
      IF M->M_F2 = 'Y' .OR. M->M_F3 = 'Y'
	     exit
      endif
   
   enddo
   
   if m->m_f2 = 'Y'
      clear
      return (nil)
   endif
   
   if m->m_f3 = 'Y'
      m->ctl_grs  = 0
      m->ctl_fed  = 0
      m->ctl_sta  = 0
      m->tkt_cnt  = 0
      m->mtpl_cnt = 0
      m->perf_num = space(04)
      loop
   endif
   
   do while m->perf_num = space(04)
      
      if m->state_tax = 'Y'
	     @ 17, 68 get m->perf_num     picture '!!!!'
	  else
         @ 15, 68 get m->perf_num     picture '!!!!'
	  end-if

      @ 23,  0 clear
      @ 24, 10 say 'Performance number must be entered.'
      
      read
      
      if m->m_f2 = 'Y' .or. m->m_f3 = 'Y'
	     exit
      endif
   enddo

   if m->m_f2 = 'Y'
      clear
      return (nil)
   endif
   
   if m->m_f3 = 'Y'
      m->ctl_grs  = 0
      m->ctl_fed  = 0
      m->ctl_sta  = 0
      m->tkt_cnt  = 0
      m->mtpl_cnt = 0
      m->perf_num = space(04)
      loop
   endif
   
   @ 18,0 clear to 19,0
   
   m->choice = ' '

   do while .not. m->choice$'YNX'
      M->CHOICE = ' '

      @ 19, 10 SAY "Are the above totals correct (Y OR N)?"
      @ 19, 71 get  m->choice picture '!'

      read
      
      if m->m_f2 = 'Y' .or. m->m_f3 = 'Y'
     	 exit
      endif
   enddo

   IF M->M_F2 = 'Y'
      clear
      return (nil)
   endif
   
   IF M->M_F3 = 'Y'
      m->ctl_grs  = 0
      m->ctl_fed  = 0
      m->ctl_sta  = 0
      m->tkt_cnt  = 0
      m->mtpl_cnt = 0
      m->perf_num = space(04)
      loop
   endif
   
   do case
      CASE M->CHOICE = 'N'
	       @ 19,  0  CLEAR
	       @ 24, 10  SAY "F2:->Exit. F3:->Clear Input."
	       M->CHOICE = ' '
	       LOOP
      CASE M->CHOICE = 'Y'
	       append blank
	       replace batchctl->batch_date with m->b_date
	       replace batchctl->batch_num  with m->b_number
	       replace batchctl->total_gros with m->ctl_grs
	       replace batchctl->total_fed  with m->ctl_fed
               replace batchctl->total_sta  with m->ctl_sta
               replace batchctl->perf_num   with m->perf_num
	       clear
	       return (nil)
      CASE M->CHOICE = 'X'
	       clear
	       return (nil)
   endcase
enddo

clear
return (nil)

* eof w2g0310.prg