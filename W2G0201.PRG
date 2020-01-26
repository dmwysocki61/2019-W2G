* Program Name: W2G0201
* Author:       David M. Wysocki
* Company:      Diversified Technical Service, Inc.
* Client:       Palm Beach Kennel Club
* Purpose:      Batch Input Control Module.
*
*
function w2g0201()
memvar getlist
local aArray_in   := array(15)
LOCAL aName, aSize, aDate, aTime, aAttr, nLen, i

private cString   := space(15)
public  m_f2      := ' '
public  m_f3      := ' '
public  m_f4      := ' '
public  choice    := ' '
public  ctl_grs   := 0
public  ctl_fed   := 0
public  ctl_sta   := 0
private fhndl_in  := 0
private fhndl_out := 0
private reccount  := 0
private fname_in  := space(40)
private fname_out := space(20)
private frecin    := space(200)
private time      := space(08)
private fvalue    := space(50)
private ftab      := chr(09)
private endrec    := chr(13)+ chr(10)
private tabcount  := 0
private loop_cnt  := 0
private rec_cnt   := 0
private comma_loc := 0
private amount_len:= 0
private array_len := 0
private f_error   := 0
private row       := 0

public  b_date    := date()
public  b_number  := 0

public  b_gross   := 0
public  b_fed     := 0
public  b_state   := 0

private gross     := 0
private fed_with  := 0
private sta_with  := 0
private date_won  := date()
private trans     := space(10)
private rate      := 0
private winnings  := 0
private cashier   := 0
private window    := 0
private perf_num  := space(04)

private last_name := space(25)
private first_name:= space(12)
private middle_int:= space(02)
private address   := space(30)
private city      := space(25)
private state     := space(02)
private zip       := space(05)
private first_id  := space(15)
private second_id := space(15)

set key m->keyf2 to proc010
set key m->keyf3 to proc020
set key m->keyf4 to proc030

do w2g0300

set key m->keyf4 to 

IF M->M_F2 = 'Y'
   CLEAR
   RETURN (NIL)
ENDIF
*
* Call module to accept batch control totals. Write batch control record.
*
DO W2G0310

IF M->M_F2 = 'Y'
   CLEAR
   RETURN (NIL)
ENDIF

IF M->CHOICE = 'X'
   CLEAR
   RETURN (NIL)
ENDIF

set key m->keyf2 to proc010
set key m->keyf3 to proc020
set key m->keyf4 to proc030

m->nLen := ADir( "c:\temp\*.csv" )     // Number of JPG files in this directory

IF m->nLen > 0
   m->aName := Array( m->nLen )   // make room to store the information
   m->aSize := Array( m->nLen )
   m->aDate := Array( m->nLen )
   m->aTime := Array( m->nLen )
   m->aAttr := Array( m->nLen )
   
   ADir("c:\temp\*.csv", m->aName, m->aSize, m->aDate, m->aTime, m->aAttr)

   cls
   @ 0,22 Say "CSV FILES PRESENT IN C:\TEMP FOLDER"
   @ 2,00 say "File Name"
   @ 2,20 say "File Size"
   @ 2,35 say "Date"
   @ 2,50 say "Time"
   @ 2,70 say "Attrib"
   
   m->row = 4
   
   FOR m->i := 1 TO m->nLen
      @m->row, 00 say m->aName[ m->i ]
      @m->row, 20 say m->aSize[ m->i ] picture '999,999'
      @m->row, 35 say m->aDate[ m->i ]
      @m->row, 50 say m->aTime[ m->i ]
      @m->row, 70 say m->aAttr[ m->i ]
      m->row += 2
   NEXT

ELSE
      @2, 00 say "No CSV files exist in this directory."
ENDIF


* Call module to accept batch control key fields and confirm batch does not currently exist.

select 1
use payee index payee, name

select 2
use ticket index ticket, batchid

select 3
use batchctl index batchctl

m->fname_in := space(40)
m->row      += 2
m->choice   := 'N'

