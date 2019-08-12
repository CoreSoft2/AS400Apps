     H dftactgrp(*no) actgrp(*new) bnddir('RHUDSON191/TSTBNDDIR')

        dcl-s mystring char(50);
        dcl-s mynum zoned(5);

      /Include RHUDSON191/QRPGLESRC,PRTYPE

      /Free

            mystring = 'here is my sentence';

            MyFunc();

            mystring = To_Upper(mystring);

            for mynum = 1 to 2;
                dsply mystring;
            endfor;



           *inlr = *on;
      /End-Free

