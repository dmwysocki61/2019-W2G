* Program Name: W2G0840
* Author:       David M. Wysocki
* Company:      Diversified Tech Systems, Inc.
* Client:       Palm Beach Kennel Club, Inc.
* Purpose:      Create Magnetic Media - F records
*
function w2g0840()
memvar getlist
private time := space(08)

m->time = time()
@ 22,0 say 'Creating F Records.... ' + m->time
select 6
zap
append blank
replace frecord->record_typ with 'F'
replace frecord->num_arecs  with '00000001'
replace frecord->zero1      with '0000000000000000000000000'
replace frecord->blank_01   with space(19)
replace frecord->total_pyes with space(08)
replace frecord->blank_02   with space(442)

m->record_seq = m->record_seq - 1

m->hold1 = space(08)
m->hold2 = space(08)
m->hold1 = transform(m->record_seq,"********")
m->hold2 = strtran(m->hold1,'*','0')

replace frecord->record_seq  with   m->hold2
replace frecord->blank_03    with   space(243)

goto top
copy to frecord.txt sdf
zap
return (nil)
*eof w2g0840.prg
