     H
     D MyString        s             50A   Inz('this is a test')
     D NewString       s             50A   Inz('Test String')
     D UpCase          c                   'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
     D LoCase          c                   'abcdefghijklmnopqrstuvwxyz'



     D To_Upper        PR            50A
     D String                        50A

     D MyFunc          PR


       /Free

           NewString = To_Upper(MyString);
           MyFunc();
           dsply MyString;
           dsply 'prog1';

           *inlr = *on;
       /End-Free

     P To_Upper        B                   Export
     D To_Upper        PI            50A
     D String                        50A
     D NewStr1         S             50A
       /Free
              NewStr1 = %Xlate(LoCase:UpCase:String);
              return NewStr1;
       /End-Free
     P To_Upper        E


     P MyFunc          B                   Export
     D NewStr2         S             50A

       /Free

              NewStr2 = 'hello world';
              dsply NewStr2;
       /End-Free
     P MyFunc          E
