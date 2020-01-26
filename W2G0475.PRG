* Program Name: W2G0475
* Author:       David M. Wysocki
* Company:      Diversified Tech Systems, Inc.
* Client:       Palm Beach Kennel Club
* Purpose:      Display Batch Numbers for a given date; Accept Batch number.
*
*
FUNCTION W2G0475()
MEMVAR GETLIST
SET ESCAPE ON
CLEAR
M->B_GROSS  = 0.00
M->B_FED    = 0.00
M->R          = 3
M->PREV_NUM = 0
@  0, 20 SAY "BATCH LIST FOR DATE REQUESTED"
@  2, 05 SAY 'DATE'
@  2, 15 SAY 'BATCH NUMBER'
@  2, 33 SAY 'TOTAL GROSS'
@  2, 48 SAY 'TOTAL WITHHOLDING'
@  3, 05 SAY '--------'
@  3, 15 SAY '-----------'
@  3, 33 SAY '-----------'
@  3, 48 SAY '-----------------'

* NOTE BATCH_DATE IS CHECKED AT END OF LOOP TO BE SURE THAT NEXT
* RECORD IS EQUAL TO DATE REQUESTED.

DO WHILE .T.
   M->PREV_NUM = TICKET->BATCH_NUM
   DO WHILE TICKET->BATCH_DATE = M->B_DATE    .AND. ;
            TICKET->BATCH_NUM  = M->PREV_NUM  .AND. .NOT. EOF()
      M->B_GROSS = M->B_GROSS + TICKET->GROSS
      M->B_FED   = M->B_FED   + TICKET->FED_WITH
      SKIP
   ENDDO
   M->R = M->R+1
   IF M->R = 23
      @ 23,05 SAY "MORE DATA EXISTS. PRESS ENTER TO CONTINUE."
      WAIT
      @  4,0  CLEAR
      M->R =  4
   ENDIF
   @ M->R,05 SAY M->B_DATE
   @ M->R,15 SAY M->PREV_NUM
   @ M->R,30 SAY M->B_GROSS    PICTURE '9,999,999.99'
   @ M->R,45 SAY M->B_FED      PICTURE '9,999,999.99'
   M->B_GROSS = 0
   M->B_FED   = 0
   IF TICKET->BATCH_DATE = M->B_DATE
      LOOP
   ELSE
      EXIT
   ENDIF
ENDDO
@ 24,10 SAY 'ENTER A BATCH NUMBER:'
@ 24,35 GET M->B_NUMBER PICTURE '99'
READ
RETURN (NIL)
* EOF W2G0475.PRG
