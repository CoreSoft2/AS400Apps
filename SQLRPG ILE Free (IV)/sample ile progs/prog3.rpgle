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
           dsply NewString;
           dsply 'prog3';

           *inlr = *on;
       /End-Free
