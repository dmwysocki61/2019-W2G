* Program Name: W2G0900
* Author:	David M. Wysocki
* Company:	Diversified Tech Systems, Inc.
* Purpose:	Set Up Payer Information
*
*
*#include "PTValue.ch"
*#include "PTColor.ch"
*#include "PTFuncs.ch"
*#include "PTInkey.ch"
*#include "PTFiles.ch"

function w2g0900()


memvar getlist

private PAYER      := Space (40)
private ADDRESS1   := SPACE (30)
private ADDRESS2   := SPACE (30)
private CITY       := SPACE (30)
private STATE      := SPACE (02)
private ZIP1       := SPACE (05)
private ZIP2       := SPACE (04)
private EIN1       := SPACE (02)
private EIN2       := SPACE (07)
private CHOICE     := SPACE (01)
private name_cntl  := space (04)
private tcc        := space (05)
private contact_nm := Space (40)
private contact_ph := Space (10)
private contact_em := Space (40)

cls

dbcloseall()

use payer.dbf

select 1

M->PAYER      := PAYER->NAME
M->ADDRESS1   := PAYER->ADDRESS1
M->ADDRESS2   := PAYER->ADDRESS2
M->CITY       := PAYER->CITY
M->STATE      := PAYER->STATE
M->ZIP1       := SUBSTR(PAYER->ZIP,1,5)
M->ZIP2       := SUBSTR(PAYER->ZIP,7,4)
M->EIN1       := SUBSTR(PAYER->EIN,1,2)
M->EIN2       := SUBSTR(PAYER->EIN,4,7)
m->name_cntl  := payer->name_cntl
m->tcc        := payer->tcc
m->state_tax  := payer->state_tax
m->laser      := payer->laser
m->contact_nm := payer->contact_nm
m->contact_ph := payer->contact_ph
m->contact_em := payer->contact_em


DO WHILE .T.

   @  0,20 SAY 'ENTER/UPDATE LEGAL ENTITY INFORMATION'
   @  2,00 SAY 'Enter Legal Entity Name'
   @  5,00 SAY 'Enter Legal Entity Address'
   @  9,00 SAY 'Enter Legal Entity City'
   @  9,42 SAY 'State'
   @  9,48 SAY 'Zip'
   @ 10,53 SAY '-'
   @ 12,00 SAY 'Enter Federal Employer Id Number:'
   @ 12,36 SAY '-'
   @ 14,00 Say 'Enter IRS Name Control, for Magnetic Media Reporting:'
   @ 16,00 Say 'Enter IRS Transmitter Control, for Magnetic Media Reporting:'
   @ 18,00 Say 'State Tax Withholding (Y/N)?'
   @ 20,00 Say 'Contact Email:'
   @ 22,00 Say 'Contact Name/Phone:'

   @  3,00 get m->payer
   @  6,00 get m->address1
   @  7,00 get m->address2
   @ 10,00 get m->city
   @ 10,42 get m->state      picture '!!'
   @ 10,48 get m->zip1       picture '99999'
   @ 10,54 get m->zip2       picture '9999'
   @ 12,34 get m->ein1       picture '99'
   @ 12,37 get m->ein2       picture '9999999'
   @ 14,54 get m->name_cntl  picture '!!!!'
   @ 16,61 get m->tcc	     picture '!!!!!'
   @ 18,29 get m->state_tax  picture '!'
   @ 20,15 get m->contact_em picture '!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!'
   @ 22,20 get m->contact_nm picture '!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!'
   @ 22,61 get m->contact_ph picture '999-999-9999'

   read
   
   do while .not. m->state_tax $'YN'
      @ 24,01 say "State Withholding Tax Indicator is invalid. Please enter 'Y' or 'N'."
	  @ 18,29 get m->state_tax picture '!'
	  read
   end-if

   @ 24,00 say 'Is the information correct (y/n)?'

   m->choice = ' '
   
   do while .not. m->choice $'YN'
      m->choice = ' '
      @ 24,45 get m->choice picture '!'
      read
   enddo
   
   if m->choice = 'Y'
      exit
   else
      loop
   endif

enddo

if reccount() = 0
   append blank
endif

replace payer->name	  with upper(m->payer)
replace payer->address1   with upper(m->address1)
replace payer->address2   with upper(m->address2)
replace payer->city	  with upper(m->city)
replace payer->state	  with upper(m->state)
replace payer->zip	  with m->zip1 + '-' + m->zip2
replace payer->ein	  with m->ein1 + '-' + m->ein2
replace payer->name_cntl  with m->name_cntl
replace payer->tcc        with m->tcc
replace payer->state_tax  with m->state_tax
replace payer->laser      with m->laser
replace payer->contact_nm with m->contact_nm
replace payer->contact_ph with m->contact_ph
replace payer->contact_em with m->contact_em

CLEAR
RETURN (nil)
* Eof: w2g.prg
