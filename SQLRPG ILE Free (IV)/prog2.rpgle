     H
     D MyString        s             50A   Inz('this is a test')
     D NewString       s             50A   Inz('Test String')
     D UpCase          c                   'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
     D LoCase          c                   'abcdefghijklmnopqrstuvwxyz'
      /include RHUDSON191/QRPGLESRC,PRTYPE


      /Free

           NewString = To_Upper(MyString);
           MyFunc();
           dsply NewString;
           dsply 'prog2';

           *inlr = *on;
      /End-Free


       dcl-proc To_Upper Export;
        dcl-pi To_Upper char(50);
            String char(50);
        end-pi;

        dcl-s NewStr1 char(50);
      /Free
              NewStr1 = %Xlate(LoCase:UpCase:String);
              NewStr1 = %trim(NewStr1) + ' Changed Again';
              dsply NewStr1;
              return NewStr1;
      /End-Free

       end-proc To_Upper;


           //P MyFunc          B
       dcl-proc MyFunc Export;
       dcl-s NewStr2 char(50);

           //D NewStr2         S             50A

      /Free

              NewStr2 = 'hello world';
              dsply NewStr2;
      /End-Free
            //P MyFunc          E
       end-proc MyFunc;
