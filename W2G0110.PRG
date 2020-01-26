* Program Name: W2G0110
* Author:       David M. Wysocki
* Company:      Diversified Technical Service, Inc.
* Client:       Palm Beach Kennal Club
* Purpose:      Batch Entry/Update Control Module.
*
*
function w2g0110()

MEMVAR GETLIST
PUBLIC B_DATE   := DATE()
PUBLIC B_NUMBER := 0

DO WHILE .T.

   CLEAR
   M->CHOICE = ' '

   @  1,23  SAY 'BATCH INFORMATION MENU'
   @  3,23  SAY '1 - Batch Input'
   @  5,23  SAY '2 - Batch Edit'
   @  7,23  SAY '3 - Batch Inquiry'
   @  9,23  SAY '4 - Batch Delete'
   @ 11,23  SAY '5 - Display Database Totals'
   @ 13,23  SAY '6 - Spreadsheet Upload'
   @ 15,23  SAY 'X - Exit system.'

   M->CHOICE = ' '

   DO WHILE .NOT. M->CHOICE $'123456X'
      M->CHOICE = ' '
      @ 17,23  GET M->CHOICE PICTURE '!'
      READ
   ENDDO

   DO CASE

      CASE M->CHOICE = '1'
	       DO W2G0200

      CASE M->CHOICE = '2'
	       DO W2G0210

      CASE M->CHOICE = '3'
           DO W2G0220

      CASE M->CHOICE = '4'
	       DO W2G0225

      CASE M->CHOICE = '5'
	       DO SUM1

      CASE M->CHOICE = '6'
            DO W2G0201
               
      CASE M->CHOICE = 'X'
	       EXIT

   ENDCASE

CLOSE DATABASES

CLEAR
ENDDO

RETURN (NIL)
* EOF: W2G0110.PRG
