#include "hbqtgui.ch"

PROCEDURE Main()

   LOCAL oBtnOk, oBtnQuit, obAdd_or_Update, oBtnOpenFile, oBtnLoad
   LOCAL oDate, oSBar
   LOCAL oLabel1, olBatchDt, olBatchNum, olBatchGross, olBatchFed, olBatchSt, olBatchCount, olFileName, olPerfNum
   LOCAL otBatchDt, otBatchNum, otBatchGross, otBatchFed, otBatchSt, otBatchCount
   LOCAL otCntrlBatchGross, otCntrlBatchFed, otCntrlBatchSt, otCntrlBatchCount, otPerfNum
   LOCAL otFileName, olBatchHeading, olCntrlHeading, oRect1, oRect2, oRect3
   local oFileDialog
   public oWnd
   * PUBLIC oFileDialog
   SET EPOCH TO 2000
   SET CENTURY ON
   
   HBQT_ERRORSYS()

   // REQUEST HB_GT_WIN_DEFAULT
   set(_SET_DEBUG,.T.)
   oWnd := QMainWindow()
   oWnd:setWindowTitle( "Spreadsheet Upload" )
   oWnd:resize( 525, 400 )

   oLabel1 := QLabel( oWnd )
   oLabel1:resize( 275, 30 )
   oLabel1:move( 125, 08 )

   oLabel1:setText( "<font color=black size=4>" + "Enter control totals and click Open File Button" + "</font>" )

   oRect1            := QRect()

   olBatchDt         := QLabel ( oWnd )
   olBatchNum        := QLabel ( oWnd )
   olBatchGross      := QLabel ( oWnd )
   olBatchFed        := QLabel ( oWnd )
   olBatchSt         := QLabel ( oWnd )
   olBatchCount      := QLabel ( oWnd )
   olFileName        := QLabel ( oWnd )
   olBatchHeading    := QLabel ( oWnd )
   olCntrlHeading    := QLabel ( oWnd )
   olPerfNum         := QLabel ( oWnd )

   otBatchDt         := QDateEdit ( oWnd )
   otBatchNum        := QSpinBox  ( oWnd )

   otCntrlBatchGross := QLineEdit ( oWnd )
   otCntrlBatchFed   := QLineEdit ( oWnd )
   otCntrlBatchSt    := QLineEdit ( oWnd )
   otCntrlBatchCount := QLineEdit ( oWnd )
   otPerfNum         := QLineEdit ( oWnd )

   otBatchGross      := QLineEdit ( oWnd )
   otBatchFed        := QLineEdit ( oWnd )
   otBatchSt         := QLineEdit ( oWnd )
   otBatchCount      := QLineEdit ( oWnd )

   otFileName        := QLineEdit ( oWnd )

   olBatchHeading:SetText("<font color=black size=4>" + "Batch Values")
   olCntrlHeading:SetText("<font color=black size=4>" + "Control Values")

   olBatchDt:SetText   ( "Batch Date: " )
   olBatchNum:SetText  ( "Batch Number: " )
   olBatchGross:SetText( "Gross Amount: " )
   olBatchFed:SetText  ( "Federal Withholding: " )
   olBatchSt:SetText   ( "State Withholding: " )
   olBatchCount:SetText( "Transaction Count: " )
   olPerfNum:SetText   ( "Performance Number: ")

   olFileName:SetText  ( "File Name" )

   otBatchDt:SetDate( QDate( Year( Date() ), Month( Date() ), Day( Date() ) )  )
   otBatchNum:SetRange( 1, 1000 )

   otCntrlBatchGross:SetText( "" )
   otCntrlBatchFed:SetText  ( "" )
   otCntrlBatchSt:SetText   ( "" )
   otCntrlBatchCount:SetText( "" )

   otBatchGross:SetText( "" )
   otBatchFed:SetText  ( "" )
   otBatchSt:SetText   ( "" )
   otBatchCount:SetText( "" )
   otPerfNum:SetText   ( "" )
   otFileName:SetText  ( "" )

   olBatchHeading:resize( 100, 20 )
   olCntrlHeading:resize( 100, 20 )
   olBatchDt:resize   ( 100, 20 )
   olBatchNum:resize  ( 100, 20 )
   olBatchGross:resize( 100, 20 )
   olBatchFed:resize  ( 100, 20 )
   olBatchSt:resize   ( 100, 20 )
   olBatchCount:resize( 100, 20 )
   olPerfNum:resize   ( 100, 20 )
   olFileName:resize  ( 100, 20 )

   otBatchDt:resize   ( 100, 20 )
   otBatchNum:resize  ( 100, 20 )

   otCntrlBatchGross:resize( 110, 20 )
   otCntrlBatchFed:resize  ( 110, 20 )
   otCntrlBatchSt:resize   ( 110, 20 )
   otCntrlBatchCount:resize( 110, 20 )
   otPerfNum:resize        ( 110, 20 )

   otBatchGross:resize( 110, 20 )
   otBatchFed:resize  ( 110, 20 )
   otBatchSt:resize   ( 110, 20 )
   otBatchCount:resize( 110, 20 )
   otFileName:resize  ( 250, 20 )


   olCntrlHeading:move( 200, 40 )
   olBatchHeading:move( 350, 40 )
   olBatchDt:move     ( 50, 70  )
   olBatchNum:move    ( 50, 100 )
   olBatchGross:move  ( 50, 130 )
   olBatchFed:move    ( 50, 160 )
   olBatchSt:move     ( 50, 190 )
   olBatchCount:move  ( 50, 220 )
   olPerfNum:move     ( 50, 250 )
   olFileName:move    ( 50, 280 )

   otBatchDt:move     ( 200, 70  )
   otBatchNum:move    ( 200, 100 )

   otCntrlBatchGross:move  ( 200, 130 )
   otCntrlBatchFed:move    ( 200, 160 )
   otCntrlBatchSt:move     ( 200, 190 )
   otCntrlBatchCount:move  ( 200, 220 )
   otPerfNum:move          ( 200, 250 )

   otBatchGross:move  ( 350, 130 )
   otBatchFed:move    ( 350, 160 )
   otBatchSt:move     ( 350, 190 )
   otBatchCount:move  ( 350, 220 )

   otFileName:move    ( 200, 280 )

   otBatchDt:setAlignment   ( Qt_AlignRight )
   otBatchNum:setAlignment  ( Qt_AlignRight )

   otCntrlBatchGross:setAlignment( Qt_AlignRight )
   otCntrlBatchFed:setAlignment  ( Qt_AlignRight )
   otCntrlBatchSt:setAlignment   ( Qt_AlignRight )
   otCntrlBatchCount:setAlignment( Qt_AlignRight )

   otBatchGross:setAlignment( Qt_AlignRight )
   otBatchFed:setAlignment  ( Qt_AlignRight )
   otBatchSt:setAlignment   ( Qt_AlignRight )
   otBatchCount:setAlignment( Qt_AlignRight )

   otFileName:setAlignment  ( Qt_AlignLeft  )

   otCntrlBatchGross:Connect ( QEvent_FocusOut, {|| editBatchGross(oWnd,              ;
                                                                   otCntrlBatchGross, ;
                                                                   otCntrlBatchFed,   ;
                                                                   otCntrlBatchSt,    ;
                                                                   otCntrlBatchCount, ;
                                                                   otBatchGross,      ;
                                                                   otBatchFed,        ;
                                                                   otBatchSt,         ;
                                                                   otBatchCount,      ;
                                                                   oBtnLoad           ) } )
   
   otCntrlBatchFed:Connect   ( QEvent_FocusOut, {|| editBatchFed  (oWnd,              ;
                                                                   otCntrlBatchGross, ;
                                                                   otCntrlBatchFed,   ;
                                                                   otCntrlBatchSt,    ;
                                                                   otCntrlBatchCount, ;
                                                                   otBatchGross,      ;
                                                                   otBatchFed,        ;
                                                                   otBatchSt,         ;
                                                                   otBatchCount,      ;
                                                                   oBtnLoad           ) } )
   
   otCntrlBatchSt:Connect    ( QEvent_FocusOut, {|| editBatchSt   (oWnd,              ;
                                                                   otCntrlBatchGross, ;
                                                                   otCntrlBatchFed,   ;
                                                                   otCntrlBatchSt,    ;
                                                                   otCntrlBatchCount, ;
                                                                   otBatchGross,      ;
                                                                   otBatchFed,        ;
                                                                   otBatchSt,         ;
                                                                   otBatchCount,      ;
                                                                   oBtnLoad           ) } )

   otCntrlBatchCount:Connect ( QEvent_FocusOut, {|| editBatchCount(oWnd,              ;
                                                                   otCntrlBatchGross, ;
                                                                   otCntrlBatchFed,   ;
                                                                   otCntrlBatchSt,    ;
                                                                   otCntrlBatchCount, ;
                                                                   otBatchGross,      ;
                                                                   otBatchFed,        ;
                                                                   otBatchSt,         ;
                                                                   otBatchCount,      ;
                                                                   oBtnLoad           ) } )

   otBatchGross:setEnabled(.F.)
   otBatchFed:setEnabled(.F.)
   otBatchSt:setEnabled(.F.)
   otBatchCount:setEnabled(.F.)

   otFileName:setEnabled(.F.)

   obAdd_or_Update := " "

   oBtnOk := QPushButton( oWnd )
   oBtnOk:setText( "Open File" )
   oBtnOk:move( 50, 340 )
   oBtnOk:Connect( "clicked()", {|| fileopen ( oWnd, otBatchGross, otBatchFed, otBatchSt, otBatchCount, otFileName, oBtnLoad, otCntrlBatchGross, otCntrlBatchFed, otCntrlBatchSt, otCntrlBatchCount) } )

   oBtnLoad := QPushButton( oWnd )
   oBtnLoad:setText( "Load Batch" )
   oBtnLoad:move( 200, 340 )
   oBtnLoad:Connect( "clicked()", {|| loadbatch( oWnd, otCntrlBatchGross, otCntrlBatchFed, otCntrlBatchSt, otCntrlBatchCount, otBatchDt, otBatchNum, otPerfNum, otFileName, oBtnLoad ) } )
   oBtnLoad:setEnabled(.F.)

   oBtnQuit := QPushButton( oWnd )
   oBtnQuit:setText( "Quit" )
   oBtnQuit:move( 350, 340 )
   oBtnQuit:Connect( "clicked()", {|| appquit () } )

   oSBar := QStatusBar( oWnd )
   oWnd:setStatusBar( oSBar )

   oSBar:showMessage( "Spreadsheet Upload Ready!" )

   oWnd:show()
   QApplication():exec(oWnd)

   RETURN

PROCEDURE appquit  (oWnd)
   hb_gcAll(oWnd)
   QApplication():quit(oWnd)
   RETURN