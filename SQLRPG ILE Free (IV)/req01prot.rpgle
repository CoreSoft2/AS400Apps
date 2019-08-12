
        //Prototypes

        //Data structure for program indicators
        //Function - Find Requisition
        //Purpose - Returns *on if requisition # found, *off if not found

        dcl-pr FindReq ind;
            reqno packed(6) value;
        end-pr;

        dcl-pr TurnOffErrors;
        end-pr;
