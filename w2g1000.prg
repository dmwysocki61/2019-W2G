function w2g1000 ()
// Define variables

STATIC nSpace
LOCAL bErrorHandler, BLastHandler, objerr, bBlock
PRIVATE time := SPACE (08)
// Clear Screen
// Define error handler code block
bErrorHandler := {|objError| Diskerror(objError)}
// Define disk space code block
bBlock := {|nDisk,nSpace| DISKSPACE(nDisk)-2048}
// Save default error handler code block
bLastHandler := ERRORBLOCK(bErrorHandler)
// Open File



private hold1 := space(9)
private hold2 := space(9)
private hold3 := space(9)
private hold4 := space(8)
private hold5 := space(8)
private hold6 := space(8)
private fhndl := space(13)   
private fname := space(06)   
private fext1 := space(03)   
private fext2 := space(03)   
private disk  := 1   
private space := 0   
private recco := 0   
private recs  := 0   
private endrec := 0  
private recpos := 0  
private r      := 0  
private drive  := space(01)  



select 1
use payee index payee
select 2
use ticket index ticket
select 3
use payer
select 4
use micha
select 5
use miche
select 6
use michs
sekect 7
use michrec

select 4
append blank
replace micha->record_id  with 'A'
replace micha->payment_yr with '1999'
replace micha->trnsmt_ein with m->ein
replace micha->blank1     with space(9)
replace micha->trnsmt_nm  with payer->name
replace micha->trnsmt_adr with payer->address1
replace micha->trnsmt_cty with payer->city
replace micha->trnsmt_st  with payer->state
replace micha=>blank2     with space(13)
replace micha->trnsmt_zip with payer->zip
replace micha->blank3     with space(118)

copy to arecord.txt sdf
zap

select 5
replace miche->record_id  with 'E'
replace miche->payment_yr with '1999'
replace miche->trnsmt_ein with m->ein
replace miche->blank1     with space(9)
replace miche->trnsmt_nm  with payer->name
replace miche->blank2     with space(203)

copy to erecord.txt sdf

select 1
do while .not. eof()
   select 2
   seek payee->record
   if eof()
      @24,0 clear
      @24,0 say 'w2g1000.1 Ticket data not found for payee:' + payee->record_id
      wait
      quit
   end-if
   do while ticket->record_id = payee->record_id
      if ticket->sta_with > 0
         m->sta_with += ticket->sta_with
         m->gross    += ticket->gross
         select 6
         append blank
         replace michs->record_id  with 'S'
         replace michs->ssn        with payee->record_id
         replace michs->name       with rtrim(first_name,' ') + ;
                                       rtrim(middle_int,' ') + ;
                                       rtrim(last_name,' ')
         replace michs->address    with payee->address
         replace michs->city       with payee->city
         replace michs->state      with payee->state
         replace michs->zip        with payee->zip
         replace michs->state_code with '26'

         m->hold1 = space(09)
         m->hold2 = space(09)
         m->hold3 = space(09)

         m->hold1 = transform(ticket->gross,"*******.**")

         m->hold2 = strtran(m->hold1,'*','0')
         m->hold3 = strtran(m->hold2,'.')

         replace michs->gross      with m->hold3                                              

         m->hold4 = space(08)
         m->hold5 = space(08)
         m->hold6 = space(08)

         m->hold4 = transform(ticket->sta_with,"******.**")

         m->hold5 = strtran(m->hold4,'*','0')
         m->hold6 = strtran(m->hold5,'.')

     	 replace michs->sta_with   with m->m_hold5

         replace michs->blank1     with space(009)
         replace michs->blank2     with space(060)
         replace michs->blank3     with space(075)
         select 2
         skip
   enddo
   select 1
   skip
enddo
select 6
goto top
copy to srecord.txt sdf
zap

select 7
zap
append from arecord.txt sdf
erase arecord.txt

append from erecord.txt sdf
erase erecord.txt

append from srecord.txt sdf
erase srecord.txt

goto top

clear
@ 1,0 SAY 'Enter letter of target drive to use, Enter X to exit (i.e. A,B,C):'

DO WHILE .NOT. M->drive $'ABCDX'
   M->drive = ' '
   @ 1,69  GET M->drive PICTURE '!'
   read
ENDDO

if M->drive = 'X'
   M->time = time()
   @ 2,0 Say 'Program terminated by user request at ' + M->time 
   close databases
   wait
   return(nil)
endif

DO WHILE .NOT. EOF()
   M->FEXT1  = TRANSFORM(M->DISK,"***")
   M->FEXT2  = STRTRAN  (M->FEXT1,'*','0')
   M->FNAME  = 'IRSTAX'
   M->FHNDL  = 'A:\' +  M->FNAME + '.' + M->FEXT2
   M->lFirstTry := .T.
   M->lRetry    := .T.
   M->tries     := 0
   DO WHILE M->lRetry
      begin sequence
        M->FHNDL  = M->drive + ':\' +  M->FNAME + '.' + M->FEXT2
        @ 2,0 clear
        @ 2,0 SAY 'Place diskette' + str(M->disk,2) ;
                                   + ' in drive '   ;
                                   + M->drive       ; 
                                   + ':'
        wait
        M->space = EVAL(M->bBlock,1,M->Space)
        @ 3,00 clear
        @ 3,00 say 'Disk space available on drive ' + M->drive + ':'
        @ 3,33 say M->space picture '9,999,999'
        M->lRetry := .F.
      recover
        M->lRetry := .T.
        M->tries  := M->tries + 1
        if M->tries = 3
           @ 5,0 say 'Program terminated'
           quit
        else
           @ 3,00 clear
           @ 3,00 say 'Drive not ready, please re-check.'
           wait
        endif
      end
      if M->lRetry = .F.
         if M->space = 1455616 .or. M->space = 728064
         else
            @ 5,00 clear
            @ 5,00 say 'Disk in drive is not blank. Please use a blank, formatted diskette.'
            wait
            M->lFirstTry := .T.
            M->lRetry    := .T.
            M->tries     := 0
            loop
         endif
      endif
   enddo
   M->RECCO  = M->SPACE / 276
   M->ENDREC = RECNO() + INT(M->RECCO)
   @ 5,00 CLEAR
   @ 5,00 Say 'Start Processing'
   @ 5,01 SAY 'Writing diskette ' + str(M->disk,2)
   COPY TO &FHNDL SDF WHILE RECNO() < M->ENDREC .AND. .NOT. EOF()
   M->DISK = M->DISK + 1
ENDDO
@ 5,00 clear 
@ 5,00 say 'Processing complete.'
wait
return (nil)
         