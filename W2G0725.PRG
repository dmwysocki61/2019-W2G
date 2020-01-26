* Program Name: W2G0725
* Author:       David M. Wysocki
* Company:      Diversified Technical Service, Inc.
* Client:       Palm Beach Kennal Club
* Purpose:      Database Error Reporting - Unmatched TICKET records.
*               Print page header
*
FUNCTION W2G0725()
MEMVAR GETLIST
M->L_NUMBER = 8
M->P_NUMBER = M->P_NUMBER + 1
M->R_DATE   = DATE()
@  0,0
@  0,003 SAY 'REPORT DATE: '
@  0,017 SAY  M->R_DATE
@  0,055 SAY  PAYER->NAME
@  0,112 SAY 'PAGE NUMBER: '
@  0,125 SAY  M->P_NUMBER PICTURE '999'

@  2,045 SAY 'DATABASE ERROR REPORT - UNMATCHED TICKET RECORDS'

@  4, 01 SAY 'RECORD'
@  4, 15 SAY 'BATCH'
@  4, 25 SAY 'BATCH'
@  4, 61 SAY 'FED'
@  4, 70 SAY 'DATE'

@  5, 01 SAY 'ID'
@  5, 15 SAY 'DATE'
@  5, 25 SAY 'NUM'
@  5, 39 SAY 'GROSS'
@  5, 60 SAY 'WITH'
@  5, 70 SAY 'WON'
@  5, 80 SAY 'TRANS'
@  5, 95 SAY 'RACE'
@  5,105 SAY 'WINNINGS'
@  5,117 SAY 'CASHIER'
@  5,125 SAY 'WINDOW'

@  6, 01 SAY '---------'
@  6, 15 SAY '--------'
@  6, 25 SAY '---'
@  6, 30 SAY '--------------'
@  6, 50 SAY '--------------'
@  6, 70 SAY '--------'
@  6, 80 SAY '----------'
@  6, 95 SAY '----'
@  6,105 SAY '----------'
@  6,117 SAY '-------'
@  6,125 SAY '------'
IF RECCOUNT() = 0
   @ 7,1 SAY 'NO ERRORS FOUND IN DATABASE.'
ENDIF
RETURN (NIL)
* EOF W2G0725.PRG
