* Program Name: W2G0745
* Author:       David M. Wysocki
* Company:      Diversified Tech Systems, Inc.
* Client:       Palm Beach Kennal Club
* Purpose:      Database Error Reporting - Batch Error Report
*               Print page header
*
FUNCTION W2G0745()
MEMVAR GETLIST
M->L_NUM    = 8
M->P_NUMBER = M->P_NUMBER + 1
M->R_DATE   = DATE()
SELECT 4
@  0,0
@  0,003 SAY 'REPORT DATE: '
@  0,017 SAY  M->R_DATE
@  0,045 SAY  PAYER->NAME
@  0,112 SAY 'PAGE NUMBER: '
@  0,125 SAY  M->P_NUMBER PICTURE '999'

@  2,045 SAY 'DATABASE ERROR REPORT - BATCH ERRORS'

@  4, 01 SAY 'BATCH'
@  4, 10 SAY 'BATCH'
@  4, 20 SAY 'TOTAL'
@  4, 35 SAY 'TOTAL'
@  4, 50 SAY 'TOTAL'
@  4, 65 SAY 'PERFORMANCE'
@  4, 80 SAY 'ERROR'

@  5, 01 SAY 'DATE'
@  5, 10 SAY 'NUMBER'
@  5, 20 SAY 'GROSS'
@  5, 35 SAY 'FEDERAL'
@  5, 50 SAY 'STATE'
@  5, 65 SAY 'NUMBER'
@  5, 80 SAY 'DESCRIPTION'

@  6, 01 SAY '--------'
@  6, 10 SAY '--------'
@  6, 20 SAY '--------------'
@  6, 35 SAY '--------------'
@  6, 50 SAY '--------------'
@  6, 65 SAY '--------------'
@  6, 80 SAY '----------------------------------------'
SELECT 3
IF RECCOUNT() = 0
   @ 7,1 SAY 'NO ERRORS FOUND IN DATABASE.'
ENDIF
RETURN (NIL)
* EOF W2G0725.PRG
