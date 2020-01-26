/*
 * xHarbour 1.2.3 Intl. (SimpLex) (Build 20170902)
 * Generated C source code from <restart.prg>
 * Command: -orestart.c -m -n -p -q -gc0 -IC:\xHB\include -IC:\xHB\include\w32 restart.prg 
 * Created: 2018.01.31 16:58:40 (Pelles ISO C Compiler 3.0 (32-bit))
 */

#include "hbvmpub.h"
#include "hbinit.h"

#define __PRG_SOURCE__ "restart.prg"

/* Forward declarations of all PRG defined Functions. */
HB_FUNC( RESTART );

/* Forward declarations of all externally defined Functions. */
HB_FUNC_EXTERN( SCROLL );
HB_FUNC_EXTERN( SETPOS );
HB_FUNC_EXTERN( DEVPOS );
HB_FUNC_EXTERN( DEVOUT );
HB_FUNC_EXTERN( AADD );
HB_FUNC_EXTERN( __GET );
HB_FUNC_EXTERN( READMODAL );
HB_FUNC_EXTERN( SUBSTR );
HB_FUNC_EXTERN( DBSELECTAREA );
HB_FUNC_EXTERN( DBUSEAREA );
HB_FUNC_EXTERN( DBSETINDEX );
HB_FUNC_EXTERN( DBSEEK );
HB_FUNC_EXTERN( EOF );
HB_FUNC_EXTERN( __WAIT );
HB_FUNC_EXTERN( DBCLOSEALL );

#undef HB_PRG_PCODE_VER
#define HB_PRG_PCODE_VER 10

#include "hbapi.h"

HB_INIT_SYMBOLS_BEGIN( hb_vm_SymbolInit_RESTART )
{ "RESTART", {HB_FS_PUBLIC | HB_FS_LOCAL | HB_FS_FIRST}, {HB_FUNCNAME( RESTART )}, &ModuleFakeDyn },
{ "CHOICE", {HB_FS_PUBLIC}, {NULL}, NULL },
{ "SCROLL", {HB_FS_PUBLIC}, {HB_FUNCNAME( SCROLL )}, NULL },
{ "SETPOS", {HB_FS_PUBLIC}, {HB_FUNCNAME( SETPOS )}, NULL },
{ "DEVPOS", {HB_FS_PUBLIC}, {HB_FUNCNAME( DEVPOS )}, NULL },
{ "DEVOUT", {HB_FS_PUBLIC}, {HB_FUNCNAME( DEVOUT )}, NULL },
{ "AADD", {HB_FS_PUBLIC}, {HB_FUNCNAME( AADD )}, NULL },
{ "GETLIST", {HB_FS_PUBLIC}, {NULL}, NULL },
{ "__GET", {HB_FS_PUBLIC}, {HB_FUNCNAME( __GET )}, NULL },
{ "SSN", {HB_FS_PUBLIC}, {NULL}, NULL },
{ "DISPLAY", {HB_FS_PUBLIC}, {NULL}, NULL },
{ "READMODAL", {HB_FS_PUBLIC}, {HB_FUNCNAME( READMODAL )}, NULL },
{ "M_F2", {HB_FS_PUBLIC}, {NULL}, NULL },
{ "SUBSTR", {HB_FS_PUBLIC}, {HB_FUNCNAME( SUBSTR )}, NULL },
{ "KEY", {HB_FS_PUBLIC}, {NULL}, NULL },
{ "DBSELECTAREA", {HB_FS_PUBLIC}, {HB_FUNCNAME( DBSELECTAREA )}, NULL },
{ "DBUSEAREA", {HB_FS_PUBLIC}, {HB_FUNCNAME( DBUSEAREA )}, NULL },
{ "DBSETINDEX", {HB_FS_PUBLIC}, {HB_FUNCNAME( DBSETINDEX )}, NULL },
{ "DBSEEK", {HB_FS_PUBLIC}, {HB_FUNCNAME( DBSEEK )}, NULL },
{ "EOF", {HB_FS_PUBLIC}, {HB_FUNCNAME( EOF )}, NULL },
{ "__WAIT", {HB_FS_PUBLIC}, {HB_FUNCNAME( __WAIT )}, NULL },
{ "DBCLOSEALL", {HB_FS_PUBLIC}, {HB_FUNCNAME( DBCLOSEALL )}, NULL }
HB_INIT_SYMBOLS_EX_END( hb_vm_SymbolInit_RESTART, __PRG_SOURCE__,  0x000a )

#if defined( HB_PRAGMA_STARTUP )
   #pragma startup hb_vm_SymbolInit_RESTART
#elif defined( HB_DATASEG_STARTUP )
   #define HB_DATASEG_BODY    HB_DATASEG_FUNC( hb_vm_SymbolInit_RESTART )
   #include "hbiniseg.h"
#endif

HB_FUNC( RESTART )
{
   static const BYTE pcode[] =
   {
	133,3,0,106,2,32,0,81,1,0,134,2,108,2,
	100,92,11,121,92,24,92,79,20,4,108,3,100,92,
	11,121,20,2,134,3,108,4,100,92,13,92,15,20,
	2,108,5,100,106,6,83,83,78,58,32,0,20,1,
	134,4,108,4,100,92,15,92,15,20,2,108,5,100,
	106,54,69,110,116,101,114,32,108,97,115,116,32,83,
	83,78,32,115,117,99,99,101,115,102,117,108,108,121,
	32,112,114,105,110,116,101,100,46,32,69,110,116,101,
	114,32,70,50,32,116,111,32,101,120,105,116,46,0,
	20,1,134,6,108,3,100,92,13,92,20,20,2,108,
	6,100,98,7,0,108,8,100,89,25,0,1,0,0,
	0,95,1,100,8,28,7,98,9,0,25,8,95,1,
	21,81,9,0,6,106,7,109,45,62,115,115,110,0,
	106,12,57,57,57,45,57,57,45,57,57,57,57,0,
	100,100,12,5,20,2,48,10,0,98,7,0,92,255,
	1,112,0,73,134,8,108,11,100,98,7,0,100,100,
	100,100,100,100,20,7,4,0,0,81,7,0,98,7,
	0,73,134,10,98,12,0,106,2,89,0,5,28,7,
	134,11,100,110,7,134,14,108,13,100,98,9,0,122,
	92,3,12,3,108,13,100,98,9,0,92,5,92,2,
	12,3,72,108,13,100,98,9,0,92,8,92,4,12,
	3,72,81,14,0,134,15,108,15,100,106,2,49,0,
	20,1,134,16,108,16,100,9,100,106,6,112,97,121,
	101,101,0,100,100,9,100,100,20,8,108,17,100,106,
	6,112,97,121,101,101,0,20,1,134,17,108,18,100,
	98,14,0,100,100,20,3,134,18,108,19,100,12,0,
	28,75,134,19,108,4,100,92,14,92,20,20,2,108,
	5,100,106,45,83,83,78,32,110,111,116,32,102,111,
	117,110,100,32,105,110,32,100,97,116,97,98,97,115,
	101,46,32,80,108,101,97,115,101,32,116,114,121,32,
	97,103,97,105,110,46,0,20,1,134,20,108,20,100,
	20,0,26,86,254,134,26,108,21,100,20,0,134,27,
	100,110,7
   };

   hb_vmExecute( pcode, symbols );
}

