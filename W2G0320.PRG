* Program Name: W2G0320
* Author:       David M. Wysocki
* Company:      Diversified Technical Service, Inc.
* Client:       Palm Beach Kennal Club
* Purpose:      Ticket Entry Control Module.
*
*
function w2g0320()

memvar getlist
clear

set escape on
set intensity on

select 1
use payee index payee, name

select 2
use ticket index ticket, batchid

select 3
use batchctl index batchctl

public  b_gross  := 0
public  b_fed    := 0
public  b_state  := 0
private payees   := 0
private s_type   := ' '
private rec_id   := {}
private loop_cnt := 0
private city     := space(25)
private state    := space(2)
private zip      := space(5)

m->choice   := ' '

do while m->mtpl_cnt > m->loop_cnt
   
   m->m_f2     = 'N'
   m->m_f3     = 'N'
   m->s_type   = ' '
   m->payees   = 0

   @  1, 20  say "Multiple Payee Entry Screen"
   @  3, 15  say "Enter the Number of Payees (1 - 5):"
   @  5, 15  say "Enter the Type of Winnings Split:"
   @  7, 15  say "(P for Percentage, A for Amount, X to Exit.)"

   @  3, 55  get m->payees  picture '9'
   @  5, 55  get m->s_type  picture '!'
   @ 24, 15  say 'F2:->Clear Trans. F3:->Exit Trans Input.'
   
   read
   
   if m->m_f2 = 'Y'
      m->m_f2 = 'N'
      loop
   endif

   if m->m_f3 = 'Y'
      clear
      return (nil)
   endif

   do while m->payees < 2 .or. m->payees > 5
      @  3, 55  get m->payees  picture '9'
      @ 22,  0  clear to 22,79
      @ 22, 10  say 'Number of Payees must be 2 thru 5.'

      read
      
      IF M->M_F2 = 'Y'
         M->M_F2 = 'N'
         LOOP
      ENDIF
      
      IF M->M_F3 = 'Y'
         CLEAR
         RETURN (NIL)
      ENDIF

   ENDDO
   
   DO WHILE .NOT. M->S_TYPE$'PAX'
      @  5, 55  GET M->S_TYPE   PICTURE '!'
      @ 22,  0  CLEAR TO 22,79
      @ 22, 10  SAY 'TYPE OF SPLIT must be P for Percentage or A for Amount.'

      READ
      
      IF M->M_F2 = 'Y'
         M->M_F2 = 'N'
         LOOP
      ENDIF
      
      IF M->M_F3 = 'Y'
         CLEAR
         RETURN (NIL)
      ENDIF
   ENDDO

   DO CASE
      CASE  M->S_TYPE = 'A'
            DO W2G0400
   
      CASE  M->S_TYPE = 'P'
            DO W2G0410
   
      CASE  M->S_TYPE = 'X'
            CLEAR
            RETURN (NIL)
   ENDCASE
   
   IF M->M_F2 = 'Y'
      LOOP
   ENDIF
   
   IF M->M_F3 = 'Y'
      CLEAR
      RETURN (NIL)
   ENDIF
   
   ++M->LOOP_CNT
ENDDO

M->LOOP_CNT = 0

M->TKT_CNT  = M->TKT_CNT - M->MTPL_CNT

CLEAR

IF M->MTPL_CNT > 0
   @ 10,10 SAY 'MULITPLE WINNER INPUT PROCESS IS NOW COMPLETE'
   WAIT
ENDIF

DO WHILE M->LOOP_CNT < M->TKT_CNT

   DO W2G0420

   DO CASE

      CASE M->M_F3 = 'Y'
           EXIT
   
      CASE M->M_F2 = 'N'
           ++M->LOOP_CNT
   
      CASE M->M_F2 = 'Y'
           LOOP
   ENDCASE
ENDDO

CLEAR
RETURN (NIL)
* EOF W2G0320
