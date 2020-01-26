/*       Name:  PTFuncs.ch
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
         Note:  This is a header file for the Clipper Power Tools Library
                and includes all pseudo-functions and expressions

*/

#xtranslate DBZAP()                                             => ;
            ( if( !empty(alias()), (__dbzap(), (lastrec()==0)), .f. ) )

#xtranslate DBCONTINUE()                                        => ;
            ( __dbContinue(), found() )

#xtranslate DBLOCATE( <for> [, <while> [, <next> [, <rec> [, <rest:REST>]]]] ) =>;
            ( __dbLocate( <{for}>, <{while}>, <next>, <rec>, <.rest.> ), found() )

#xtranslate NOFERROR()                                          => ;
           ( FERROR() == 0 )

#xtranslate SETFILTER( <exp>, <move> )                          => ;
           ( dbSetFilter( <{exp}>, <"exp">  ), dbGotop(), dbfilter() )

#xtranslate SETFILTER( <exp> )                                  => ;
            ( dbSetFilter( <{exp}>, <"exp">  ), dbfilter() )

#xtranslate SETFILTER()                                         => ;
            ( dbClearFilter( NIL ), dbfilter() )

#xtranslate ISWRAP()                                            => ;
            ( SET( _SET_WRAP ) )

#xtranslate WHATAREA(<x>)                                       => ;
            <x>->(SELECT())

#xtranslate APPEND()                                            => ;
            ( IF( !EMPTY(ALIAS()), ( dbAppend(), .T.), .F.) )

#xtranslate EJECT()                                             => ;
            ( __Eject(), .T. )

#xtranslate UPPERLOWER(<exp>)                                   => ;
            ( upper(substr(<exp>,1,1))+lower(substr(<exp>,2)) )

#xtranslate FILECOPY( <source>, <destination> )                 => ;
            ( __CopyFile( <(source)>, <(destination)> ) )

#xtranslate KEYBOARD([<exp>])                                   => ;
            ( __Keyboard(<exp>), .T. )

#xtranslate SAY( <row>, <col>, <exp> [, <color> ] )                          => ;
            ( setpos(<row>, <col>), devout( <exp>, <color> ) )

#xtranslate SAYPICT( <row>, <col>, <exp>, <pict> [,  <color> ] )                 => ;
            ( setpos(<row>, <col>), devoutpict( <exp>, <pict>, <color> ) )

#xtranslate GET( <var> [, <pict>, <bValid>, <bWhen>] )          => aadd( getlist, _get_( <var>, <(var)>, <pict>, <bValid>, <bWhen> ) )
#xtranslate GET( <var> [, <pict>, <bValid>] )                   => aadd( getlist, _get_( <var>, <(var)>, <pict>, <bValid>, ) )
#xtranslate GET( <var> [, <pict>, , <bWhen>] )                  => aadd( getlist, _get_( <var>, <(var)>, <pict>,, <bWhen> ) )
#xtranslate GET( <var> [, <pict> ] )                            => aadd( getlist, _get_( <var>, <(var)>, <pict>,, ) )
#xtranslate GET( <var>, [,<bValid> [, <bWhen>]] )               => aadd( getlist, _get_( <var>, <(var)>,, <bValid>, <bWhen> ) )
#xtranslate GET( <var>, ,[, <bWhen>] )                          => aadd( getlist, _get_( <var>, <(var)>, , , <bWhen> ) )

#xtranslate WAIT( [<c>] )                                       => ;
            ( WaitKey( <c> ) )

#xtranslate VALIDPARM(<x>, <y>)                            => ;
            ( IF( <x> == NIL, <y>, IF( VALTYPE(<x>) != VALTYPE(<y>), <y>, <x> )))

#xtranslate CLS()                                               => ;
            ( scroll(), setpos(0,0) )

#xtranslate OCCURRENCE( <a>, <b> )                              => ;
            ( INT(LEN( <b> )-LEN(STRTRAN(<b>, <a>, ""))) / LEN(<a>) )

