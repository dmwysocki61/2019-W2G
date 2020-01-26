function zapdbs()
memvar getlist
clear
M->TIME = SPACE(08)
M->TIME = TIME()
@ 0,25 say 'W2G DATABASE MAINTENANCE PROGRAM'
@ 2,10 SAY 'PROGRAM START TIME: ' + M->TIME
@ 4,10 SAY 'PACKING PAYEE DATABASE. ONE MOMENT PLEASE...'
use payee
zap
pack
@ 6,10 SAY 'BUILDING PAYEE INDEXES. ONE MOMENT PLEASE...'
index on payee->record_id to payee.ntx
index on padr(payee->last_name,25) + padr(payee->first_name,12) + ;
         padr(payee->middle_int,2) to name.ntx
@ 8,10 SAY 'PACKING TICKET DATABASE. ONE MOMENT PLEASE...'
use ticket
zap
pack
@ 10,10 SAY 'BUILDING TICKET INDEXES. ONE MOMENT PLEASE...'
index on ticket->record_id to ticket.ntx
index on dtoc(ticket->batch_date) + str(ticket->batch_num,4) + ; 
              ticket->record_id to batchid.ntx
index on ticket->batch_date to btchdate.ntx
index on ticket->batch_date to bdate.ntx
@ 12,10 SAY 'PACKING BATCH CONTROL DATABASE. ONE MOMENT PLEASE...'
use batchctl
zap
pack
@ 14,10 SAY 'BUILDING BATCH CONTROL INDEXES. ONE MOMENT PLEASE...'
index on dtoc(batchctl->batch_date) + str(batchctl->batch_num,4) ;
      to batchctl.ntx
use arecord
zap
use brecord
zap
use crecord
zap
use frecord
zap
use trecord
zap
use zrecord
zap
use audit
zap
*use payer
*zap
use temp
zap
use rpt0235
zap
use rpt0245
zap
use rpt0270
zap
use rpt0710
zap
use rpt0720
zap
use rpt0730
zap
use rpt0740
zap
M->TIME = TIME()
@ 16,10 SAY 'PROGRAM END TIME: ' + M->TIME
CLOSE DATABASES
RETURN (NIL)
