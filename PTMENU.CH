/*       Name:  PTMenu.ch
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
                in regards to the Power Tools Menu Subsystem and all
                related commands and values.

*/

#xtranslate menuinit() => MenuList := {}

#xcommand @ <row>, <col> prompt <string> ;
            [position <num>][highlite <hcolor>];
            [message <message> [AT <mRow>, <mCol>];
            [color <color>][<cd:CENTER>]] ;
            [activate <func>] => ;
  aadd( MenuList, MenuNew(<row>, <col>, <string>, ;
                         <num>, <(hcolor)>, <message>, ;
                         <mRow>, <mCol>, <(color)>, ;
                         <.cd.>, {|aList, nPos, nKey| <func>} ))

#xcommand @ <row>, <col> prompt <string> ;
            [position <num>][highlite <hcolor>];
            [message <message> [AT <mRow>, <mCol>];
            [color <color>][<cd:CENTER>]] ;
            [perform <func>] => ;
  aadd( MenuList, MenuNew(<row>, <col>, <string>, ;
           <num>, <(hcolor)>, <message>, ;
           <mRow>, <mCol>, <(color)>, ;
           <.cd.>, {|aList, nPos, nKey| <func>(aList, nPos, nKey)} ))

#xcommand prompt <string> ;
            [position <num>][highlite <hcolor>];
            [message <message> [AT <mRow>, <mCol>];
            [color <color>][<cd:CENTER>]] ;
            [activate <func>] => ;
  aadd( MenuList, MenuNew(,, <string>, ;
                         <num>, <(hcolor)>, <message>, ;
                         <mRow>, <mCol>, <(color)>, ;
                         <.cd.>, {|aList, nPos, nKey| <func>} ))

#xcommand prompt <string> ;
            [position <num>][highlite <hcolor>];
            [message <message> [AT <mRow>, <mCol>];
            [color <color>][<cd:CENTER>]] ;
            [perform <func>] => ;
  aadd( MenuList, MenuNew(,, <string>, ;
           <num>, <(hcolor)>, <message>, ;
           <mRow>, <mCol>, <(color)>, ;
           <.cd.>, {|aList, nPos, nKey| <func>(aList, nPos, nKey)} ))

#xcommand menu to <choice> => ;
  MenuModal( MenuList, @<choice>,,<(choice)> ) ;;
  MenuList := {}

#xcommand menu to <choice> with <alist> [ display <adisp> ] => ;
  MenuModal( <alist>, @<choice>, <adisp>, <(choice)> ) 

#xcommand store menu to <var> => <var> := aclone( MenuList )  ;;
                                 MenuList := {}

#xtranslate MENUSETDISP( <aArray> ) => {|| MenuDisplay( <aArray> )}

* End of File
