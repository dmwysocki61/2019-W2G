* Program Name: W2G0735
* Author:       David M. Wysocki
* Company:      Diversified Technical Service, Inc.
* Client:       Palm Beach Kennal Club
* Purpose:      Database Reporting - Duplicate PAYEE records
*               Print page header
*
FUNCTION W2G0735()
MEMVAR GETLIST
M->L_NUMBER = 7
M->P_NUMBER = M->P_NUMBER + 1
M->R_DATE = DATE()
@  0,0
@  0,003 SAY 'REPORT DATE: '
@  0,017 SAY  M->R_DATE
@  0,055 SAY  PAYER->NAME
@  0,112 SAY 'PAGE NUMBER: '
@  0,125 SAY  M->P_NUMBER PICTURE '999'
@  2,046 SAY 'DATABASE ERROR REPORT - DUPLICATE PAYEE RECORDS'

*@  4,055 SAY 'BATCH'
*@  4,065 SAY 'BATCH'
@  4,055 SAY 'FIRST'
@  4,075 SAY 'SECOND'

@  5,001 SAY 'PAYEE SSN'
@  5,015 SAY 'PAYEE INFORMATION'
*@  5,055 SAY 'DATE'
*@  5,065 SAY 'NUM'
@  5,055 SAY 'ID'
@  5,075 SAY 'ID'

@  6,001 SAY '---------'
@  6,015 SAY '-----------------'
*@  6,055 SAY '----'
*@  6,065 SAY '---'
@  6,055 SAY '---------------'
@  6,075 SAY '---------------'
IF RECCOUNT() = 0
   @ 7,1 SAY 'NO ERRORS FOUND IN DATABASE.'
ENDIF
RETURN (NIL)
* EOF W2G0735.PRG
