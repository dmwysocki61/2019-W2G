function sum1()

memvar getlist



m->m_acct1 = 0.00
m->m_acct2 = 0.00
m->m_acct3 = 0.00
m->rec_cnt_payee = 0
m->rec_cnt_ticket = 0

clear

@ 0,29 say 'Database Totals Screen'
@ 7,15 say 'Working, one moment please....'

use payee index payee
pack

m->rec_cnt_payee = lastrec()

use ticket index ticket
pack

m->rec_cnt_ticket = lastrec()

sum ticket->gross, ticket->fed_with, ticket->sta_with ;
    to m->m_acct1, m->m_acct2, m->m_acct3
    
@ 2,00 clear
@ 2,00 say 'Total Gross Winnings:'
@ 4,00 say 'Total Federal Withholding:'
@ 6,00 say 'Total State Withholding:'
@ 8,00 say 'Total Payee Records:'
@10,00 say 'Total Ticket Records:'

@ 2,30 say m->m_acct1 picture '99,999,999.99'
@ 4,30 say m->m_acct2 picture '99,999,999.99'
@ 6,30 say m->m_acct3 picture '99,999,999.99'
@ 8,30 say m->rec_cnt_payee  picture '99,999,999.99'
@10,30 say m->rec_cnt_ticket picture '99,999,999.99'
@11,00 say ' '
wait
close databases
return (nil)
