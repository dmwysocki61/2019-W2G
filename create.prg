* Program Name: create.prg
* Author:       David M. Wysocki
* Company:      Diversified Technical Service, Inc.
* Client:       
* Purpose:      create additional ticket records.
*
*
function create()
memvar getlist
set escape on
set date american
set scoreboard off
private race       := 0
private cashier    := 0
private window     := 0
private ssn_format := space (11)
private rec_id     := space (09)
private trans      := space (10)
private l_name     := space (25)
private f_name     := space (15)
private init       := space (2)
private address    := space (30)
private city       := space (25)
private state      := space (02)
private zip        := space (05)
private first_id   := space (15)
private scnd_id    := space (15)
private tkt_gross  := 0.00
private tkt_fed    := 0.00
private tkt_state  := 0.00
private b_date     := date()
private b_number   := 0
private perf_num   := space (01)
clear
select 1
use payee index payee
select 2
use ticket index ticket
select 1
do while .not. eof()
   m->loop := 0
   select 2
   do while m->loop <= 20 .and. .not. eof()
      	append blank
		replace ticket->record_id  with payee->record_id
		replace ticket->gross      with m->tkt_gross
		replace ticket->fed_with   with m->tkt_fed
		replace ticket->sta_with   with m->tkt_state
		replace ticket->date_won   with m->b_date
		replace ticket->trans      with m->trans
		replace ticket->race       with m->race
		replace ticket->cashier    with m->cashier
		replace ticket->window     with m->window
		replace ticket->batch_date with m->b_date
		replace ticket->batch_num  with m->b_number
		replace ticket->perf_num   with m->perf_num
		++m->loop
	enddo
	select 1
	skip
enddo

clear
return (nil)
* eof create.prg
