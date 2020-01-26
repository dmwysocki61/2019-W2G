* Program Name: W2G0370
* Author:       David M. Wysocki]
* Company:      Diversified Technical Services, Inc.
* Client:       Palm Beach Kennel Club
* Purpose:      UPDATE SOCIAL SECURITY NUMBER
*
*
FUNCTION W2G0370()
MEMVAR GETLIST
SET INTENSITY OFF
private fed   := 0.00
private gross := 0.00
private state := 0.00

select 3
append blank

replace audit->old_rec_id   with m->ssn
replace audit->date_updt    with date()
replace audit->time_updt    with time()

clear
select 2

seek m->ssn

if eof()
   @ 11, 1 say 'the following social security number has no data!!!'
   @ 12, 1 say m->ssn
   wait
   clear
   select 1
   return (nil)
endif

M->NEWSSN  = SPACE (9)
M->NEWSSN2 = SPACE (9)
@ 3,5  SAY 'TO CHANGE THIS SSN ON WINNINGS DETAIL INFORMATION,'
@ 4,5  SAY 'ENTER THE NEW SSN'
@ 6,5  SAY M->SSN
@ 6,25 GET M->NEWSSN
@ 8,5  SAY M->NAME
READ
CLEAR
IF M->NEWSSN = SPACE(9)
   SELECT 1
   RETURN (NIL)
ELSE
   M->NEWSSN2 = M->NEWSSN
   M->NEWSSN  = SPACE(9)
   @ 3, 5 SAY 'PLEASE VERIFY THE SSN CHANGE BY RE-ENTERING THE   '
   @ 4, 5 SAY 'NEW SSN'
   @ 6, 5 SAY  M->SSN
   @ 6,25 GET  M->NEWSSN
   @ 8, 5 SAY  M->NAME
   READ
   CLEAR
   IF M->NEWSSN = M->NEWSSN2
   ELSE
      @ 5,5 SAY 'THE SSN YOU LAST ENTERED DID NOT VERIFY CORRECTLY'
      WAIT
      CLEAR
      SELECT 1
      RETURN (NIL)
   ENDIF
ENDIF

DO WHILE .T.
   M->UPDATE = 'N'
   @  0, 12  SAY "WINNINGS DETAIL UPDATE SCREEN"
   @  3, 12  SAY "OLD SSN:"
   @  3, 21  SAY  TICKET->RECORD_ID
   @  3, 32  SAY "NEW SSN:"
   @  3, 41  SAY  M->NEWSSN
   @  5, 12  SAY "GROSS:"
   @  5, 25  SAY  TICKET->GROSS
   @  7, 12  SAY "FED. WITH.:"
   @  7, 25  SAY  TICKET->FED_WITH
   @ 10, 12  SAY "DO YOU WISH TO CHANGE THE OLD SSN TO THE NEW SSN"
   @ 11, 12  SAY "ENTER Y TO CHANGE, N TO PROCESS THE NEXT DETAIL"
   @ 12, 12  SAY "RECORD, OR X TO EXIT."
   @ 13, 40  GET  M->UPDATE PICTURE '!'
   READ
   IF .NOT. M->UPDATE $ 'YNX'
      LOOP
   ELSE
      IF M->UPDATE = 'X'
         CLEAR
         SELECT 1
         RETURN (NIL)
      ELSE
         IF M->UPDATE = 'N'
            SKIP
            IF EOF()
               CLEAR
               @ 12,20 SAY 'END OF DATA FOR THIS SSN NUMBER.'
               WAIT
               EXIT
            ELSE
               IF TICKET->RECORD_ID = M->SSN
                  LOOP
               ELSE
                  CLEAR
                  @ 12,20 SAY 'END OF DATA FOR THIS SSN NUMBER.'
                  WAIT
                  EXIT
               ENDIF
            ENDIF
         ELSE
            REPLACE TICKET->RECORD_ID WITH M->NEWSSN
            M->GROSS = TICKET->GROSS
            M->FED   = TICKET->FED_WITH
            SELECT 3
            REPLACE AUDIT->OLD_GROSS  WITH M->GROSS
            REPLACE AUDIT->OLD_FED    WITH M->FED
            REPLACE AUDIT->NEW_REC_ID WITH M->NEWSSN
            REPLACE AUDIT->NEW_GROSS  WITH M->GROSS
            REPLACE AUDIT->NEW_FED    WITH M->FED
            SELECT 2
            M->REPLSSN = M->NEWSSN
            GO TOP
            SEEK M->SSN
            IF EOF()
               CLEAR
               @ 12,20 SAY 'END OF DATA FOR THIS SSN NUMBER.'
               WAIT
               EXIT
            ELSE
               LOOP
            ENDIF
         ENDIF
      ENDIF
   ENDIF
ENDDO

SELECT 1
CLEAR
RETURN (NIL)
