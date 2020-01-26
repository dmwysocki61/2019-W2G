/*       Name:  PTFiles.ch
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
         Link:  N/A
 Library Path:  \Clipper\501
         Note:  This is the header file for the FILE operations

*/

// the following are the manifest constants for the various
// toggles for the functions in the file-oriented operations

#define pFS_INIT 0
#define pFS_ADD 1
#define pFS_OBTAIN 2
#define pFS_DBF_ONLY 1
#define pFS_NTX_ONLY 2
#define pFS_BOTH 3

// the following are the commands to help out with the
// various functions for the file-oriented operations

#xtranslate ADDFIELD( <name>, <type>, <length> [, <dec>] ) => ;
            {<(name)>, <(type)>, <length>, <dec>}

#xcommand DATABASE [FILE <name>] FIELD <aArray> => ;
          FileStru(, <(name)>, <aArray> )

#xcommand DATABASE FILE <file> STRUCTURE <diskFile> => ;
           FileStru(, <(file)>, GetStru( <(diskFile)> ) )

#xtranslate SYSTEM DATABASE [AREA <area>] TO <name> ;
                                          [ALIAS <alias>];
                                          [EXTENSION <ext>];
                                          [PATH <path>];
                                          [DESCRIPTION <*desc*>] => ;
      FileSystem(,<area>, DbfSystem( <(name)>, <(alias)>, <(ext)>, ;
                                     <(path)>, <(desc)> ) )

#xtranslate SYSTEM INDEX [AREA <area>] TO <name> ;
                                       ON <expression> ;
                                       [ROOT <root>] ;
                                       [PATH <path>] ;
                                       [DESCRIPTION <*desc*>] => ;
        FileSystem(,<(area)>,,NtxSystem( <(expression)>, ;
                                         <(name)>, ;
                                         <(root)>, ;
                                         <(path)>, ;
                                         <(desc)> ) )

#xtranslate  OBTAIN SYSTEM [FILE <name>] TO <var> => ;
         <var> := FileSystem( pFS_OBTAIN, <(name)> )

#xcommand REINDEX [<*files*>] => ;
          FileMake([{<"files">}] , pFS_NTX_ONLY, pTRUE )

#xcommand OPEN FILES [<*files*>] => FileOpen([{<"files">}])
#xcommand OPEN FILE [<*files*>] => OPEN FILES [<files>]

#xcommand CLOSE FILES [<*files*>] => FileClose([{<"files">}])
#xcommand CLOSE FILE [<*files*>] => CLOSE FILES [<files>]

* End of FIle
