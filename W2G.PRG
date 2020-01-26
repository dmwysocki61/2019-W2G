* Program Name: W2G
* Author:       David M. Wysocki
* Company:      Diversified Tech Systems, Inc.
* Client:       
* Purpose:      This system allows access to the 1988 W2G winnings
*               database by payee name. It allows printing of individual
*               W2G forms.
function main()
* REQUEST DBFCDX
memvar getlist
setmode( 25,80 )

SET EPOCH TO 2000
SET CENTURY ON
SET COLOR TO W+/B // define the color
SET CURSOR ON // activate the screen

// cursor

SetMouse( .T. ) // activate the mouse

*if debug != nil
*   altd(1)
*else
*   altd(0)
*endif

altd(1)

cls

public keyf2     := -1
public keyf3     := -2
public keyf4     := -3
public keyf5     := -4
public payer     := space (45)
public choice    := space (01)
public state_tax := space (01)
public laser     := space (01)

* w2g0901 ()

USE PAYER

if reccount() = 0
  do w2g0900
else
  m->payer     = payer->name
  m->state_tax = payer->state_tax
  m->laser     = payer->laser
endif

DO W2G0100

DO WHILE .T.
   cls
   @  1,20  SAY M->PAYER
   @  2,20  SAY '2019 W2G DATA MANAGEMENT SYSTEM'
   @  4,20  SAY '1 - Batch Information Menu'
   @  6,20  SAY '2 - Database Reporting Menu'
   @  8,20  SAY '3 - Payee Information - W2G Reporting Menu'
   @ 10,20  SAY '4 - Database Error Reporting Menu'
   @ 12,20  SAY '5 - Create Magnetic Media'
   @ 14,20  SAY '6 - Enter/Update Legal Entity Information'
   @ 16,20  SAY 'X - Exit system.'
   @ 19,00  SAY '(C) Copyright Diversified Tech Systems, Inc. 1990. All rights reserved.'
   @ 21,00  SAY 'Use of this program is governed by the License Agreement printed in the'
   @ 22,00  SAY 'front of the user reference manual. Any unauthorized use will subject  '
   @ 23,00  SAY 'violator(s) to legal action.'

   M->CHOICE := ' '
   
   DO WHILE .NOT. M->CHOICE $'123456X'
      CHOICE := ' '
      @ 17,20  GET MEMVAR->CHOICE PICTURE '!'
      READ
   ENDDO
   
   DO CASE

       CASE CHOICE = '1'
            DO W2G0110
 
       CASE CHOICE = '2'
            DO W2G0120
 
       CASE CHOICE = '3'
           DO W2G0130

       CASE CHOICE = '4'
            DO W2G0700
 
       CASE CHOICE = '5'
            DO W2G0800
 
       CASE CHOICE = '6'
            DO W2G0900
 
       CASE CHOICE = 'X'
            EXIT
      ENDCASE
ENDDO
CLOSE DATABASES
CLEAR
return (nil)
* Eof: w2g.prg
