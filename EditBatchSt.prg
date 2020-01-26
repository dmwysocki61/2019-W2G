#include "hbqtgui.ch"

PROCEDURE editBatchSt (oWnd, CntrlGross, CntrlFed, CntrlSt, CntrlCount, BatchGross, BatchFed, BatchSt, BatchCount,BtnLoad)
   local nBatchGross, nBatchFed, nBatchSt, nBatchCount
   LOCAL oMB, otMessage, otDetail
   LOCAL nCntrlGross, nCntrlFed, nCntrlSt, nCntrlCount
   
   otMessage        := "Batch in Balance. Click Load Button to upload to database."
   otDetail         := ""
   
   nCntrlGross      := val(StrTran(CntrlGross:Text(),",",""))
   nCntrlFed        := val(StrTran(CntrlFed:Text(),",",""))
   nCntrlSt         := val(StrTran(CntrlSt:Text(),",",""))
   nCntrlCount      := val(StrTran(CntrlCount:Text(),",",""))

   nBatchGross      := val(StrTran(BatchGross:Text(),",",""))
   nBatchFed        := val(StrTran(BatchFed:Text(),",",""))
   nBatchSt         := val(StrTran(BatchSt:Text(),",",""))
   nBatchCount      := val(StrTran(BatchCount:Text(),",",""))

   if (nBatchGross = nCntrlGross) .AND. ;
      (nBatchFed   = nCntrlFed)   .AND. ;
      (nBatchSt    = nCntrlSt)    .AND. ;
      (nBatchCount = nCntrlCount) .AND. ;
      (nCntrlGross > 0          ) 
      oMB := QMessageBox(oWnd)
      oMB:Icon(QMessageBox_Information)
      oMB:setStandardButtons( QMessageBox_Ok )
      oMB:setDefaultButton( QMessageBox_Ok )
      oMB:setWindowTitle( "State Withholding Edit" )
      oMB:setWindowModality( Qt_WindowModal )
      oMB:setInformativeText(otMessage)
      oMB:setDetailedText(otDetail)
   
      oMB:Exec(oWnd)
      BtnLoad:setEnabled(.T.)
   End-If

   CntrlSt:SetText(Transform( nCntrlSt, "###,##9.99" ))

   RETURN
