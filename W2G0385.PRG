* Program Name: W2G0385
* Author:       David M. Wysocki
* Company:      Diversified Technical Service, Inc.
* Client:       Palm Beach Kennal Club
* Purpose:      Verify PAYEE Delete Module.
*
*
FUNCTION W2G0385()
MEMVAR GETLIST
SET ESCAPE ON
@ 23, 10 SAY "PLEASE VERIFY THE DELETE OF THIS PAYEE (Y OR N)."
M->CHOICE = ' '
DO WHILE .NOT. M->CHOICE$'YNX'
   M->CHOICE = ' '
   @ 24, 10  GET M->CHOICE PICTURE '!'
   READ
ENDDO
IF M->CHOICE = 'Y'
   M->DEL_FLG  = 'Y'
   DELETE
ENDIF
@ 23,0 CLEAR
RETURN (NIL)
* EOF W2G0385.PRG
