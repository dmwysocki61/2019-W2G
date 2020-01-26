function editzip()
memvar getlist
SET ESCAPE ON
M->R = 1
DO WHILE M->R < 5 .OR. M->R = 5
   IF SUBSTR(M->ZIP,M->R,1) = '0'
      M->R = M->R + 1
      LOOP
   ELSE
      IF VAL(SUBSTR(M->ZIP,M->R,1)) = 0
	 EXIT
      ELSE
	 M->R = M->R + 1
	 LOOP
      ENDIF
   ENDIF
ENDDO
IF M->R > 5
   M->VLD_NUM = 'Y'
ENDIF
RETURN (NIL)
