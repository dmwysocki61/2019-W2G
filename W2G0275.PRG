* Program Name: W2G0275
* Author:       David M. Wysocki
* Company:      Diversified Technical Service, Inc.
* Client:       Palm Beach Kennal Club
* Purpose:      Database Reporting - Report by Date Range - Page Header
*
*
function w2g0275()
memvar getlist
m->l_number = 7
m->p_number = m->p_number + 1
select 4
@  0,0
@  0,002 say 'Report date: '
@  0,017 say  m->r_date
@  0,046 say payer->name
@  0,112 say 'Page: '
@  0,118 say m->p_number picture '999'
@  2,046 say 'Inquiry by Batch Date - Summary Listing'
@  4,001 say 'Batch'
@  4,010 say 'Batch'
@  4,020 say 'Gross'
@  4,035 say 'Federal'
@  4,050 say 'State'

@  5,001 say 'Date'
@  5,010 say 'Number'
@  5,020 say 'Winnings'
@  5,035 say 'Withholding'
@  5,050 say 'Withholding'

@  6,001 say '----'
@  6,010 say '------'
@  6,020 say '--------'
@  6,035 say '-----------'
@  6,050 say '-----------'
return (nil)
* eof w2g0275
