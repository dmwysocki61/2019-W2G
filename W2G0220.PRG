* Program Name: W2G0220
* Author:       David M. Wysocki
* Company:      Diversified Tech Systems, Inc.
* Client:       Flagler Kennel Club
* Purpose:      Batch Inquiry Module.
*
*
function w2g0220()
memvar getlist
set escape on
set date american
private keyvalue := space (12)
private b_date   := date()
private b_number := 0
private prev_num := 0
private b_gross  := 0.00
private b_fed    := 0.00
private b_state  := 0.00
private ctl_grs  := 0.00
private ctl_fed  := 0.00
private ctl_sta  := 0.00
private choice   := ' '

set key m->keyf5 to proc040

do w2g0340

set key m->keyf5 to

if m->m_f2 = 'y'
   close databases
   m->m_f2 = ' '
   return (nil)
endif

select 1
use ticket index batchid

select 2
use batchctl index batchctl

select 3
use temp

zap

select 2
keyvalue :=  dtoc(m->b_date)+str(m->b_number,4)

seek keyvalue 

if eof ()
   clear
   @ 0,20 say 'batch control record not found'
   @ 1,20 say 'database maintenance must be performed'
   wait
   return (nil)
else
   m->ctl_grs  = batchctl->total_gros
   m->ctl_fed  = batchctl->total_fed
   m->ctl_sta  = batchctl->total_sta
endif
select 1
do w2g0440
clear
return (nil)
* eof w2g0440.prg
