* Program Name: W2G0850
* Author:       David M. Wysocki
* Company:      Diversified Tech Systems, Inc.
* Client:       Palm Beach Kennel Club, Inc.
* Purpose:      Create Magnetic Media - F records
*
FUNCTION W2G0850()
#include "fileio.ch"
MEMVAR GETLIST

// Define variables
STATIC nSpace
LOCAL bErrorHandler, BLastHandler, objerr, bBlock
PRIVATE time := SPACE (08)
// Clear Screen
// Define error handler code block
//bErrorHandler := {|objError| Diskerror(objError)}
// Define disk space code block
//bBlock := {|nDisk,nSpace| DISKSPACE(nDisk)-2048}
// Save default error handler code block
//bLastHandler := ERRORBLOCK(bErrorHandler)
// Open File

m->time := time()
@ 23,0 SAY 'COPYING TO TEMPORARY DATABASE.... ' + m->time
SELECT 7
ZAP
append from trecord.txt sdf
erase trecord.txt

APPEND FROM ARECORD.TXT SDF
ERASE ARECORD.TXT

APPEND FROM BRECORD.TXT SDF
ERASE BRECORD.TXT

APPEND FROM CRECORD.TXT SDF
ERASE CRECORD.TXT

* append from krecord.txt sdf
erase krecord.txt

APPEND FROM FRECORD.TXT SDF
ERASE FRECORD.TXT
GOTO TOP

PRIVATE FHNDL    := ' '
PRIVATE FNAME    := SPACE(06)
PRIVATE FEXT1    := SPACE(03)
PRIVATE FEXT2    := SPACE(03)
PRIVATE DISK     := 1
PRIVATE SPACE    := 0
PRIVATE RECCO    := 0
PRIVATE RECS     := 0
PRIVATE ENDREC   := 0
PRIVATE RECPOS   := 0
PRIVATE R        := 0
PRIVATE drive    := ' '
private curr_rec := 0
private error    := 0

   
@ 2,00 clear
@ 5,00 say 'Creating Federal data file. '

m->fhndl := "C:\TEMP\IRSTAX.001"

ferase(m->fhndl)

IF FErase( "c:\temp\irstax.001" ) == 0
   @ 7,00 say "File successfully erased"
ELSE
*   m->error := ferror()
*   @ 7,00 say "File can not be deleted"
*   @ 9,00 say "Error: "
*   @ 9,10 say m->error
ENDIF
wait

*m->error := ferror()

*if m->error = 3
*   run 'MD C:\TEMP'
*   @ 3,00 clear
*   @ 3,00 Say 'C:\TEMP folder created.'
*   m->error := ferror()
*   if m->error <> 0
*      @ 03,00 say 'Could not create directory C:\TEMP on your system hard drive.'
*      @ 04,00 say 'This directory must exist prior to running the magnetic media.'
*      @ 05,00 say 'Contact your system administrator to resolve and re-run.'
*      quit
*   endif
*end-if

copy to &fhndl sdf while .not. eof()

fclose(m->fhndl)

m->error := ferror()

if m->error <> 0
   @ 03,00 clear
   @ 03,00 say 'Error closing file C:\TEMP\IRSTAX.001 on your system hard drive.'
   @ 05,00 say 'Contact your system administrator to resolve and re-run.'
   @ 07,00 say 'File Error: '
   @ 07,15 say m->error
   quit
endif

@ 0,0 clear
@ 0,0 SAY 'Total Gross Winnings: '
@ 2,0 SAY 'Total Federal Withholding: '
@ 4,0 say 'Total State Withholding: '
@ 6,0 SAY 'Total number of Payees: '
@ 0,40 SAY m->TOT_GRS PICTURE '999,999,999.99'
@ 2,40 SAY m->TOT_FED PICTURE '999,999,999.99'
@ 4,40 say m->tot_sta picture '999,999,999.99'
@ 6,40 SAY m->REC_CNT PICTURE '    999,999.99'
@ 8,00 SAY 'NOTE THESE FIGURES...... YOU WILL NEED THEM FOR FORM 4804.'
WAIT
ZAP

return(nil)

*EOF W2G0850.PRG