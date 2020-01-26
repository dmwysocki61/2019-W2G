* Program Name: W2G0200
* Author:       David M. Wysocki
* Company:      Diversified Technical Service, Inc.
* Client:       Palm Beach Kennel Club
* Purpose:      Batch Input Control Module.
*
*

function w2g0200()

MEMVAR GETLIST
PUBLIC  M_F2     := ' '
PUBLIC  M_F3     := ' '
PUBLIC  M_F4     := ' '
PUBLIC  CHOICE   := ' '
CLEAR

* PROC030 Displays batch control records for existing batches 
* matching date input

SET KEY M->KEYF2 TO PROC010
SET KEY M->KEYF4 TO PROC030

* Call module to accept batch date and number
DO W2G0300

SET KEY M->KEYF4 TO

IF M->M_F2 = 'Y'
   CLEAR
   RETURN (NIL)
ENDIF

* Call module to accept batch control totals. Write batch control record.

DO W2G0310

IF M->M_F2 = 'Y'
   CLEAR
   RETURN (NIL)
ENDIF

IF M->CHOICE = 'X'
   CLEAR
   RETURN (NIL)
ENDIF

DO W2G0320

DO W2G0330

CLOSE DATABASES

CLEAR

RETURN (NIL)
*EOF W2G0200.PRG
