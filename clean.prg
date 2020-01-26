procedure main()
MEMVAR GETLIST
local BATCH_DATE := date()
local BATCH_NUM  := 0
local OKey := ' '
SET EPOCH TO 2000
SET CENTURY ON
CLEAR
SELECT 1

use batchctl index batchctl

M->BATCH_DATE := "11/30/2019"
M->BATCH_NUM  := "  11"
m->oKey        := dtoc(batchctl->batch_date) + str(batchctl->batch_num,4)
dbseek (oKey,.T.)

if eof()
   clear
   @ 1, 02 say 'Error. Batch not found in BATCHCTL.DBF - Program terminated'
   wait
else
   clear
   @ 1, 02 say 'Batch Found found in BATCHCTL.DBF'
   wait
end-if

SELECT 2
USE TICKET INDEX BATCHID
dbseek (oKey,.T.)

if eof()
   clear
   @ 1, 02 say 'Error. Batch not found in TICKET.DBF - Program terminated'
   wait
else
   clear
   @ 1, 02 say 'Batch found in TICKET.DBF'
   wait
end-if

DO WHILE ticket->batch_date =  CTOD("11/30/2019")
   DELETE
   SKIP                
END-WHILE           
PACK
CLEAR
@ 5,02 SAY 'UPDATE COMPLETE'
RETURN
