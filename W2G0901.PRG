function w2gupdt ()

local   aStru     := {}                    // Create Empty Array
local   aGauge
local   nStart

cls

aGauge := gaugenew(maxrow()-3, 0, maxrow()-1, maxcol())

dbcloseall()

select 1
use payer

if FieldExists('STATE_TAX') .and. ;
   FieldExists('LASER')
else 
   aadd( aStru, {"NAME",        "C", 45, 0} )
   aadd( aStru, {"ADDRESS1",    "C", 30, 0} )
   aadd( aStru, {"ADDRESS2",    "C", 30, 0} )
   aadd( aStru, {"CITY",        "C", 30, 0} )
   aadd( aStru, {"STATE",       "C", 02, 0} )
   aadd( aStru, {"ZIP",         "C", 10, 0} )
   aadd( aStru, {"EIN",         "C", 10, 0} )
   aadd( aStru, {"NAME_CNTL",   "C", 04, 0} )
   aadd( aStru, {"TCC",         "C", 05, 0} )
   aadd( aStru, {"STATE_TAX",   "C", 01, 0} )
   aadd( aStru, {"LASER",       "C", 01, 0} )
   dbcreate("PAYER1", aStru)
   if file("PAYER1.DBF")
      select 2
      use payer1
      dbappend()
  	  replace payer1->name	    with payer->name	   
	  replace payer1->address1  with payer->address1 
	  replace payer1->address2  with payer->address2 
	  replace payer1->city	    with payer->city	   
	  replace payer1->state	    with payer->state	   
	  replace payer1->zip	    with payer->zip	   
	  replace payer1->ein	    with payer->ein	   
	  replace payer1->name_cntl with payer->name_cntl
	  replace payer1->tcc       with payer->tcc      
	  replace payer1->state_tax with space(01)
	  replace payer1->laser     with space(01)
      dbcloseall()
      ferase ("PAYER.DBF")
      frename("PAYER1.DBF", "PAYER.DBF")
      select 1
      use payer
      do w2g0900
      dbcloseall()
   endif   
endif   

select 1
use ticket

if FieldExists('STA_WITH')
else
   aadd( aStru, {"RECORD_ID",   "C", 09, 0} )
   aadd( aStru, {"BATCH_DATE",  "D", 08, 0} )
   aadd( aStru, {"BATCH_NUM",   "N", 04, 0} )
   aadd( aStru, {"GROSS",       "N", 12, 2} )
   aadd( aStru, {"FED_WITH",    "N", 12, 2} )
   aadd( aStru, {"STA_WITH",    "N", 12, 2} )
   aadd( aStru, {"DATE_WON",    "D", 08, 0} )
   aadd( aStru, {"TRANS",       "C", 10, 0} )
   aadd( aStru, {"RACE",        "N", 02, 0} )
   aadd( aStru, {"WINNINGS",    "C", 10, 0} )
   aadd( aStru, {"CASHIER",     "N", 04, 0} )
   aadd( aStru, {"WINDOW",      "N", 04, 0} )
   aadd( aStru, {"PERF_NUM",    "C", 04, 0} )

   dbcreate("TICKET1", aStru)

   if file("TICKET1.DBF")
      
      GaugeDisplay ( aGauge)

      setpos(4,0)
	  @ 4,0 say 'Creating New Ticket Database'
      
      select 2
      use ticket1
      
      select 1

      while .not. eof()
         GaugeDisplay ( aGauge, recno()/lastrec() )
         select 2 
         dbappend()
 
   	     replace ticket1->record_id  with ticket->record_id
	     replace ticket1->batch_date with ticket->batch_date
	     replace ticket1->batch_num  with ticket->batch_num
	     replace ticket1->gross	     with ticket->gross
	     replace ticket1->fed_with   with ticket->fed_with
	     replace ticket1->sta_with   with 0
	     replace ticket1->date_won	 with ticket->date_won
	     replace ticket1->trans		 with ticket->trans
	     replace ticket1->race		 with ticket->race
	     replace ticket1->winnings	 with ticket->winnings
	     replace ticket1->cashier	 with ticket->cashier
         replace ticket1->window	 with ticket->window
         replace ticket1->perf_num	 with ticket->perf_num
         
         select 1
         skip
 
      enddo

      GaugeDisplay ( aGauge, recno()/lastrec() )
         
      dbcloseall()

      ferase ("TICKET.DBF")
      frename("TICKET1.DBF", "TICKET.DBF")

      select 1
      use ticket
      
      @ 4,0 clear to 4,79
      @ 4,0 Say 'Creating Ticket Index...'
      
      index on ticket->record_id to ticket.ntx ;
               eval (GaugeUpdate( aGauge, recno()/lastrec() ), .t.)
               
      @ 4,0 clear to 4,79
      @ 4,0 Say 'Creating BatchId Index...'
      
      index on dtoc(ticket->batch_date) + str(ticket->batch_num,4) + ; 
              ticket->record_id to batchid.ntx ;
               eval (GaugeUpdate( aGauge, recno()/lastrec() ), .t.)

      @ 4,0 clear to 4,79
      @ 4,0 Say 'Creating Batch Date Index...'
      
      index on ticket->batch_date to btchdate.ntx ;
               eval (GaugeUpdate( aGauge, recno()/lastrec() ), .t.)

      index on ticket->batch_date to bdate.ntx ;
               eval (GaugeUpdate( aGauge, recno()/lastrec() ), .t.)

      dbcloseall()
   endif   
endif   


dbcloseall()

return(nil)