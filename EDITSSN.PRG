function editssn()
memvar getlist
SET ESCAPE ON
M->R = 1
DO WHILE M->R < 9 .OR. M->R = 9
   IF SUBSTR(M->REC_ID,M->R,1) = '0'
      M->R = M->R + 1
      LOOP
   ELSE
      IF VAL(SUBSTR(M->REC_ID,M->R,1)) = 0
	 M->VLD_NUM = 'N'
	 RETURN (NIL)
      ELSE
	 M->R = M->R + 1
	 LOOP
      ENDIF
   ENDIF
ENDDO
IF M->R > 9
   M->VLD_NUM = 'Y'
ENDIF
RETURN (NIL)
