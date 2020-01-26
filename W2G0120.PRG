* Program Name: W2G0120
* Author:       David M. Wysocki
* Company:      Diversified Technical Service, Inc.
* Client:       Palm Beach Kennel Club
* Purpose:      Database Reporting Menu.
*
*
function w2g0120()
MEMVAR GETLIST
PUBLIC L_NUMBER := 0
PUBLIC P_NUMBER := 0
PUBLIC R_DATE   := DATE()
PUBLIC B_DATE   := DATE()
PUBLIC E_DATE   := DATE()
PUBLIC P_DATE   := DATE()

DO WHILE .T.
   CLEAR
   CLOSE DATABASES
   SELECT 1
   USE PAYEE INDEX PAYEE
   SELECT 2
   USE TICKET INDEX TICKET
   SELECT 3
   USE BATCHCTL INDEX BATCHCTL
   SELECT 4
   USE PAYER
   @  1,20  SAY 'W2G DATABASE REPORTING MENU'
   @  3,20  SAY '1 - Report by Social Security Number'
   @  5,20  SAY '2 - Report by Payee Last Name'
   @  7,20  SAY '3 - Report by Batch Date and/or Batch Number'
   @  9,20  SAY '4 - Report by Date Range'
   @ 11,20  SAY 'X - Exit system.'
   M->CHOICE = ' '
   DO WHILE .NOT. M->CHOICE $'1234X'
      M->CHOICE = ' '
      @ 13,20  GET M->CHOICE PICTURE '!'
      READ
   ENDDO
   DO CASE
      CASE M->CHOICE = '1'
           DO W2G0230

      CASE M->CHOICE = '2'
           DO W2G0240

      CASE M->CHOICE = '3'
           SET KEY M->KEYF5 TO PROC050
           DO W2G0250
           SET KEY M->KEYF5 TO

      CASE M->CHOICE = '4'
           DO W2G0260

      CASE M->CHOICE = 'X'
	       EXIT
   ENDCASE
ENDDO
CLEAR
CLOSE DATABASES

RETURN (NIL)
* EOF: W2G0120.PRG
