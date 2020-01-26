* Program Name: W2G0100
* Author:       David M. Wysocki
* Company:      Diversified Technical Service, Inc.
* Client:       Flagler Kennel Club
* Purpose:      Set up procedures
*
#define CLIPPER
#include "PTInkey.ch"

FUNCTION W2G0100()

memvar getlist
PUBLIC M_F2 := 'N'
PUBLIC M_F3 := 'N'
PUBLIC M_F5 := 'N'
PUBLIC KEYF2   := -1
PUBLIC KEYF3   := -2
PUBLIC KEYF4   := -3
PUBLIC KEYF5   := -4

SET KEY M->KEYF2 TO PROC010
SET KEY M->KEYF3 TO PROC020
RETURN (NIL)

* Program Name: PROC010
* Author:       David M. Wysocki
* Company:      Diversified Tech Systems, Inc.
* Client:       Palm Beach Kennel Club
* Purpose:      Exit Transaction.
*
*

PROCEDURE PROC010
memvar getlist
M->M_F2       = 'Y'
CLEAR GETS
RETURN

* Program Name: PROC020
* Author:       David M. Wysocki
* Company:      Diversified Tech Systems, Inc.
* Client:       Palm Beach Kennel Club
* Purpose:      Clear transaction input.
*
*

PROCEDURE PROC020
memvar getlist
CLEAR GETS
M->M_F3 = 'Y'
RETURN

* Program Name: PROC030
* Author:       David M. Wysocki
* Company:      Diversified Tech Systems, Inc.
* Client:       Palm Beach Kennel Club
* Purpose:      Browse BATCHCTL database.
*
*
PROCEDURE PROC030 
memvar getlist
M->M_F4 = 'Y'
SET FILTER TO BATCHCTL->BATCH_DATE = M->B_DATE
GOTO TOP
SET SCOREBOARD OFF
@ 24,0 SAY 'Press ESCAPE to exit at any time.'
BROWSE (0,0,23,79)
SET FILTER TO
CLEAR
RETURN

* Program Name: PROC040
* Author:       David M. Wysocki
* Company:      Diversified Tech Systems, Inc.
* Client:       Palm Beach Kennel Club
* Purpose:      Browse BATCHCTL database from F5 key.
*
*
PROCEDURE PROC040
memvar getlist
M->M_F5 = 'Y'
SELECT 2
CLEAR
SET FILTER TO BATCHCTL->BATCH_DATE = M->B_DATE
GOTO TOP
SET SCOREBOARD OFF
@ 24,0 SAY 'Press ESCAPE to exit at any time.'
BROWSE (0,0,23,79)
SET FILTER TO
SET ESCAPE OFF
RETURN

*Eof PROC040.PRG

* Program Name: PROC050
* Author:       David M. Wysocki
* Company:      Diversified Tech Systems, Inc.
* Client:       Palm Beach Kennel Club
* Purpose:      Browse BATCHCTL database from F5 key.
*
*
PROCEDURE PROC050
memvar getlist
M->M_F5 = 'Y'
SELECT 3
CLEAR
SET FILTER TO BATCHCTL->BATCH_DATE = M->B_DATE
GOTO TOP
SET SCOREBOARD OFF
@ 24,0 SAY 'Press ESCAPE to exit at any time.'
BROWSE (0,0,23,79)
SET FILTER TO
SET ESCAPE OFF
RETURN
*Eof PROC050.PRG
