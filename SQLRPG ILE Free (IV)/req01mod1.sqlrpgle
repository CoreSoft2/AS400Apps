     H nomain

      /Include RHUDSON191/QRPGLESRC,REQ01PROT

      /Free

        //Function - Find Requisition
        //Purpose - Returns *on if requisition # found, *off if not found

         dcl-proc FindReq Export;

             dcl-pi *n ind;
                 inreqno packed(6) value;
             end-pi;


             exec sql
                select rhreqno
                 into: inreqno
                  from reqhead
                  where rhreqno = inreqno;

              if sqlcod = 0;
                return *on;

              else;
                return *off;

              endif;
         end-proc;


          dcl-proc TurnOffErrors Export;

            exfmt reqmaint;
            if f5;
                dsply 'i am here';
            endif;
          end-proc;

      /End-Free
