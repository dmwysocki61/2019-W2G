/*       Name:  PTWindow.ch
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
         Note:  This is a header file for the windowing routines for the
                Clipper Power Tools Library

*/

// The shadow manifest constants

#define pNO_SHADOW          0
#define pTOPLEFT_SHADOW     7
#define pTOPRIGHT_SHADOW    9
#define pBOTTOMLEFT_SHADOW  1
#define pBOTTOMRIGHT_SHADOW 3

// The explosion manifest constants

#define pNO_EXPLODE          0
#define pINSIDE_EXPLODE      5
#define pTOPRIGHT_EXPLODE    9
#define pTOPLEFT_EXPLODE     7
#define pBOTTOMLEFT_EXPLODE  1
#define pBOTTOMRIGHT_EXPLODE 3

//  These are for the stack and internal operations of the WINDOWS.PRG

#define pWINDOW_STACK len( WStack() )
#define pWINDOW_POSITION Wtail( .f. )
#define pDELETE_WINDOW 1
#define pRESIZE_WINDOW 2
#define pOBTAIN_WINDOW 3
#define pASSIGN_WINDOW 4
#define pINSERT_WINDOW 5
#define pRESET_WINDOWS 6

// The title location for each window!

#define pNO_TITLE            0
#define pLEFT_JUSTIFIED      1
#define pRIGHT_JUSTIFIED     2
#define pCENTER_JUSTIFIED    3

// Internal manifest constants to be more descript

#define pLAST_WINDOW len(aWindow)

// Commands to be used!

#xcommand MOVE WINDOW <n> TO END => M->_aWin := WGet( <n> ) ;;
                                    WRemove( <n> ) ;;
                                    WAdd( M->_aWin ) ;;
                                    WRedraw()

#xcommand MOVE WINDOW <x> TO TOP => M->_aWin := WGet( <x> ) ;;
                                    WRemove( <x> ) ;;
                                    WIns( M->_aWin, 2 ) ;;
                                    WRedraw()

#xcommand OPEN WINDOW [<*value*>] => Wopen( WSeek(<(value)>) )
#xcommand OPEN WINDOW NUMBERED [<value>] => Wopen( <value> )
#xcommand CLOSE WINDOW [<*value*>] => WClose( WSeek(<(value)>) )
#xcommand CLOSE WINDOW NUMBERED [<value>] => WClose( <value> )
#xcommand INITIALIZE WINDOWS [ COLOR <color> [PALATE <string>] ] => ;
          Winit( <color>, <string> )

#xcommand DEPTH O SCOPE => WScope()
#xcommand PAINT WINDOWS => WRedraw()
#xcommand MOVE WINDOWS => WMove()

#xcommand ENGAGE WINDOW => WEngage()

#xcommand SET WINDOW TO <top>, <left>, <bottom>, <right> ;
              [COLOR <color> ][BORDER <frame> ][ SHADOW <shadow> ] ;
              [EXPLODE <explode> ][TITLE <title> ] ;
              [LOCATION <location>][PERFORM <sub>] => ;
          Wset( <top>, <left>, <bottom>, <right>, <color>, ;
                <frame>, <shadow>, <explode>, <title>, ;
                <location>, <sub> )

#xtranslate FIND WINDOW <name> => Wseek( <name> )
#xtranslate ACTIVATE WINDOW => WEngage()

* End of File
