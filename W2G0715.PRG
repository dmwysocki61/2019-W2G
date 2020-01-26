* Program Name: W2G0715
* Author:       David M. Wysocki
* Company:      Diversified Technical Service, Inc.
* Client:       Palm Beach Kennal Club
* Purpose:      Database Reporting - Unmatched PAYEE records - Pg Header.
*
*
FUNCTION W2G0715()
MEMVAR GETLIST
M->L_NUMBER = 7
M->P_NUMBER = M->P_NUMBER + 1
M->R_DATE   = DATE()
@  0,0
@  1,003 SAY 'REPORT DATE: '
@  1,017 SAY  M->R_DATE
@  1,055 SAY  PAYER->NAME
@  1,112 SAY 'PAGE NUMBER: '
@  1,125 SAY  M->P_NUMBER  PICTURE '999'
@  2,046 SAY 'DATABASE ERROR REPORT - UNMATCHED PAYEE RECORDS'

@  4,055 SAY 'FIRST'
@  4,075 SAY 'SECOND'

@  5,001 SAY 'PAYEE INFORMATION'
@  5,040 SAY 'PAYEE SSN'
@  5,055 SAY 'ID'
@  5,075 SAY 'ID'

@  6,001 SAY '-----------------'
@  6,040 SAY '---------'
@  6,055 SAY '---------------'
@  6,075 SAY '---------------'
IF RECCOUNT() = 0
   @ 7,1 SAY 'NO ERRORS FOUND IN DATABASE.'
ENDIF
RETURN (NIL)
* EOF W2G0715.PRG
