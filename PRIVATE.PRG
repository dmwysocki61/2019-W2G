* Name:         Private.prg             // Compile w/o the /E option
function Main()
 private xData1 := 1
 cls
 m->xData2 := "This is it"
 m->xData3 := date()
 ? "The values are set first to...."
 ?
 ? m->xData1, m->xData2, m->xData3
 
 dofunc( m->xData3 )

 ?
 ? "And now they are ..."
 ? 
 ? m->xData1, m->xData2, m->xData3
 return (NIL)

***********************************************

static function DoFunc
 parameters xNewData
 private xData2 := 0
 m->xNewData := .t.
 
 ?
 ? "The value of the variables inside the function are as follows:"
 ?
 ? ++m->xData1, m->xData2, m->xNewData
 ?
 wait
 return (NIL)

// End of File: Private.prg
