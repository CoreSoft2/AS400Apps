     H dftactgrp(*no) actgrp(*new) bnddir('RHUDSON191/REQ01BND')

      /Include RHUDSON191/QRPGLESRC,REQ01PROT

        //Display File for requisition
        dcl-f RQ01D1 workstn indds(Indicators);

        dcl-ds Indicators;
            F3 ind pos(3);
            F5 ind pos(5);
            F12 ind pos(12);
            F24 ind pos(24);
            reqlinefound ind pos(49);
            reqfound ind pos(50);
            newreq ind pos(51);
            newline ind pos(52);
            reqsearcherr ind pos(53);
            vendnoerror ind pos(54);
            shipadderr ind pos(55);
            linesearcherr ind pos(56);
            dlvrbyerr ind pos(57);
            itemerr ind pos(58);
            qtyerr ind pos(59);
            unitserr ind pos(60);
            glaccterr ind pos(61);
            itdescerr ind pos(62);
            markforerr ind pos(63);
            opt2selected ind pos(64);
            text1err ind pos(65);
            text2err ind pos(66);
            text3err ind pos(67);
            text4err ind pos(68);
            notifymsg ind pos(69);
        end-ds;


********************************************************************
      /Free


           DoW not F3 and not F12;

             exsr $execsearchscreen;

             if not f3 and not f12;

                TurnOffErrors();

                select;

                    when f5;
                        reqno = 0;

                    when reqno <> 0;
                        if FindReq(reqno) = *off;
                            errmsg = 'Req # not found. Try another number.';
                            reqsearcherr = *on;
                        else;
                            dsply 'req found';
                        endif;

                endsl;
             endif;
           EndDo;


          *inlr = *on;
      /End-Free


********************************************************************
      /FREE
            begsr $execsearchscreen;

             write searchfoot;
             exfmt search;

             endsr;
      /END-FREE
 ********************************************************************

