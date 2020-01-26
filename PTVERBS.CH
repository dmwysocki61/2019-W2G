/*       Name:  PTVerbs.ch
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
         Note:  This is the header file for the Clipper Power Tools
                Library for all of the commands

*/

#xtranslate VOID => return( NIL )

#xcommand PROCESS => while .T.
#xcommand END PROCESS => end

#xcommand REPEAT => while .t.
#xcommand UNTIL <exp> => if <exp> ; exit ; end ; end

#xcommand DEFAULT REGISTERS => aRegister := array(10)

#xcommand DO SWITCH => do case
#xcommand SWITCH <exp> [ PERFORM <act> ] => case <exp> [; <act>]
#xcommand END SWITCH => endcase

#xcommand SAVE GET TO <var>      => ;
         <var> := aclone( getlist ) ; getlist := {}
#xcommand RESTORE GET FROM <var> => getlist := <var>

#xtranslate (<var> IS <type>)      =>  ( valtype(<var>) = <type> )
#xtranslate (<var> IS NOT <type>)  =>  ( valtype(<var>) != <type> )

#xcommand IF <var> IS <type>          => if valtype(<var>) = <type>
#xcommand IF <var> IS NOT <type>      => if valtype(<var>) != <type>
#xcommand IF <ele> IS IN <array>      => if !(len( <array> ) \< <ele> )
#xcommand IF <ele> IS NOT IN <array>  => if len( <array> ) \< <ele>

#xtranslate @@<exp>      => {|x| if( x == nil, <exp>, <exp> := x)}
#xtranslate (<x> !$ <y>) => !( <x> $ <y> )

#xcommand WAIT [<c>]                          => WaitKey( <c>, .t. )
#xcommand WAIT [<c>] TO <var>                 => WaitKey( <c>, .t.,,, @<var>, <(var)> )
#xcommand WAIT AT <row>, <col> [<c>]          => WaitKey( <c>, .t.,<row>, <col> )
#xcommand WAIT AT <row>, <col> [<c>] TO <var> => WaitKey( <c>, .t.,<row>, <col>, @<var>, <(var)> )

#ifndef pCLIPPER_SETKEY
  #xcommand SET KEY <n> TO <proc>                  [DESCRIPT <name>]        => SETKEYTABLE( <n>, {|p,l,v,oGet,aList,nPos| <proc>(p,l,v,oGet,aList,nPos)}, <name> )
  #xcommand SET KEY <n> TO <proc>( [<list,...>] )  [DESCRIPT <name>]        => SETKEYTABLE( <n>, {|| <proc>(<list>) }, <name> )
  #xcommand SET KEY <n> [TO]                               => SETKEYTABLE( <n>, NIL )
  #xcommand SET KEY RESET                                  => SETKEYTABLE(,,,.t.)
  #xcommand SET KEY <n> TO BLOCK <block> [DESCRIPT <name>] => SETKEYTABLE( <n>, <block>, <name> )
  #xcommand SET KEY STACK TO <var>                         => <var> := SETKEYTABLE()
  #xcommand SET KEY STACK FROM <var>                       => SETKEYTABLE(,,,,<var>)
  // This is to make certain that the operation will get performed!
  #xtranslate SETKEY(            => SETKEYTABLE(
#endif

#xcommand INIT MASTER         => local lMaster
#xcommand BEGIN MASTER        => begin sequence
#xcommand EXIT MASTER         => lMaster := .t.
#xcommand END MASTER          => end sequence; if lMaster != NIL ; exit ; end
#xcommand SET MASTER TO <key> => setkey( <key>, {|| Break(NIL)}, "Return to master key" )

#xcommand DEFAULT <exp> TO <value> [, <expN> TO <valN> ] => ;
          <exp> := if(( valtype(<exp>)==valtype(<value>) .and. (<exp> != nil)), <exp>, <value>) ;
          [; <expN> := if(( valtype(<expN>)==valtype(<valN>) .and. (<expN> != nil)), <expN>, <valN>) ]

#xtranslate NEWREADER <exp> [WITH <var>] => ;
            send reader := {|x| <exp>(x [,<var>])}

#xcommand INIT DATA <exp> => <exp> := { {}, {}, {|| NIL}, {|| NIL} }

#xcommand INIT DATA <exp> PRE <block> => ;
                    <exp> := { {}, {}, <block>, {|| NIL} }

#xcommand INIT DATA <exp> POST <block> => ;
                    <exp> := { {}, {}, {|| NIL}, <block> }

#xcommand INIT DATA <exp> PRE <block1> POST <block2> => ;
                    <exp> := { {}, {}, <block1>, <block2> }


