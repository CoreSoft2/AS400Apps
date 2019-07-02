     Frq01d1    CF   E             WorkStn INDDS(Indicators)
     Freqhead   UF A E           K Disk    rename(reqhead:reqheadr)
     Freqline   UF A E           K Disk    rename(reqline:reqliner)
     Freqtext   UF A E           K Disk    rename(reqtext:reqtextr)

     DIndicators       DS
     DF3                       3      3n
     DF5                       5      5n
     DF12                     12     12n
     DF24                     24     24n
     Dreqlinefound            49     49n
     Dreqfound                50     50n
     Dnewreq                  51     51n
     Dnewline                 52     52n
     Dreqsearcherr            53     53n
     Dvendnoerr               54     54n
     Dshipadderr              55     55n
     Dlinesearcherr           56     56n
     Ddlvrbyerr               57     57n
     Ditemerr                 58     58n
     Dqtyerr                  59     59n
     Dunitserr                60     60n
     Dglaccterr               61     61n
     Ditdescerr               62     62n
     Dmarkforerr              63     63n
     Dopt2selected            64     64n
     Dtext1err                65     65n
     Dtext2err                66     66n
     Dtext3err                67     67n
     Dtext4err                68     68n
     Dnotifymsg               69     69n

     Duser             s             10    INZ(*USER)
     Derrordte         s              8  0
     Daddress1         c                   CONST('123 Cherry Street')
     Daddress2         c                   CONST('Unit 25')
     Daddress3         c                   CONST('Miami, FL 33101')
     DUpdTxtErr1       c                   CONST(' Cannot update text to blank')
     DUpdTxtErr2       c                   CONST('. Use F11 to delete.')
     DUpdTxtMsg        c                   CONST('Requisition Updated. ')
     DF1HelpMsg        c                   CONST(' or F1 for help.') 
     DCrtInitMsg1      c                   CONST('Press <ENTER> to create a ') 
     DCrtInitMsg2      c                   CONST('new requisition')
     DChangeMsg1       c                   CONST('Make changes and press <ENT')
     DChangeMsg2       c                   CONST('ER> to update requisition.')
                                           
********************************************************************
      /FREE

         Dow not f3 and not f12;

            select;

               when reqfound = *off and newreq = *off;
                  exsr $searchreq;

               when reqfound = *on;
                  exsr $turnofferrors;
                  exsr $editreq;

               when newreq = *on;
                  exsr $turnofferrors;
                  exsr $createreq;

            endsl;

         enddo;

         *inlr = *on;
         return;
      /END-FREE
********************************************************************
      /FREE
         begsr $execsearchscreen;

         write searchfoot;
         exfmt search;


         endsr;
      /END-FREE
 ********************************************************************
      /FREE
         begsr $execreqscreen;

         if not newreq;
            errmsg = 'Displaying more function key options';

            if (not f24 and opt2selected = *off) or
               (f24 and opt2selected = *on);
                  write reqfoot;
                  opt2selected = *off;

            elseif f24 and opt2selected = *off;
                  write reqfoot2;
                  opt2selected = *on;
            endif;

         else;
            write searchfoot;
         endif;

         exfmt reqmaint;

         endsr;
      /END-FREE
  ********************************************************************
      /FREE
         begsr $checksearcherrors;

         reqsearcherr = *off;

         chain(N) (reqno) reqhead;

         if %found(reqhead);

            reqfound = *on;

         else;
            reqsearcherr = *on;
            errmsg = 'Req # not found. Try another number.';
         endif;

         endsr;
      /END-FREE
********************************************************************
      /FREE
         begsr $searchreq;
         
         if not f5 and errmsg = '';
            errmsg = 'Press <ENTER> to continue' +
                     f1helpmsg;
            notifymsg = *on;  
         endif;
         
         exsr $execsearchscreen; 

         reqsearcherr = *off;
         notifymsg = *off;

         select;

            when f3 or f12;

            when f5;
               reqno = 0;
               errmsg = 'Screen refreshed. Press <ENTER> to continue' +
                         f1helpmsg; 
               notifymsg = *on;  
 
            when reqno = 0;
               newreq = *on;

            when reqno <> 0;
               exsr $checksearcherrors;

         endsl;

         endsr;
      /END-FREE
