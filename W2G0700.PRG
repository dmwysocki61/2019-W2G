* Program Name: W2G0700
* Author:       David M. Wysocki
* Company:      Diversified Tech Systems
* Client:       Palm Beach Kennel Club
* Purpose:      Database Error Reporting Menu/Control Module
*
FUNCTION W2G0700()
MEMVAR GETLIST
CLOSE DATABASES
DO WHILE .T.
   CLEAR
   SELECT 4
   USE PAYER
   @  1,23  SAY PAYER->NAME
   @  2,23  SAY 'W2G DATABASE ERROR REPORTING MENU'
   @  4,20  SAY '1 - PAYEE records without matching TICKET records.'
   @  6,20  SAY '2 - TICKET records without matching PAYEE records.'
   @  8,20  SAY '3 - Duplicate PAYEE records.'
   @ 10,20  SAY '4 - Batch Errors.'
   @ 12,20  SAY '5 - Exit menu.'
   M->CHOICE = ' '
   DO WHILE .NOT. M->CHOICE $'12345'
      M->CHOICE = ' '
      @ 14,20  GET M->CHOICE PICTURE '9'
      READ
   ENDDO
   DO CASE
      CASE M->CHOICE = '1'
	   DO W2G0710
      CASE M->CHOICE = '2'
	   DO W2G0720
      CASE M->CHOICE = '3'
	   DO W2G0730
      CASE M->CHOICE = '4'
	   DO W2G0740
      CASE M->CHOICE = '5'
	   EXIT
   ENDCASE
ENDDO
CLOSE DATABASES
CLEAR
RETURN (NIL)
* Eof: w2g0700.prg
