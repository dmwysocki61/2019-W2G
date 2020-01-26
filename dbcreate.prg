#include "dbstruct.ch"

PROCEDURE Main()
LOCAL nI, aStruct := { ;
      { "CHARACTER", "C", 25, 0 }, ;
      { "NUMERIC",   "N",  8, 0 }, ;
      { "DOUBLE",    "N",  8, 2 }, ;
      { "DATE",      "D",  8, 0 }, ;
      { "LOGICAL",   "L",  1, 0 }, ;
      { "MEMO1",     "M", 10, 0 }, ;
      { "MEMO2",     "M", 10, 0 } }

   REQUEST DBFNTX

   dbCreate( "testdbf", aStruct, "DBFCDX", .T., "MYALIAS" )

Return