/*       Name:  PTRr.ch
       Author:  Steve Straley
       Notice:  Copyright(c) - 1991 by
                Sirius Software Development, Inc.
                All Rights Reserved
                415-399-9810
         Date:  July 1, 1991
      Compile:  N/A
      Version:  Clipper 5.01
 Include Path:  \PTools\Include
  Environment:  f051;
         Link:  N/A
 Library Path:  \Clipper\501
         Note:  This is the header file for the Power Tools Library's
                Report Writer.

*/

// This is the Report Writer Clipper Header file named RR.CH

#define pTO_SCREEN   1
#define pTO_PRINTER  2
#define pTO_FILE     3

#xtranslate VALIDPARM(<x>, <y>, <z>)                            => ;
            ( IF( <x> = NIL, <z>, IF( VALTYPE(<x>) != <y>, <z>, <x> )))

#xcommand INITIALIZE REPORT => PUBLIC RptStructs := {}
#xcommand CATALOGUE <report> [<a: ADD>] => CatRpt( RptStructs, <report>, <.a.> )
#xcommand DISPLAY CATALOGUE => CatDisp( RptStructs, 0, 0, MAXROW(), MAXCOL() )
#xcommand REPORT FROM CATALOGUE => M->whatreport := CatDisp( RptStructs, 0, 0, MAXROW(), MAXCOL() ) ;;
                                  IF( !EMPTY(M->whatreport), RunRpt( RptStructs[M->whatreport] ), NIL )
#xcommand DISPLAY FROM CATALOGUE => M->whatreport := CatDisp( RptStructs, 0, 0, MAXROW(), MAXCOL() ) ;;
                                  IF( !EMPTY(M->whatreport), DoRpt( RptStructs[M->whatreport] ), NIL )

#xtranslate Box(<t>, <l>, <b>, <r>, <s>) => __Box( <t>, <l>, <b>, <r>, <s> )

* End of File          