#xtranslate DAYS( <secs> )                                       => ;
            ( int( <secs> ) / 86400 )

#xtranslate DBF()                                                => ;
            alias()

#xtranslate TSTRING( <secs> )                                    => ;
            ( StringZeros( int( Modulus( <secs>/3600, 24)), 2, 0 ) + ":" + ;
              StringZeros( int( Modulus( <secs>/  60, 60)), 2, 0 ) + ":"  + ;
              StringZeros( int( Modulus( <secs>,      60)), 2, 0 ) )

#xtranslate SECS( <time> )                                       => ;
            ( val( <time> ) * 3600 + val( substr( <time>, 4 ) ) * 60 + val( substr( <time>, 7 ) ) )

#xtranslate LENNUM( <number> )                                   => ;
            ( len( alltrim( str( <number> ) ) ) )

#xtranslate ODD( <number> )                                      => ;
            ( !empty( <number> % 2 ) )

#xtranslate EVEN( <number> )                                      => ;
            ( empty( <number> % 2 ) )

#xtranslate FORCEBETWEEN(<x>,<y>,<z>)  => ;
              (if(<x>\>=<y>.and.<x>\<=<z>, <x>, max(min(<y>, <z>), <x>)))

#xtranslate LOWBYTE( <byte> ) => ( int( <byte> % 256 ) )
#xtranslate HIGHBYTE( <byte> ) => ( int( <byte> / 256 ) )
#xtranslate HIGHBIT( <number> ) => (<number> * ( 2**8 ) )

#xtranslate COLDBOOT() => ReBoot(0)
#xtranslate WARMBOOT() => ReBoot(1)

#xtranslate MAKECOLOR( <c,...> ) => #<c>

#xtranslate CLEARESC() => ( __keyboard(chr(0)), inkey() )

#xtranslate SETCENTURY( [<x>] )  => __SetCentury( <x> )

#xtranslate PTREAD() => ( setcursor(1), ptreadmodal( getlist ), getlist := {}, setcursor(0), lastkey() != 27 )

#xtranslate DOSFILEPATH(<c>) => substr( <c>, 1, rat("\", <c>) )
#xtranslate DOSFILENAME(<c>) => substr( <c>, rat("\",<c>)+1 )

#xtranslate DATEREADR()       => ;
            {|oGet, nTime, lTimeOut, bExceptions, aList, nPos| ;
             DateReader(oGet,nTime, lTimeOut, bExceptions, aList, nPos)}

#xtranslate RLREADER()        => ;
            {|oGet, nTime, lTimeOut, bExceptions, aList, nPos| ;
             R2LReader(oGet,nTime, lTimeOut, bExceptions, aList, nPos)}

#xtranslate MEMBLOCK(<x>)      => { {|a| if(a=nil, <x>, <x>:=a)}, <(x)> }
#xtranslate MEMPACK()          => memory(-1)
#xtranslate MEMSEGS()          => memory(101)
#xtranslate MEMHEAP()          => memory(102)
#xtranslate MEMREAL()          => memory(104)

#xtranslate SOFTFOUND()        => ( !found() .and. !eof() )

#xtranslate CalcOnGet([<row>,<col>,<color>])  => ;
            {|cName,nLine,cVar,oGet,aList,nPos| oGet:varput( Calculator(,{<row>,<col>,<color>}) )}

#ifndef pCLIPPER_SETKEY
  #xtranslate SETKEY(            => SETKEYTABLE(
#endif

#xtranslate SetPrinter()       => set( 23 )
#xtranslate SetConsole()       => set( 17 )
#xtranslate SetDevice()        => set( 20 )
#xtranslate SetConfirm()       => set( 27 )
#xtranslate SetAlternate()     => set( 18 )
#xtranslate SetDeleted()       => set( 11 )
#xtranslate SetMargin()        => set( 25 )
#xtranslate SetWrap()          => set( 35 )

#xtranslate MAKEDATE( <cDate> ) => ctod( #<cDate> )
