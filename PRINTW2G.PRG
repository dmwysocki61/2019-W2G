FUNCTION PRINTW2G()
MEMVAR GETLIST
CLEAR

PUBLIC CHOICE := ' '
PUBLIC SSN    := SPACE(11)
PUBLIC KEY    := SPACE(09)
PUBLIC KEYF2     := -1
do w2g0100

setcolor(MAKECOLOR(pWHITE/pBLUE, pBLACK/pWHITE,pRED,, pWHITE/pBLUE) )


DO WHILE .T.
   cls
   setcolor(MAKECOLOR(pWHITE/pBLUE, pBLACK/pWHITE,pRED,, pWHITE/pBLUE) )
   @  2,20  SAY 'W2G DATA MANAGEMENT SYSTEM'
   @  4,20  SAY '1 - Print W-2G Forms'
   @  6,20  SAY '2 - Restart Printing'
   @  8,20  SAY '3 - Test Printing/Alignment'
   @ 10,20  SAY 'X - Exit system.'
   @ 19,00  SAY '(C) Copyrite Diversified Tech Systems, Inc. 1990. All rights reserved.'
   @ 21,00  SAY 'Use of this program is governed by the License Agreement printed in the'
   @ 22,00  SAY 'front of the user reference manual. Any unauthorized use will subject  '
   @ 23,00  SAY 'violator(s) to legal action.'

   M->CHOICE := ' '
   m->m_f2   := 'N'

   DO WHILE .NOT. M->CHOICE $'123X'
      M->CHOICE := ' '
      @ 11,20  GET MEMVAR->CHOICE PICTURE '!'
      READ
   ENDDO

   DO CASE

       CASE M->CHOICE = '1'
            DO PRNTW2G

       CASE M->CHOICE = '2'

            do restart

                        if m->m_f2 = 'Y'
                           return(nil)
                        else
                           do prntw2g
                        end-if

       CASE M->CHOICE = '3'
            DO TESTW2G

       CASE M->CHOICE = 'X'
            EXIT
      ENDCASE
   SET DEVICE TO SCREEN
ENDDO
RETURN (NIL)