********************************************************************
      /FREE
         begsr $createreq;

         exsr $initcreatescreen;

         DoW not F3 and not F12;
            exsr $execreqscreen;

            select;

               when f3 or f12;
                  reqno = 0;
                  errmsg = '';

               when f5;
                  exsr $initcreatescreen;

               when f24;

               other;
                  exsr $checkreqerrors;

                  if errmsg = '';
                     exsr $execcreatereq;
                     exsr $editreq;
                     leave;
                  endif;

            endsl;
         enddo;

         newreq = *off;
         f12 = *off;

         endsr;
      /END-FREE
********************************************************************
      /FREE
         begsr $execcreatereq;

         //create req head---------------------------- 
        clear reqheadr;
  
         exec sql
            select max(rhreqno) into: rhreqno
            from reqhead;

         if sqlcod = 0;  
            rhreqno = rhreqno + 1;

         else;  
            rhreqno = 1;
         endif; 
 
         exsr $setreqheadf;

         rhcrtby = crtby;
         rhcrtdte = %dec(%date():*USA);

         write reqheadr; 
           
         reqno = rhreqno;
         //end create req head------------------------
         
 
         //create req line----------------------------
         clear reqliner;

         exec sql
            select max(rlseqno) into: rlseqno
            from reqline
            where RLREQNO = :reqno;

         if sqlcod = 0;
            rlseqno = rlseqno + 1;
         else;
            rlseqno = 1;
         endif;

         rlreqno = reqno;

         exsr $setreqlinef;

         rlcrtby = crtby;
         rlcrtdte = %dec(%date():*USA);

         write reqliner;

         lineno = rlseqno; 
         //end create req head------------------------


         //create req text----------------------------
         exsr $addupdtext;


         endsr;
      /END-FREE
 ********************************************************************
      /FREE
         begsr $editreq;

         //load requisition
         exsr $initeditscreen; 

         DoW not F3 and not F12; 
         
            exsr $execreqscreen;
            exsr $turnofferrors;

            select;

               when f3 or f12;
                  reqno = 0;
                  errmsg = '';

               when f5;
                  exsr $initeditscreen;

               when f24;

               other;
                  exsr $checkreqerrors;

                  if errmsg = '';
                     exsr $execupdatereq;
                     
                     if errmsg = '';
                        errmsg = 'No changes made. ' + 
                                  changemsg1 + changemsg2; 
                        notifymsg = *on;
                     endif;
                     
                  endif;

            endsl;
         enddo;

         reqfound = *off;
         f12 = *off;

         endsr;
      /END-FREE
 ********************************************************************
      /FREE
         begsr $checkreqerrors;

         exsr $turnofferrors;

         if markfor = '';
            markforerr = *on;
            errmsg = 'ERROR: Mark For cannot be blank.';
         endif;

         if errmsg = '' and shipadd1 = '' and shipadd2 = ''
            and shipadd3 = '';
            shipadderr = *on;
            errmsg = 'Must have an address to ship to.';
         endif;

         if errmsg = '';
            monitor;
               errordte = %dec(%date(dlvrby:*USA));

               if %date(dlvrby:*USA) < %date();
                  dlvrbyerr = *on;
                  errmsg = 'ERROR: Delivery date must be today or greater.';
               endif;

            on-error;
               dlvrbyerr = *on;
               errmsg = 'ERROR: Invalid delivery date.';
            endmon;
         endif;

         if errmsg = '' and item <> 0;
            //item division check

            if %subst(%char(item):1:1) <> '1' and
               %subst(%char(item):1:1) <> '5' and
               %subst(%char(item):1:1) <> '7' and
               %subst(%char(item):1:1) <> '9';
               itemerr = *on;
               errmsg = 'ERROR: Item division must be 1, 5, 7, or 9.';
            elseif %len(%trim(%char(item))) < 8;
               itemerr = *on;
               errmsg = 'ERROR: Item must be 8 digits long.';
            endif;

            //elseif not found - error
         endif;

         if errmsg = '' and qty <= 0;
            qtyerr = *on;
            errmsg = 'ERROR: Quantity must be greater than zero.';
         endif;

         if errmsg = '' and units = '';
            unitserr = *on;
            errmsg = 'ERROR: Units cannot be blank.';
         endif;

         if errmsg = '' and glacct = 0;
            glaccterr = *on;
            errmsg = 'ERROR: General Ledger Account # cannot be blank.';
         endif;

         if errmsg = '' and item <> 0;
            if %subst(%char(item):1:1) <> %subst(%char(glacct):1:1);
               glaccterr = *on;
               errmsg = 'ERROR: General Ledger division # must match ' +
               'the item division #.';
            endif;
         endif;

         if errmsg = '';
            if %subst(%char(glacct):1:1) <> '1' and
               %subst(%char(glacct):1:1) <> '5' and
               %subst(%char(glacct):1:1) <> '7' and
               %subst(%char(glacct):1:1) <> '9';
               glaccterr = *on;
               errmsg = 'ERROR: General Ledger division must be ' +
                        '1, 5, 7, or 9.';
            elseif %len(%trim(%char(glacct))) < 9;
               glaccterr = *on;
               errmsg = 'ERROR: General Ledger Account # must be ' +
                        '9 digits long.';
            endif;
         endif;

         if errmsg = '' and item = 0 and itdesc = '';
            itemerr = *on;
            itdescerr = *on;
            errmsg = 'ERROR: Must have an item # or an item description.';
         endif;
         
           
         
         if errmsg = '' and text1 = '' and textkey1 <> 0; 
            text1err = *on;
            errmsg = 'ERROR: ' + updtxterr1 + updtxterr2;
         endif;
         
         if errmsg = '' and text2 = '' and textkey2 <> 0; 
            text2err = *on;
            errmsg = 'ERROR: ' + updtxterr1 + updtxterr2;
         endif;
         
         if errmsg = '' and text3 = '' and textkey3 <> 0; 
            text3err = *on;
            errmsg = 'ERROR: ' + updtxterr1 + updtxterr2;
         endif;
         
         if errmsg = '' and text4 = '' and textkey4 <> 0; 
            text4err = *on;
            errmsg = 'ERROR: ' + updtxterr1 + updtxterr2;
         endif;
         

         endsr;
      /END-FREE
 ********************************************************************
      /FREE
         begsr $turnofferrors;
             
            errmsg = '';
            markforerr = *off;
            dlvrbyerr = *off;
            qtyerr = *off;
            unitserr = *off;
            glaccterr = *off;
            itemerr = *off;
            itdescerr = *off;
            shipadderr = *off;
            text1err = *off;
            text2err = *off;
            text3err = *off;
            text4err = *off;
            notifymsg = *off;


         endsr;
      /END-FREE
 ********************************************************************
      /FREE
         begsr $writetextline;

         exec sql
            select max(rttextno) into: rttextno
            from reqtext
            where RTREQNO = :reqno
            and RTSEQNO = :rlseqno;

         if sqlcod = 0;
            rttextno = rttextno + 1;
         else;
            rttextno = 1;
         endif;

         rtreqno = reqno;
         rtseqno = lineno;
         rtcrtby = crtby;
         rtcrtdte = %dec(%date():*USA);

         write reqtextr;

         if reqfound = *on; 
            errmsg = updtxtmsg + changemsg1 + changemsg2; 
            notifymsg = *on;
         endif;

         endsr;
      /END-FREE
 ********************************************************************
      /FREE
         begsr $loadreqhead;

         pgmheader = 'Edit Requisition';
                   reqno = rhreqno;
                   crtby = rhcrtby;
                   markfor = rhmarkfor;
                   reqfor = rhreqfor;
                   vendno = rhvendno;
                   projno = rhprojno;
                   vendname = rhvendname;
                   shipadd1 = rhshipadd1;
                   shipadd2 = rhshipadd2;
                   shipadd3 = rhshipadd3;
                   vendadd1 = rhvendadd1;
                   vendadd2 = rhvendadd2;
                   vendadd3 = rhvendadd3;

         endsr;
      /END-FREE
 ********************************************************************
      /FREE
         begsr $loadreqline;

            chain(N) (rhreqno) reqline;

            if %found(reqline);
                      pgmheader2 = 'Edit Requisition Line';
                      lineno = rlseqno;
                      dlvrby = rldlvrby;

                      if rlitem <> '';
                         item = %int(rlitem);
                      else;
                         item = 0;
                      endif;

                      qty = rlqty;
                      units = rlunits;
                      venditem = rlvenditem;
                      glacct = rlglacct;
                      itdesc = rlitdesc;
                   else;
                      pgmheader2 = 'New  Requisition Line';
                      lineno = 1;
                      dlvrby = %dec(%date():*USA);
                   endif;

         endsr;
      /END-FREE
 ********************************************************************
      /FREE
         begsr $loadreqtext;

         setll *loval reqtext;
         chain(N) (rlreqno:rlseqno) reqtext;

         if %found(reqtext);
            text1 = rttext;
            textkey1 = rttextno;

            reade(N) (reqno:rlseqno) reqtext;

            if not %eof(reqtext);
               text2 = rttext;
               textkey2 = rttextno;

               reade(N) (reqno:rlseqno) reqtext;
               if not %eof(reqtext);
                  text3 = rttext;
                  textkey3 = rttextno;

                  reade(N) (reqno:rlseqno) reqtext;
                  if not %eof(reqtext);
                     text4 = rttext;
                     textkey4 = rttextno;

                  else;
                     text4 = '';
                  endif;

               else;
                  text3 = '';
                  text4 = '';
               endif;

            else;
               text2 = '';
               text3 = '';
               text4 = '';
            endif;

         else;
            text1 = '';
            text2 = '';
            text3 = '';
            text4 = '';
         endif;


         endsr;
      /END-FREE
 ********************************************************************
      /FREE
         begsr $execupdatereq;

            chain (reqno) reqhead;

            if markfor <> rhmarkfor or reqfor <> rhreqfor or
               vendno <> rhvendno or vendname <> rhvendname or
               projno <> rhprojno or shipadd1 <> rhshipadd1 or
               shipadd2 <> rhshipadd2 or shipadd3 <> rhshipadd3 or
               vendadd1 <> rhvendadd1 or vendadd2 <> rhvendadd2 or
               vendadd3 <> rhvendadd3;

               exsr $setreqheadf;
               rhchgby = user;
               rhchgdte = %dec(%date():*USA);

               update reqheadr;
               errmsg = updtxtmsg + changemsg1 + changemsg2; 
               notifymsg = *on;

            endif;

            chain(N) (reqno) reqhead;

            chain (reqno:lineno) reqline;

            if dlvrby <> rldlvrby or %editc(item:'Z') <> rlitem or
               qty <> rlqty or
               units <> rlunits or venditem <> rlvenditem or
               glacct <> rlglacct or itdesc <> rlitdesc;

               exsr $setreqlinef;
               rlchgby = user;
               rlchgdte = %dec(%date():*USA);

               update reqliner;
               errmsg = updtxtmsg + changemsg1 + changemsg2; 
               notifymsg = *on;

            endif;

            chain(N) (reqno:lineno) reqline;

            exsr $addupdtext;


         endsr;
      /END-FREE
 ********************************************************************
      /FREE
         begsr $setreqheadf;

         rhmarkfor = markfor;
         rhreqfor = reqfor;
         rhprojno = projno;
         rhvendno = vendno;
         rhvendname = vendname;
         rhshipadd1 = shipadd1;
         rhshipadd2 = shipadd2;
         rhshipadd3 = shipadd3;
         rhvendadd1 = vendadd1;
         rhvendadd2 = vendadd2;
         rhvendadd3 = vendadd3;

         endsr;
      /END-FREE
 ********************************************************************
      /FREE
         begsr $setreqlinef;

         rldlvrby = dlvrby;

         if item <> 0;
            rlitem = %char(item);
         else;
            rlitem = '';
         endif;

         rlqty = qty;
         rlunits = units;
         rlvenditem = venditem;
         rlglacct = glacct;
         rlitdesc = itdesc;

         endsr;
      /END-FREE
 ********************************************************************
      /FREE
         begsr $addupdtext;

         if text1 <> '';
            if textkey1 = 0; //write
               rttext = text1;
               exsr $writetextline;
               textkey1 = rttextno;
            else;//update
               chain (reqno:lineno:textkey1) reqtext;

               if rttext <> text1;
                  rttext = text1;
                  exsr $execupdatetext;
               endif;

               chain(N) (reqno:lineno:textkey1) reqtext;

            endif; 
         endif;

         if text2 <> '';

            if textkey2 = 0; //write
               rttext = text2;
               exsr $writetextline;
               textkey2 = rttextno;
            else;//update

               chain (reqno:lineno:textkey2) reqtext;

               if rttext <> text2;
                  rttext = text2;
                  exsr $execupdatetext;
               endif;

               chain(N) (reqno:lineno:textkey2) reqtext;
            endif; 
         endif;

         if text3 <> '';

            if textkey3 = 0; //write
               rttext = text3;
               exsr $writetextline;
               textkey3 = rttextno;
            else;//update
               chain (reqno:lineno:textkey3) reqtext;

               if rttext <> text3;
                  rttext = text3;
                  exsr $execupdatetext;
               endif;

               chain(N) (reqno:lineno:textkey3) reqtext;

            endif; 
         endif;

         if text4 <> '';

            if textkey4 = 0; //write
               rttext = text4;
               exsr $writetextline;
               textkey4 = rttextno;
            else;//update

               chain (reqno:lineno:textkey4) reqtext;

               if rttext <> text4;
                  rttext = text4;
                  exsr $execupdatetext;
               endif;

               chain(N) (reqno:lineno:textkey4) reqtext;
            endif; 
         endif;


         endsr;
      /END-FREE 
 ********************************************************************
      /FREE
         begsr $initcreatescreen;

         exsr $turnofferrors;
         clear reqmaint;
         pgmheader = 'New  Requisition';
         pgmheader2 = 'New  Requisition Line';
          
         shipadd1 = address1;
         shipadd2 = address2;
         shipadd3 = address3;
         lineno = 1;
         crtby = user;
         dlvrby = %dec(%date():*USA);
         
         if f5;
            errmsg = 'Screen refreshed.'; 
            errmsg = %trim(errmsg) + ' ' + CrtInitMsg1 + CrtInitMsg2;
         else; 
            errmsg = CrtInitMsg1 + CrtInitMsg2;
         endif;
         
         errmsg = %trim(errmsg) + f1helpmsg;
         
         notifymsg = *on;

         endsr;
      /END-FREE
 ********************************************************************
      /FREE
         begsr $initeditscreen;

         reqfound = *on;
         
         exsr $turnofferrors;
         clear reqmaint;
         exsr $loadreqhead;
         exsr $loadreqline;
         exsr $loadreqtext;
          
         notifymsg = *on;
          
          
            errmsg = 'Requisition ' + %char(reqno); 
          
         if newreq = *on;
            errmsg = %trim(errmsg) + ' added. ' + changemsg1 + changemsg2;
            newreq = *off;
         else;
            if f5;
               errmsg = %trim(errmsg) + ' refreshed.';
            else; 
               errmsg = %trim(errmsg) + ' found.';
            endif; 
               errmsg = %trim(errmsg) + ' ' + changemsg1 + changemsg2;
        endif;

         endsr;
      /END-FREE
 ******************************************************************** 
      /FREE
         begsr $execupdatetext;

         rtchgby = user;
         rtchgdte = %dec(%date():*USA); 
         errmsg = updtxtmsg + changemsg1 + changemsg2; 
         notifymsg = *on;
         
         update reqtextr;

         endsr;
      /END-FREE
 ********************************************************************






