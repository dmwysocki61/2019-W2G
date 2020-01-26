/*       Name:  PTMath.ch
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
         Note:  This is an extra mathematic file for the Clipper Power
                Tools Library

*/

#xtranslate ADD <n1> TO <n2>                    => <n2>+=<n1>
#xtranslate SUBTRACT <n1> FROM <n2>             => <n2>-=<n1>
#xtranslate MULTIPLY <n1> BY <n2>               => <n2>*=<n1>
#xtranslate DIVIDE <n1> BY <n2>                 => <n1>/=<n2>
#xtranslate DIVIDE <n2> INTO <n1>               => <n1>/=<n2>
#xtranslate RAISE <n2> TO THE POWER OF <n1>     => <n2>^=<n1>
#xtranslate ADD <n1> TO <n2> INTO <n3>          => (<n3> := <n2>+<n1>)
#xtranslate SUBTRACT <n1> FROM <n2> INTO <n3>   => (<n3> := <n2>-<n1>)
#xtranslate MULTIPLY <n1> BY <n2> INTO <n3>     => (<n3> := <n2>*<n1>)
#xtranslate DIVIDE <n1> BY <n2> INTO <n3>       => (<n3> := <n1>/<n2>)

#xtranslate <n1> IS A MULTIPLE OF <n2>          => IIF(<n2> == 0, .f., ((<n1> % <n2>) == 0))

#xtranslate ISEVEN( <n1> )                      => empty( <n1> % 2 )
#xtranslate ISODD( <n1> )                       => !empty( <n1> % 2 )
#xtranslate NUMBER_STR( <n1> )                  => alltrim(str( <n1> ))
#xtranslate WHOLENUM( <n1> )                    => VAL(TRANSFORM(INT(IF((VALTYPE( <n1> ) != "N"), 0, <n1>)), "99999999999999999999"))
#xtranslate PERCENT( <n1> )                     => (<n1> * 100)
                                            
* End of File
