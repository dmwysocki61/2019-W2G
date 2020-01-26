* Program Name: W2G0210
* Author:       David M. Wysocki
* Company:      Diversified Tech Systems, Inc.
* Client:       Palm Beach Kennel Club
* Purpose:      Batch Edit Control Module.
*
*
function w2g0210()
memvar getlist
public  b_gross  := 0.00
public  b_fed    := 0.00
public  b_state  := 0.00
public  vld_btch := ' '

clear

m->m_f2    := ' '
m->m_f3    := ' '

set key m->keyf5 to proc040

do w2g0340

set key m->keyf5 to

if m->m_f2 = 'Y'
   clear
   return (nil)
endif

if m->choice = 'X'
   clear
   return (nil)
endif

do w2g0350

clear
return (nil)
*eof w2g0210.prg
