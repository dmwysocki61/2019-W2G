* Program Name: W2G0255
* Author:       David M. Wysocki
* Company:      Diversified Technical Service, Inc.
* Client:       Palm Beach Kennal Club
* Purpose:      Database Reporting - Report by Batch Selection - Page Header
*
*
function w2g0255()
memvar getlist

m->l_number = 8
m->p_number = m->p_number + 1
select 4

@  1,000 say 'Report date: '
@  1,015 say m->r_date
@  1,040 say payer->name

@  1,130 say 'Page: '
@  1,135 say m->p_number              picture '999'

@  2,000 say 'Batch Date: '
@  2,015 say m->b_date

@  3,000 say 'Batch Number:'
@  3,015 say m->b_number              picture '999'

@  4,000 say 'Performance number: '
@  4,024 say m->perf_num              picture '9999'
@  4,040 say 'Inquiry by Batch Date and Number - Detail listing'

@  5,103 say 'Gross'
@  5,117 say 'Federal'
@  5,130 say 'State'

@  6,001 say 'Payee SSN'
@  6,011 say 'Name'
@  6,045 say 'Address'
@  6,075 say 'City, State'
@  6,103 say 'Winnings'
@  6,117 say 'Withholding'
@  6,130 say 'Withholding'

@  7,001 say '---------'
@  7,011 say '---------------------------------'
@  7,045 say '-----------------------------'
@  7,075 say '---------------------------'
@  7,103 say '-------------'
@  7,117 say '------------'
@  7,130 say '-------------'
return (nil)
* eof w2g0255
