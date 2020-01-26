* Program Name: W2G0830
* Author:       David M. Wysocki
* Company:      Diversified Tech Systems, Inc.
* Client:       Palm Beach Kennel Club, Inc.
* Purpose:      Create Magnetic Media - C records
*
function w2g0830()
memvar getlist

set decimals to 2

private time       := space(08)
private hold1      := space(18)
private hold2      := space(18)
private hold3      := space(18)
private eighteen_z := '000000000000000000'

m->time := time()
@ 21,0 say 'Creating C records.... ' + m->time

select 5
zap
append blank

replace crecord->record_typ with 'C'

m->hold1 = space(18)
m->hold2 = space(18)
m->hold3 = space(18)

m->hold1 = transform(m->rec_cnt,"********")
m->hold2 = strtran(m->hold1,'*','0')

replace crecord->number_pys with m->hold2
  
replace crecord->blank_01    with space(06)

m->hold1 = space(18)
m->hold2 = space(18)
m->hold3 = space(18)

m->hold1 = transform(m->tot_grs,"****************.**")
m->hold2 = strtran(m->hold1,'*','0')
m->hold3 = strtran(m->hold2,'.')

replace crecord->cntrl_tot1 with m->hold3

m->hold1 = space(18)
m->hold2 = space(18)
m->hold3 = space(18)
m->hold1 = transform(m->tot_fed,"****************.**")
m->hold2 = strtran(m->hold1,'*','0')
m->hold3 = strtran(m->hold2,'.')

replace crecord->cntrl_tot2 with m->hold3

replace crecord->cntrl_tot3 with eighteen_z
replace crecord->cntrl_tot4 with eighteen_z
replace crecord->cntrl_tot5 with eighteen_z
replace crecord->cntrl_tot6 with eighteen_z
replace crecord->cntrl_tot7 with eighteen_z
replace crecord->cntrl_tot8 with eighteen_z
replace crecord->cntrl_tot9 with eighteen_z
replace crecord->cntrl_tota with eighteen_z
replace crecord->cntrl_totb with eighteen_z
replace crecord->cntrl_totc with eighteen_z
replace crecord->cntrl_totd with eighteen_z
replace crecord->cntrl_tote with eighteen_z
replace crecord->cntrl_totf with eighteen_z
replace crecord->cntrl_totg with eighteen_z

replace crecord->blank_02 with space(196)

m->hold1 = space(08)
m->hold2 = space(08)
m->hold1 = transform(m->record_seq,"********")
m->hold2 = strtran(m->hold1,'*','0')

replace crecord->record_seq  with   m->hold2
replace crecord->blank_03    with   space(243)

++m->record_seq

goto top
copy to crecord.txt sdf
zap

select 11
zap
append blank

replace krecord->record_typ with 'K'
m->hold1 = space(18)
m->hold2 = space(18)
m->hold3 = space(18)

m->hold1 = transform(m->rec_cnt,"********")
m->hold2 = strtran(m->hold1,'*','0')

replace krecord->number_pys with m->hold2
replace krecord->blank_a    with space (06)
replace krecord->cntrl_1    with eighteen_z
replace krecord->cntrl_2    with eighteen_z
replace krecord->cntrl_3    with eighteen_z
replace krecord->cntrl_4    with eighteen_z
replace krecord->cntrl_5    with eighteen_z
replace krecord->cntrl_6    with eighteen_z
replace krecord->cntrl_7    with eighteen_z
replace krecord->cntrl_8    with eighteen_z
replace krecord->cntrl_9    with eighteen_z
replace krecord->cntrl_a    with eighteen_z
replace krecord->cntrl_b    with eighteen_z
replace krecord->cntrl_c    with eighteen_z
replace krecord->cntrl_d    with eighteen_z
replace krecord->cntrl_e    with eighteen_z
replace krecord->blank_b    with space(475)

m->hold1 = space(08)
m->hold2 = space(08)
m->hold1 = transform(m->record_seq,"********")
m->hold2 = strtran(m->hold1,'*','0')

replace krecord->record_seq  with   m->hold2

++m->record_seq

m->hold1 = space(18)
m->hold2 = space(18)
m->hold3 = space(18)
m->hold1 = transform(m->tot_sta,"****************.**")
m->hold2 = strtran(m->hold1,'*','0')
m->hold3 = strtran(m->hold2,'.')

replace krecord->state_tax with m->hold3
replace krecord->local_tax with eighteen_z
replace krecord->blank_c   with space (199)
replace krecord->state_cd  with space (2)
replace krecord->blank_d   with space (4)
replace krecord->blank_e   with space (2)

goto top

copy to krecord.txt sdf
zap

return (nil)
*eof w2g0830.prg
