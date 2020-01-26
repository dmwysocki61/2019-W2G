* Program Name: W2G0590
* Author:       David M. Wysocki
* Company:      Diversified Technical Service, Inc.
* Client:       Palm Beach Kennal Club
* Purpose:      Verify Delete Module.
*
*
FUNCTION W2G0590()
MEMVAR GETLIST
SET ESCAPE ON
@ 8, 10 SAY "PLEASE VERIFY THE DELETE OF THIS TRANSACTION (Y OR N)."
M->CHOICE = ' '
DO WHILE .NOT. M->CHOICE$'YNX'
   M->CHOICE = ' '
   @  9, 10  GET M->CHOICE PICTURE '!'
   READ
ENDDO
IF M->CHOICE = 'Y'
   DELETE
ENDIF
@ 8,0 CLEAR
RETURN (NIL)
* EOF W2G0590.PRG
