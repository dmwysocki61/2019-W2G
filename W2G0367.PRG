* Program Name: W2G0367
* Author:       David M. Wysocki
* Company:      Diversified Technical Service, Inc.
* Client:       Palm Beach Kennal Club
* Purpose:      Database Reporting - List Detail Winnings Header
*
*
function w2g0367()
memvar getlist
m->p_number := 0
m->l_number := 10
m->p_number := m->p_number + 1

@  1,001 say 'Date: '+ dtoc(m->r_date)
@  1,025 say m->payer
@  1,105 say 'Page: ' + str(m->p_number,3)

@  2,025 say 'Detail Winnings Summary for:'
@  3,025 say rtrim(payee->last_name)  + ',' + ; 
             rtrim(payee->first_name) + ' ' + ;
             rtrim(payee->middle_int)
@  4,025     say payee->address
@  5,025     say rtrim(payee->city) + ',' + payee->state + ' ' + payee->zip
@  6,025     say 'Identification: ' + payee->first_id
@  8,001 say 'SSN'
@  8,015 say 'Date Won'
@  8,025 say 'Gross Winnings'
@  8,040 say 'Federal Withholding'
@  8,060 say 'State Withholding'
@  8,080 say 'Transaction'
@  8,093 say 'Race'
@  8,100 say 'Cashier'
@  8,110 say 'Window'



@  9,001 say '----------'
@  9,015 say '---------'
@  9,025 say '--------------'
@  9,040 say '-------------------'
@  9,060 say '-------------------'
@  9,080 say '-----------'
@  9,093 say '----'
@  9,100 say '-------'
@  9,110 say '------'

return (nil)
* eof w2g0367
