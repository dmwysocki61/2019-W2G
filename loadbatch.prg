#include "hbqtgui.ch"

PROCEDURE loadbatch( oWnd, CntrlGross, CntrlFed, CntrlSt, TicketCnt, BatchDt, BatchNum, PerfNum, FileName, BtnLoad )

   LOCAL oMB, oQDate, oKey, obnum, oCursor, nButtonPressed, otDetailedText, otFileName, record
   LOCAL aArray_In, oBAdd_or_Update, nF_Error, otMessage,otDetail, nRecCnt, cRecIn, nTokens, cString, nF_Open
   LOCAL nBatchGross, nBatchFed, nBatchSt, nBatchCity, nGross, nFedWith, nStateWith
   LOCAL nCntrlGross, nCntrlFed, nCntrlSt, nTicketCnt, nBatchNum

   oMB         := QMessageBox(oWnd)

   nRecCnt     := 0

   nCntrlGross := 0
   nCntrlFed   := 0
   nCntrlSt    := 0
   nTicketCnt  := 0

   nBatchGross := 0
   nBatchFed   := 0
   nBatchSt    := 0

   nGross      := 0
   nFedWith    := 0
   nStateWith  := 0
   nBatchNum   := 0
   nF_Open     := 0

   nCntrlGross      := val(StrTran(CntrlGross:Text(),",",""))
   nCntrlFed        := val(StrTran(CntrlFed:Text(),",",""))
   nCntrlSt         := val(StrTran(CntrlSt:Text(),",",""))
   nTicketCnt       := val(StrTran(TicketCnt:Text(),",",""))
   obnum            := " "
   cString          := " "
   otFileName       := " "
   m->record        := " "
   
   otFileName       := FileName:Text()

   oMB:setWindowTitle( "Batch Control" )

   oKey      := " "
   oQDate    := QDate()
   oQDate    := BatchDt:Date()

   oKey      := oQDate:toString("MM/dd/yyyy") + Str(BatchNum:value(),4)

   CLOSE databases

   SELECT 1

   USE batchctl INDEX batchctl

   SELECT 2
   USE payee index payee

   SELECT 3
   USE ticket index ticket

   SELECT 1

   SEEK oKey

   oMB:setDetailedText( oKey )
   oMB:Icon( QStyle_SP_MessageBoxQuestion )
   oMB:setStandardButtons( QMessageBox_Ok )
   oMB:setDefaultButton( QMessageBox_Ok )

   IF Eof()
      oMB:setInformativeText( "Batch does not exist in database." + chr(13) + chr(10) + " " + chr(13) + chr(10) + "Click Ok to load batch to database." )
      oMB:exec(oWnd)
   Else
      oMB:setInformativeText( "Batch already exists in database." + chr(13) + chr(10) + " " + chr(13) + chr(10) + "Please select a different batch date / number." ;
                              + Chr(13) + Chr(10) + " " + chr(13) + chr(10);
                              + "Click OK to continue.")
      oMB:exec(oWnd)
      return
   End-if
   
   nF_Open := ft_FUse( otFileName )
   ft_FGoTop()
   
   IF ft_FUse( FileName:Text()  ) < 0     // open text file
      nF_Error := ft_FError()
      otMessage := "Error opening file "
      otDetail  := "File Name " + FileName:Text() + ", error code (" + hb_ntos(nF_Error ) + ")"
      oMB:setWindowTitle( "File Open Error" )
      oMB:setInformativeText(otMessage)
      oMB:setDetailedText(otDetail)
      oMB:exec(oWnd)
      appquit()
   END-IF

   DO WHILE ! ft_FEof()
      nRecCnt += 1

      cRecIn := ft_FReadLn()

      nTokens := NumToken(cRecIn,"|")

      aArray_In := hb_atokens(cRecIn,"|")

      if nRecCnt > 1
          m->record := substr(aArray_in[4],1,3) + substr(aArray_in[4],5,2) + substr(aArray_in[4],8,4)

          select 2

          if NumToken(RemAll(m->record,' '),' ') = 0
              oMB:setInformativeText("Error encountered. Record missing SSN. Please update file and reprocess.")
              oMB:setDetailedText("Rec Count: " + hb_ntos(nRecCnt) )
              oMB:exec(oWnd)
              return
          end-if

          seek m->record

          IF EOF()
             append blank
          EndIf
          replace payee->record_id  with m->record
          replace payee->last_name  with aArray_in[5]
          replace payee->first_name with aArray_in[7]
          replace payee->middle_int with space(02)
          replace payee->address    with aArray_in[8]
          replace payee->city       with aArray_in[9]
          replace payee->state      with aArray_in[10]
          replace payee->zip        with aArray_in[11]

          select 3
          append blank

          replace ticket->record_id   with m->record
          replace ticket->batch_date  with CToD(oQDate:tostring( "MM/dd/yy" ))
          replace ticket->batch_num   with BatchNum:value()

          * parse gross winnings amount

          cString     := aArray_in[13]
          nGross      := Val(cString)

          replace ticket->gross with nGross

          * parse federal withholding amount

          cString   := aArray_in[14]
          nFedWith  := Val(cString)

          replace ticket->fed_with       with nFedWith
          replace ticket->sta_with       with 0
          replace ticket->date_won       with CToD(aArray_In[2])
          replace ticket->trans          with 'Batch Upld'
          replace ticket->race           with 0
          replace ticket->winnings       with ' '
          replace ticket->cashier        with 0
          replace ticket->window         with 0
          replace ticket->perf_num       with PerfNum:text()

          nBatchGross  += Val(aArray_In[13])
          nBatchFed    += Val(aArray_In[14])
          nBatchSt     += Val(aArray_In[15])
          ** nBatchCity   += Val(aArray_In[17])
      end-if

      ft_FSkip()

   END-WHILE

   select 1
   append blank
   REPLACE batchctl->batch_date     WITH CToD(oQDate:tostring( "MM/dd/yyyy" ))
   REPLACE batchctl->batch_num      WITH BatchNum:value()
   REPLACE batchctl->total_gros     WITH nBatchGross
   REPLACE batchctl->total_fed      WITH nBatchFed
   REPLACE batchctl->total_sta      WITH nBatchSt
   REPLACE batchctl->perf_num       WITH PerfNum:text()

   BtnLoad:setEnabled(.F.)
   oMB:Icon(QMessageBox_Information)
   oMB:setStandardButtons( QMessageBox_Ok )
   oMB:setDefaultButton( QMessageBox_Ok )
   oMB:setWindowTitle( "Processing Complete" )
   oMB:setInformativeText( "Batch upload complete." + chr(13) + chr(10) + " " + chr(13) + chr(10) + " Click Ok to exit program." )
   nButtonPressed := oMB:exec(oWnd)

   ft_DFClose( otFileName  )
   close databases
   
   use ticket
   
   index on dtoc(ticket->batch_date) + str(ticket->batch_num,4) + ticket->record_id to batchid.ntx
   
   index on ticket->batch_date to btchdate.ntx
   
   index on ticket->batch_date to bdate.ntx
   
   **use payee
   **index on rtrim(payee->last_name) + rtrim(payee->first_name) + rtrim(payee->middle_int) to name.ntx

   close databases
   
   RETURN
