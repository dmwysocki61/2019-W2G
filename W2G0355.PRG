* Program Name: W2G0355
* Author:       David M. Wysocki
* Company:      Diversified Technical Services, Inc.
* Client:       Palm Beach Kennel Club
* Purpose:      Display Payee Data - Edit control Module
*
function w2g0355()
memvar getlist
m->rec_id  := space (9)
m->name    := space (32)
m->address := space (30)
m->city    := space (25)
m->state   := space (2)
m->zip     := space (5)
m->choice  := ' '
m->del_flg := ' '
m->ssn     := '999999999'
do while .t.
   select 1
   clear
   m->rec_id  = payee->record_id
   m->name    = ltrim(rtrim(payee->last_name))  + ', '  + ;
                ltrim(rtrim(payee->first_name)) + ' '   + ;
                ltrim(rtrim(payee->middle_int))
   m->address = payee->address
   m->city    = payee->city
   m->state   = payee->state
   m->zip     = payee->zip
   @  0, 29  SAY "PAYEE INQUIRY"
   @  1, 29  SAY "SCREEN OPTIONS"
   @  3, 18  SAY "1 - DISPLAY DETAIL WINNINGS INFORMATION."
   @  4, 18  SAY "2 - DISPLAY NEXT RECORD ON FILE."
   @  5, 18  SAY "3 - DISPLAY PREVIOUS RECORD ON FILE."
   @  6, 18  SAY "4 - UPDATE SSN ON DETAIL WINNINGS."
   @  7, 18  SAY "5 - UPDATE PAYEE INFORMATION."
   @  8, 18  SAY "6 - DELETE PAYEE FROM DATABASE."
   @  9, 18  SAY "7 - DISPLAY W2G FOR THIS PAYEE."
   @ 10, 18  SAY "8 - EXIT THIS MENU."
   @ 13,  0  SAY "SSN:"
   @ 13, 12  SAY  M->REC_ID
   @ 15,  0  SAY "NAME:"
   @ 15, 12  SAY  M->NAME
   @ 17,  0  SAY "ADDRESS:"
   @ 17, 12  SAY  M->ADDRESS
   @ 19,  0  SAY "CITY:"
   @ 19, 12  SAY  M->CITY
   @ 21,  0  SAY "STATE:"
   @ 21, 12  SAY  M->STATE
   @ 21, 16  SAY "ZIP:"
   @ 21, 21  SAY  M->ZIP
   m->choice = ' '
   do while .not. m->choice $'12345678'
      m->choice = ' '
      @ 11, 18  get  m->choice picture '9'
      read
   enddo
   do case
      case  m->choice = '1'
            m->ssn = payee->record_id
            do w2g0360

      case  m->choice = '2'
            skip

      case  m->choice = '3'
            skip -1

       case  m->choice = '4'
             m->ssn      = payee->record_id
             m->repl_ssn = space(9)
             do w2g0370
             if m->repl_ssn = space(9)
             else
                replace payee->record_id with m->repl_ssn
                m->rec_id = m->repl_ssn
             endif
 
       case  m->choice = '5'
             m->ssn = payee->record_id
             do w2g0380
 
       case  m->choice = '6'
             m->ssn = payee->record_id
             do w2g0385
 
      case  m->choice = '7'
            m->ssn = payee->record_id
            do w2g0390

      case  m->choice = '8'
            if m->del_flg = 'y'
               clear
               @ 7,20 say 'Working. one moment please.'
               set index to payee, name
               pack
            endif
            clear
            return (nil)
   endcase
enddo
clear
return (nil)
