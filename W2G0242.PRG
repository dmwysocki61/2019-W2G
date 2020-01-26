* Program Name: W2G0242
* Author:       David M. Wysocki
* Company:      Diversified Technical Service, Inc.
* Client:       Palm Beach Kennal Club
* Purpose:      Database Reporting - Report by Last Name - Page Header
*
*
function w2g0242()
memvar getlist
select 4
m->l_number = 8
m->p_number = m->p_number + 1

@  1,001 say 'Date: ' + dtoc(date())
@  1,046 say payer->name
@  1,135 say 'Page: '+ str(m->p_number,3)

if m->choice = 'D'
   @  2,046 say 'Report by last name - Detail listing'
else
   @  2,046 say 'Report by last name - Summary listing'
endif

@  4,077 say 'Date'
@  4,087 say 'Perf'
@  4,105 say 'Gross'
@  4,120 say 'Federal'
@  4,135 say 'State'

@  5,000 say 'Name'
@  5,035 say 'Payee SSN'
@  5,045 say 'Address'
@  5,077 say 'Cashed'
@  5,087 say 'Number'
@  5,095 say 'Cashier'
@  5,105 say 'Winnings'
@  5,120 say 'Withholding'
@  5,135 say 'Withholding'

@  6,000 say '---------------------------------'
@  6,035 say '---------'
@  6,045 say '-----------------------------'
@  6,077 say '--------'
@  6,087 say '------'
@  6,095 say '-------'
@  6,105 say '----------'
@  6,120 say '-----------'
@  6,135 say '-----------'

return (nil)
* eof w2g0242