DO WHILE m->choice = 'N'

   @ m->row,00 say "File to process: (include full path)"
   @ m->row,40 get m->fname_in picture '!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!'
   @ 24,00 say "Press F2 to Exit."
   read

   IF M->M_F2 = 'Y'
      CLEAR
      RETURN (NIL)
   ENDIF

   IF ft_FUse( m->fname_in ) < 0     // open text file
      m->f_error := ft_FError()
      @m->row, 0 clear
      @m->row, 0 say "Error opening file " + m->fname_in + ", error code (" + hb_ntos(m->f_error ) + ")"
      wait
      LOOP
   ELSE
      @m->row, 0 clear
      @ m->row,0 say "File open successful"
      m->choice := "Y"
      wait
   endif
enddo   

m->rec_cnt := 0

DO WHILE ! ft_FEof()
   m->rec_cnt += 1

   m->fname_in := ft_FReadLn()
   aArray_in := hb_atokens(m->fname_in,"|")

   if m->rec_cnt = 1
      ft_FSkip()
   else
      if aArray_in [1] = "Batch"
        m->rec_cnt -= 2
	@ 10,00 clear
	@ 10,00 SAY 'End of File. Processing complete.'

	@ 12,00 say 'm->rec_cnt: '
	@ 12,20 say  m->rec_cnt picture '999,999.99'

	@ 14,00 say 'Batch Gross: '
	@ 14,20 SAY  m->b_gross PICTURE '999,999.99'

	@ 16,00 say 'Batch Fed: '
	@ 16,20 say  m->b_fed   picture '999,999.99'

	exit
      else   
         m->record := substr(aArray_in[4],1,3) + ;
                      substr(aArray_in[4],5,2) + ;
                      substr(aArray_in[4],8,4)
 
         select 1
         
         if NumToken(RemAll(m->record,' '),' ') = 0
            @ 22,0 say 'Error encountered. Record missing SSN. Please update file and reprocess.'
            @ 23,0 say 'Processing terminated at record: '
            @ 23,50 say m->rec_cnt picture '999,999.99'
            wait
            exit
         end-if
         
         seek m->record
 
	 IF EOF()
	    append blank
	    replace payee->record_id  with m->record
	    replace payee->last_name  with aArray_in[5]
	    replace payee->first_name with aArray_in[6]
	    replace payee->middle_int with space(02)
	    replace payee->address    with aArray_in[7]
	    replace payee->city       with aArray_in[8]
	    replace payee->state      with aArray_in[9]
	    replace payee->zip        with aArray_in[10]
	 else
	    replace payee->last_name  with aArray_in[5]
	    replace payee->first_name with aArray_in[6]
	    replace payee->middle_int with space(02)
	    replace payee->address    with aArray_in[7]
	    replace payee->city       with aArray_in[8]
	    replace payee->state      with aArray_in[9]
	    replace payee->zip        with aArray_in[10]
	 EndIf   
    
         select 2
         append blank
 
         replace ticket->record_id	with m->record
         replace ticket->batch_date     with m->b_date
         replace ticket->batch_num      with m->b_number

	* parse gross winnings amount
 	 m->cString     := aArray_in[11]
 	 m->gross	:= Val(m->cString)
	 m->b_gross	+= m->gross
 
	 replace ticket->gross with m->gross
 
	* parse federal withholding amount

	 m->cString             := aArray_in[12]
	 m->fed_with		:= Val(m->cString)
 	 m->b_fed               += m->fed_with
 
	 replace ticket->fed_with       with m->fed_with
	 replace ticket->sta_with       with 0
	 replace ticket->date_won       with m->b_date
	 replace ticket->trans          with 'Batch Upld'
	 replace ticket->race           with 0
	 replace ticket->winnings       with ' '
	 replace ticket->cashier        with 0
	 replace ticket->window         with 0
	 replace ticket->perf_num       with m->perf_num

         ft_FSkip()
      endif
   endif
ENDDO

DO W2G0330

CLOSE DATABASES

CLEAR

RETURN (NIL)