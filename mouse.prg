#include "Gra.ch"

PROCEDURE Main
LOCAL cVar1 := "Hello"
LOCAL cVar2 := "World"

SET COLOR TO W/B // define the color
SET COLOR TO N/W,W+/B // define the color
SET CURSOR ON // activate the screen

// cursor

SetMouse( .T. ) // activate the mouse
CLS

GraBox( NIL, {72,176}, {200,256}, GRA_FILL, 30, 30 )

@ 10,10 SAY "Hello " GET cVar1
@ 12,10 SAY "Who ? " GET cVar2
READ
? cVar1, cVar2
RETURN