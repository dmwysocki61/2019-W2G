#include "hbqtgui.ch"

PROCEDURE fileopen ( oWnd , BatchGross, BatchFed, BatchSt, BatchCount, FileName, BtnLoad, CntrlGross, CntrlFed, CntrlSt, CntrlCount)

   LOCAL cListOfFiles, nReturned, oMB, otMessage, nF_Error, otDetail, otFileName, oFileDialog, nRecCnt, cRecIn, aArrayIn, cRecError, nTokens, cTotalFlag

   LOCAL nBatchGross, nBatchFed, nBatchSt, nBatchCount, odBatchConfirm
   LOCAL nCntrlGross, nCntrlFed, nCntrlSt, nCntrlCount

   LOCAL nCntrlBatchCity, nBatchCity, cRecId

   LOCAL oBtnOk, oBtnQuit, oQDate

   nBatchGross      := 0
   nBatchFed        := 0
   nBatchSt         := 0
   nBatchCount      := 0
   nCntrlGross      := 0
   nReturned        := 0
   nF_Error         := 0
   nRecCnt          := 0
   nTokens          := 0
   otMessage        := " "
   otDetail         := " "
   cRecIn           := " "
   cRecError        := " "
   cRecId           := " "
   cTotalFlag       := " "

   nCntrlGross      := val(StrTran(CntrlGross:Text(),",",""))
   nCntrlFed        := val(StrTran(CntrlFed:Text(),",",""))
   nCntrlSt         := val(StrTran(CntrlSt:Text(),",",""))
   nCntrlCount      := val(StrTran(CntrlCount:Text(),",",""))

   oFileDialog := QFileDialog(oWnd)
   oFileDialog:SetDirectory ( "c:\temp" )
   oFileDialog:setNameFilter( "*.csv" )
   oFileDialog:setViewMode( QFileDialog_Detail )
   oFileDialog:setOption( QFileDialog_DontUseNativeDialog)

   oFileDialog:exec(oWnd)

   cListOfFiles := oFileDialog:selectedFiles()
   otFileName := cListOfFiles:At( 0 )

   **otFileName := "c:\temp\20130317W2G.CSV"

   **__hbqt_destroy( oFileDialog )

   oMB := QMessageBox(oWnd)
   oMB:Icon(QMessageBox_Information)
   oMB:setStandardButtons( QMessageBox_Ok )
   oMB:setDefaultButton( QMessageBox_Ok )

   IF ft_FUse( otFileName  ) < 0     // open text file
      nF_Error := ft_FError()
      otMessage := "Error opening file "
      otDetail  := "File Name " + otFileName + ", error code (" + hb_ntos(nF_Error ) + ")"
      oMB:setWindowTitle( "File Open Error" )
      oMB:setInformativeText(otMessage)
      oMB:setDetailedText(otDetail)
   ELSE
      nF_Error := ft_FError()
      otMessage := "File Open Successful "
      otDetail  := "File Name: " + otFileName + ", error code (" + hb_ntos(nF_Error ) + ")"
      oMB:setWindowTitle( "File Open Successful" )
      oMB:setInformativeText(otMessage)
      oMB:setDetailedText(otDetail)
      BtnLoad:setEnabled(.T.)
   END-IF

   oMB:exec()

   DO WHILE ! ft_FEof()
      nRecCnt += 1

      cRecIn := ft_FReadLn()

      nTokens := NumToken(CRecIn,'|')
      aArrayIn := hb_atokens(cRecIn,"|")

      if (nRecCnt > 1)
         if NumToken(RemAll(aArrayIn[4],' '),' ') = 0
            otMessage := "Error processing record: " + hb_ntos(nRecCnt) + chr(13) + chr(10) + "Please correct file and reprocess."
            otDetail  := "SSN Invalid. " + aArrayIn[4]
            oMB:setWindowTitle( "File Processing Error" )
            oMB:setInformativeText(otMessage)
            oMB:setDetailedText(otDetail)
            oMB:exec()
            ft_DFClose( otFileName  )
            BtnLoad:setEnabled(.F.)
            return
         else
            nBatchGross += Val(aArrayIn[13])
            nBatchFed   += Val(aArrayIn[14])
            nBatchSt    += Val(aArrayIn[15])
            **nBatchCity  += Val(aArrayIn[17])
         end-if
      end-if
      ft_FSkip()
   END-WHILE

   ft_DFClose( otFileName  )
   nRecCnt -= 1
   BatchGross:SetText( Transform( nBatchGross, "##,###,###,##9.99" ))
   BatchFed:SetText  ( Transform( nBatchFed,   "##,###,###,##9.99" ))
   BatchSt:SetText   ( Transform( nBatchSt,    "##,###,###,##9.99" ))
   BatchCount:SetText( Transform( nRecCnt,     "##,###,###,##9.99" ))
   FileName:SetText(otFileName)

   otDetail  := "Record Count: " + Chr(9)  + hb_ntos(nRecCnt ) ;
                                 + chr(13) + chr(10) + "Batch Gross:   " + chr(9) + Transform( nBatchGross, "##,###,###,##9.99" ) ;
                                 + chr(13) + chr(10) + "Control Gross: " + chr(9) + Transform( nCntrlGross, "##,###,###,##9.99" ) ;
                                 + chr(13) + chr(10) + "Batch Fed:     " + chr(9) + Transform( nBatchFed  , "##,###,###,##9.99" ) ;
                                 + chr(13) + chr(10) + "Control Fed:   " + chr(9) + Transform( nCntrlFed  , "##,###,###,##9.99" ) ;
                                 + chr(13) + chr(10) + "Batch State:   " + chr(9) + Transform( nBatchSt   , "##,###,###,##9.99" ) ;
                                 + chr(13) + chr(10) + "Control State: " + chr(9) + Transform( nCntrlSt   , "##,###,###,##9.99" )
   if (nBatchGross == nCntrlGross) .AND. (nBatchFed == nCntrlFed) .AND. (nBatchSt == nCntrlSt)
      otMessage := "File Processing Complete." + chr(13) + chr(10) + chr(13) + chr(10) + "Batch in balance."
      BtnLoad:setEnabled(.T.)
   else
      otMessage := "File Processing Complete." + chr(13) + chr(10) + chr(13) + chr(10) + "Batch not in balance."
      BtnLoad:setEnabled(.F.)
   end-if

   oMB:setWindowTitle( "File Processing Complete" )
   oMB:setInformativeText(otMessage)
   oMB:setDetailedText(otDetail)
   oMB:reSize(300, 300)
   oMB:exec(oWnd)

   RETURN