#xcommand DEFINE DATA <array> GET <get> ;
                 AT <row>, <col> ;
                 [COLOR <color>] ;
                 [PICT <pict>] ;
                 [MESSAGE <message> [MSGCOLOR <newcolor>][AT <mRow>, <mCol>] ] ;
                 [KEYSET <key> [TO <block>] [<offkey: ONLY>]] ;
                 [READER <reader> ] ;
                 [WHEN <when>] ;
                 [VALID <valid>] => ;
                                    ;
  BuildGetSystem(<array>, , ;
    {<get>, {|a| if(a=nil, <get>, <get>:=a)}, <(get)>, ;
            <row>, ;
            <col>, ;
            <color>, ;
            <pict>, ;
            <message>, ;
            <newcolor>, ;
            <mRow>, ;
            <mCol>, ;
            <reader>, ;
            <key>, ;
            <block>, ;
            <.offkey.>, ;
            <{when}>, ;
            <{valid}> } )

#xcommand DEFINE DATA <array> SAY <say> ;
                 AT <row>, <col> ;
                 [PICT <pict>] [COLOR <color>] ;
                 [GET <get> [AT <gRow>, <gCol>] ;
                 [COLOR <gColor>] ;
                 [PICT <gPict>] ;
                 [MESSAGE <message> [MSGCOLOR <newcolor>][AT <mRow>, <mCol>] ] ;
                 [KEYSET <key> [TO <block>][<offkey: ONLY>]] ;
                 [READER <reader> ] ;
                 [WHEN <when>] ;
                 [VALID <valid>] ] => ;
                                      ;
   BuildGetSystem( <array>, ;
              {<row>, <col>, <say>, <pict>, <color>, ;
               {|cPict, cColor| setpos(<row>, <col>), ;
                 if(cPict == NIL, ;
                    devout(<say>, <color> ), ;
                    devoutpict( <say>, cPict, <color> ) ;
                                          ) ;
                       } } ;
             [, {<get>, ;
                {|a| if(a=nil, <get>, <get>:=a)}, ;
                <(get)>, ;
                <gRow>, ;
                <gCol>, ;
                <gColor>, ;
                <gPict>, ;
                <message>, ;
                <newcolor>, ;
                <mRow>, ;
                <mCol>,;
                <reader>, ;
                <key>, ;
                <block>, ;
                <.offkey.>, ;
                <{when}>, ;
                <{valid}> } ] )

#xcommand BUILD VIEWER TO <var> [COLOR <color,...>] => ;
          <var> := { { {}, {,}, {,},<(var)>,#<color>,,}, {}, {}, {}, {}, {}, {} }

#xcommand VIEW <var> NAME <name> => <var>\[1,4] := <"name">

#xcommand VIEW <var> SAVE FILE <name> => ;
          <var>\[1,7] := <name>

#xcommand VIEW <var> AT <top>, <left>, <bottom>, <right> => ;
          <var>\[1,1] := {<top>, <left>, <bottom>, <right>}

#xcommand VIEW RELATION <key> INTO <alias> TO <var> => ;
          <var>\[1,2,1] := {|lBefore| if( lBefore, ; 
                                (dbClearRel(), ;
                                 dbSetRelation( <(alias)>, <{key}>, <"key">)), ;
                                 dbClearRel() ) } ;;
          <var>\[1,2,2] := "{ '"+ <(alias)> + "', {|| " + <(key)> + "}, '" + <"key"> + "'}"

#xcommand VIEW ITEM <header>, <thing> [WIDTH <width>] [SEARCH <block>] IN <var> => ;
          aadd(<var>\[2], <header>) ;;
          aadd(<var>\[3], <thing>) ;;
          aadd(<var>\[4], <width>) ;;
          aadd(<var>\[5], <"thing"> ) ;;
          aadd(<var>\[6], <block> ) ;;
          aadd(<var>\[7], <"block"> )

#xcommand VIEW <var> [WITH <block>][DISPLAY <aDisp>] => ;
           ViewModal(<var> [, {|nKey, oView, aData| <block>(nKey, oView, aData)}][, <aDisp>] )

#xcommand VIEW <var> TO <item> [WITH <block>][DISPLAY <aDisp>] => ;
           <item> := ViewModal(<var> [, {|nKey, oView, aData| <block>(nKey, oView, aData)}][, <aDisp>])

#xcommand VIEW <var> [EXCEPTION <block>] [DISPLAY <aDisp>] => ;
           ViewModal(<var> [, <{block}> ][, <aDisp>] )

#xcommand VIEW <var> TO <item> [EXCEPTION <block>][DISPLAY <aDisp>] => ;
           <item> := ViewModal(<var> [, <{block}> ][, <aDisp>])


// End of File
