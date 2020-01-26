* Program Name: W2G0300
* Author:       David M. Wysocki
* Company:      Diversified Tech Systems, Inc.
* Client:       Flagler Kennel Club
* Purpose:      Accept Batch Control Totals. Write batch control record.
*
function w2g0300()

memvar getlist

use batchctl index batchctl

//public b_number
//public b_date

SET KEY M->KEYF2 TO PROC010
SET KEY M->KEYF4 TO PROC030

m->b_number = 0
m->b_date   = date()
m->m_f2     = ' '
m->m_f3     = ' '
m->key      = space(10)

do while .t.
   clear
   @ 0,20 SAY 'BATCH INPUT'
   @ 2,10 SAY 'ENTER BATCH DATE:'
   @ 4,10 SAY 'ENTER BATCH NUMBER:'
   @ 6,10 SAY 'F2:->Exit. F4:->View existing batches for this date.'
   @ 2,62 GET M->B_DATE
   @ 4,68 GET M->B_NUMBER PICTURE '9999'

   READ

   IF M->M_F2 = 'Y'
      CLEAR
      RETURN (NIL)
   ENDIF

   IF M->M_F4 = 'Y'
      M->M_F4 = 'N'
      LOOP
   ENDIF

   IF M->B_NUMBER = 0
      @ 23,0 SAY 'Batch Number is required. Please enter.'
      WAIT
      @  5,0 CLEAR
      M->CHOICE = ' '
      LOOP
   ENDIF
   
   M->KEY = DTOC(M->B_DATE) + STR(M->B_NUMBER,4)
   
   SEEK M->KEY
   
   IF EOF()
      M->CHOICE = ' '
      @ 8,10 SAY 'Is the data input correct (Y/N)?'
      @ 8,43 GET M->CHOICE PICTURE 'Y'
   
      READ
   
      IF M->CHOICE = 'Y'
         exit
      else
         @ 5,0 clear
         loop
      ENDIF
   
   ELSE
   
      @ 23,0 SAY 'BATCH ALREADY EXISTS IN DATABASE. PLEASE SELECT A DIFFERENT NUMBER.'
      WAIT
      @  5,0 CLEAR
      M->CHOICE = ' '
      LOOP
   
   ENDIF

ENDDO

RETURN (NIL)
*Eof W2G0300.PRG
