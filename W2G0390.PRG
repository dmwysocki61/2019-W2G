* Program Name: W2G0390
* Author:       David M. Wysocki]
* Company:      Diversified Technical Services, Inc.
* Client:       Palm Beach Kennel Club
* Purpose:
*
*
FUNCTION W2G0390()
MEMVAR GETLIST
CLEAR
SET SCOREBOARD OFF
SELECT 4
USE PAYER
SELECT 2
PUBLIC GROSS    := 0.00
PUBLIC FED      := 0.00
PUBLIC PREV_ID  := ' '

M->PRNT := ' '
SEEK M->SSN
if eof()
   @ 11, 1 say 'W2G0390.1: THE SOCIAL SECURITY NUMBER HAS NO DATA!!!'
   @ 12, 1 say M->SSN
   @ 13, 1 say 'PLEASE DO A SCREEN PRINT AND NOTIFY SYSTEM ADMIN'
   WAIT
   CLEAR
   RETURN (NIL)
ENDIF

DO WHILE TICKET->RECORD_ID = M->SSN 
   M->GROSS    += TICKET->GROSS
   M->FED      += TICKET->FED_WITH
   SKIP
   IF EOF()
      EXIT
   ENDIF
ENDDO
**** PLACE PAYEE LOGIC HERE, SAVE ALL INFO TO MEM VARS
SELECT 1
@  0,  0  SAY "--------------------------------------------------------------------------------"
@  1,  0  SAY "* PAYER'S name, address, ZIP,      * 1 Gross Winnings     * 2 Federal With.    *"
@  2,  0  SAY "* Federal id number                *                      *                    *"
@  3,  0  SAY "*                                  * -------------------------------------------"
@  4,  0  SAY "*                                  * 3 Type of wager      * 4 Date Won         *"
@  5,  0  SAY "*                                  *   Dog Track          *                    *"
@  6,  0  SAY "*                                  * ------------------------------------------*"
@  7,  0  SAY "*                                  * 5 Transaction        * 6 Race             *"
@  8,  0  SAY "*                                  *                      *                    *"
@  9,  0  SAY "*                                  *-------------------------------------------*"
@ 10,  0  SAY "*                                  * 7 Winnings           * 8 Cashier          *"
@ 11,  0  SAY "*                                  *                      *                    *"
@ 12,  0  SAY "*----------------------------------*-------------------------------------------*"
@ 13,  0  SAY "* Winner's name,address, & ZIP     * 9 Taxpayer Id        * 10 Window          *"
@ 14,  0  SAY "*"
@ 14, 35  SAY "*"
@ 14, 58  SAY "*"
@ 14, 79  SAY "*"
@ 15,  0  SAY "*"
@ 15, 35  SAY "*-------------------------------------------*"
@ 16,  0  SAY "*"
@ 16, 35  SAY "* 11 First Id          * 12 Second Id       *"
@ 17,  0  SAY "*"
@ 17, 35  SAY "*"
@ 17, 58  SAY "*"
@ 17, 79  SAY "*"
@ 18,  0  SAY "*                                  *-------------------------------------------*"
@ 19,  0  SAY "*                                  * 13 State/Payer's Id  * 14 State With.     *"
@ 20,  0  SAY "*                                  *                      *                    *"
@ 21,  0  SAY "*------------------------------------------------------------------------------*"
@ 22,  0  SAY "* Would you like to print this W2G (y,n)?                                      *"
@ 23,  0  SAY "* Signature ___________________________________________  Date _________________*"
@ 24,  0  SAY "*------------------------------------------------------------------------------*"
@  2, 40  SAY  M->GROSS           PICTURE '9,999,999.99'
@  2, 63  SAY  M->FED             PICTURE '9,999,999.99'
@  3,  2  SAY  PAYER->NAME      PICTURE '!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!'
@  4,  2  SAY  PAYER->ADDRESS1  PICTURE '!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!'
@  5,  2  SAY  PAYER->ADDRESS2  PICTURE '!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!'
@  6,  2  SAY  RTRIM(PAYER->CITY) + ', ' + PAYER->STATE
@  7,  2  SAY  PAYER->ZIP
@ 11,  2  SAY  PAYER->EIN
@ 14,  2  SAY  M->NAME
@ 14, 40  SAY  PAYEE->RECORD_ID
@ 15,  2  SAY  PAYEE->ADDRESS
@ 16,  2  SAY  PAYEE->CITY
@ 17,  2  SAY  PAYEE->STATE
@ 17,  6  SAY  PAYEE->ZIP
M->PRNT = ' '
DO WHILE .NOT. M->PRNT $'YN'
   M->PRNT = ' '
   @ 22, 43  get M->PRNT picture '!'
   read
enddo
if M->PRNT = 'Y'
   do W2G0480
endif
clear
select 1
RETURN (NIL)
* Eof: prntreq.prg
