* Program Name: W2G0265
* Author:       David M. Wysocki
* Company:      Diversified Technical Service, Inc.
* Client:       Palm Beach Kennal Club
* Purpose:      Database Reporting - Report by Batch Date - Page Header
*                                    Detail Listing
*
function w2g0265()
memvar getlist
m->l_number = 7
m->p_number = m->p_number + 1
select 4
@  1,0
@  1,002 say 'Report date: '
@  1,017 say m->r_date
@  1,046 say payer->name
@  1,112 say 'Page: '
@  1,118 say m->p_number picture '999'
@  2,046 say 'Inquiry by Batch Date - Detail Listing'
@  4,011 say 'Batch'
@  4,025 say 'Batch'
@  4,036 say 'Gross'
@  4,052 say 'Federal'
@  4,065 say 'State'
@  4,080 say 'Performance'

@  5,001 say 'Payee SSN'
@  5,011 say 'Date'
@  5,025 say 'Number'
@  5,036 say 'Winnings'
@  5,052 say 'Withholding'
@  5,065 say 'Withholding'
@  5,080 say 'Number'

@  6,001 say '---------'
@  6,011 say '--------'
@  6,025 say '------'
@  6,036 say '--------'
@  6,052 say '-----------'
@  6,065 say '-----------'
@  6,080 say '------'
return (nil)
* eof w2g0265
