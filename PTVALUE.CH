/*       Name:  PTValue.ch
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
         Link:  RTLink FI 
 Library Path:  \Clipper\501
         Note:  This header file is for the Clipper Power Tools Library
                for all of the needed manifest constants.

*/

// Miscelaneous manifest constants

#define RETRUN return
#define retrun return
#define pCRLF chr(13)+chr(10)
#define pTRUE .t.
#define pFALSE .f.
#define pPI 3.1415926535897932384
#define pON .t.
#define pOFF .f.

// The following are the manifest constants for the register for the
// INTERUPT86() function

#define pREGISTERS aRegister
#define pAX aRegister[1]
#define pBX aRegister[2]
#define pCX aRegister[3]
#define pDX aRegister[4]
#define pSI aRegister[5]
#define pDI aRegister[6]
#define pBP aRegister[7]
#define pDS aRegister[8]
#define pES aRegister[9]
#define pREG_FLAG aRegister[10]

#define pAX_REG 1
#define pBX_REG 2
#define pCX_REG 3
#define pDX_REG 4
#define pSI_REG 5
#define pDI_REG 6
#define pBP_REG 7
#define pDS_REG 8
#define pES_REG 9
#define pFLAG_REG 10

#define pMOUSE_REGISTERS MouseStat()[1]
#define pMOUSE_XCOORD    MouseStat()[2, 1]
#define pMOUSE_YCOORD    MouseStat()[2, 2]
#define pMOUSE_HORZONTAL MouseStat()[2, 3]
#define pMOUSE_VERTICLE  MouseStat()[2, 4]
#define pMOUSE_STATUS    MouseStat()[2, 5]

#define DOS_INT   33
#define MOUSE_INT 51

// The following are manifest constants for graphic keys
#define pDBAR      "ÉÍ»º¼ÍÈº "
#define pSBAR      "ÚÄ¿³ÙÄÀ³ "

// The following are manifest constants for the setcursor() function
#define pCURSOR_OFF 0
#define pCURSOR_ON 1
#define pCURSOR_LOWER 2
#define pCURSOR_BLOCK 3
#define pCURSOR_UPPER 4

// The following manifest constants are for the various data
// types in the Clipper language

#define pARRAY     "A"
#define pBLOCK     "B"
#define pCHARACTER "C"
#define pDATE      "D"
#define pLOGICAL   "L"
#define pMEMO      "M"
#define pNUMERIC   "N"
#define pOBJECT    "O"

// The following manifest constants pertain to the SET() function
// and the various environmental values.

#define pEXACT         1
#define pFIXED         2
#define pDECIMALS      3
#define pDATEFORMAT    4
#define pEPOCH         5
#define pPATH          6
#define pDEFAULT       7
#define pEXCLUSIVE     8
#define pSOFTSEEK      9
#define pUNIQUE       10
#define pDELETED      11
#define pCANCEL       12
#define pDEBUG        13
#define pTYPEAHEAD    14
#define pCOLOR        15
#define pCURSOR       16
#define pCONSOLE      17
#define pALTERNATE    18
#define pALTFILE      19
#define pDEVICE       20
#define pEXTRA        21
#define pEXTRAFILE    22
#define pPRINTER      23
#define pPRINTFILE    24
#define pMARGIN       25
#define pBELL          26
#define pCONFIRM       27
#define pESCAPE        28
#define pINSERT        29
#define pEXIT          30
#define pINTENSITY     31
#define pSCOREBOARD    32
#define pDELIMITERS    33
#define pDELIMCHARS    34
#define pWRAP          35
#define pMESSAGE       36
#define pMCENTER       37
#define pSCROLLBREAK   38
#define pCOUNT         38

* End of File
