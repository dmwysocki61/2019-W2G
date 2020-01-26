* Program Name: W2G0600
* Author:       David M. Wysocki
* Company:      Diversified Tech Systems, Inc.
* Client:       Flagler Kennel Club
* Purpose:      Display input screen.
function w2g0600()
memvar getlist
clear
@  1,  1  say "5754        STATEMENT BY PERSON(S) RECEIVING GAMBLING WINNINGS"
@  4,  1  say "Date Won"
@  4, 16  say "Type of Winnings"
@  4, 45  say "Cashier"
@  4, 53  say "Window"
@  4, 65  say "Race"
@  8,  1  say "First Name"
@  8, 14  say "Int"
@  8, 18  say "Last Name"
@  8, 45  say "Address"
@ 10,  1  say "S.S.N"
@ 10, 13  say "First I.D."
@ 10, 27  say "Second I.D."
@ 10, 45  say "City"
@ 10, 71  say "State"
@ 12, 45  say "Zip"
@ 13,  1  say 'F2:->Clear trans. F3:->Exit trans input.'
@ 15,  1  say "Amount"
@ 15, 22  say "Federal Income"

@ 16,  1  say "Received"
@ 16, 22  say "Tax Withheld"

@ 21,  1  say "Control Total Gross:"
@ 21, 40  say "Batch Total Gross:"
@ 22,  1  say "Control Total Federal:"
@ 22, 40  say "Batch TOTAL Federal:"


@ 21, 22  say m->ctl_grs  picture '9,999,999.99'
@ 22, 22  say m->ctl_fed  picture '9,999,999.99'

@ 21, 65  say m->b_gross  picture '9,999,999.99'
@ 22, 65  say m->b_fed    picture '9,999,999.99'

if m->state_tax = 'Y'
   @ 15, 43  say "State Income"
   @ 16, 43  say "Tax Withheld"
   @ 23,  1  say "Control Total State:"
   @ 23, 40  say "Batch Total State:"
   @ 23, 22  say m->ctl_sta  picture '9,999,999.99'
   @ 23, 65  say m->b_state  picture '9,999,999.99'
end-if

@  0,  0  TO  2, 79    DOUBLE
@  3,  0  TO  6, 79
@  7,  0  TO 12, 42
@  7, 43  TO 13, 79
@ 14,  0  TO 18, 79
@ 20,  0  TO 24, 79    DOUBLE
return(nil)
* EOF W2G0600.PRG
