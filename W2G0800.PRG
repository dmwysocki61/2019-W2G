* Program Name: W2G0800
* Author:       David M. Wysocki
* Company:      Diversified Tech Systems, Inc.
* Client:       Palm Beach Kennel Club, Inc.
* Purpose:      Create Magnetic Media - Control Module
*
function w2g0800()

memvar getlist

private tot_grs      := 0.00
private tot_fed      := 0.00
private tot_sta      := 0.00
private rec_cnt      := 0
private choice       := ' '
private prgm_err     := ' '
private fhnld        := ' '
private record_seq   := 3

clear
select 1
use arecord
select 2
use brecord
select 3
use payee index payee
select 4
use ticket index ticket
select 5
use crecord
select 6
use frecord
select 7
use zrecord
select 8
use payer
select 10
use trecord
select 11
use krecord

do w2g0810

if m->choice = 'X'
   close databases
   return (nil)
endif

do w2g0820

if prgm_err = 'Y'
   clear
   return (nil)
end-if

do w2g0830
do w2g0840
do w2g0850

clear
close databases
return (nil)

*eof - w2g0800.prg