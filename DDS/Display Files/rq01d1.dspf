     A*%%TS  SD  20190416  213016  USER0024    REL-V7R3M0  5770-WDS
     A*%%EC
     A                                      DSPSIZ(24 80 *DS3)
     A                                      INDARA
     A          R SEARCH
     A*%%TS  SD  20190416  210808  USER0024    REL-V7R3M0  5770-WDS
     A                                      CA03(03 'Exit')
     A                                      CA05(05 'Refresh')
     A                                      CA12(12 'Cancel')
     A                                      OVERLAY
     A                                  1  2'RQ01'
     A                                      COLOR(BLU)
     A                                  2  2USER
     A                                      COLOR(BLU)
     A                                  1 73DATE
     A                                      EDTCDE(Y)
     A                                      COLOR(BLU)
     A                                  2 73TIME
     A                                      COLOR(BLU)
     A                                  1 32'Requisition System'
     A                                      COLOR(WHT)
     A                                  2 28'Create/Lookup Requisition'
     A                                      COLOR(BLU)
     A                                      DSPATR(UL)
     A                                  4 34'Req #:'
     A                                      COLOR(WHT)
     A            REQNO          6Y 0B  4 41EDTCDE(Z)
     A  53                                  DSPATR(RI)
     A                                  9 27'PRESS <ENTER> WITH NO REQ #'
     A                                      COLOR(RED)
     A                                 11 40'OR'
     A                                      COLOR(RED)
     A                                 13 24'TYPE REQ # TO LOOKUP A REQUISITION'
     A                                      COLOR(RED)
     A            ERRMSG        75A  O 23  3
     A N69                                  COLOR(RED)
     A  69                                  COLOR(WHT)
     A                                  7 27'TO CREATE A NEW REQUISITION'
     A                                      COLOR(RED)
     A          R REQMAINT
     A*%%TS  SD  20190416  213016  USER0024    REL-V7R3M0  5770-WDS
     A                                      CA03(03 'Exit')
     A                                      CA05(05 'Refresh')
     A                                      CA12(12 'Cancel')
     A                                      CF24(24 'Toggle Options')
     A                                      OVERLAY
     A                                  1  2'RQ01'
     A                                      COLOR(BLU)
     A                                  2  2USER
     A                                      COLOR(BLU)
     A                                  1 32'Requisition System'
     A                                      COLOR(WHT)
     A                                  1 73DATE
     A                                      EDTCDE(Y)
     A                                      COLOR(BLU)
     A                                  2 73TIME
     A                                      COLOR(BLU)
     A                                  4 34'Req #:'
     A                                      COLOR(WHT)
     A            REQNO          6Y 0O  4 41EDTCDE(Z)
     A            PGMHEADER     16A  O  2 33COLOR(BLU)
     A                                      DSPATR(UL)
     A                                  5  3'Req created by:'
     A                                      COLOR(WHT)
     A                                  6  3'Requsitioned for:'
     A                                      COLOR(WHT)
     A                                  6 44'Vendor #:'
     A                                      COLOR(WHT)
     A                                  7 44'Vendor Name:'
     A                                      COLOR(WHT)
     A                                  5 44'Mark For:'
     A                                      COLOR(WHT)
     A                                  7  3'Project #:'
     A                                      COLOR(WHT)
     A                                 14  3'Search Line #:'
     A                                      COLOR(WHT)
     A  51                                  DSPATR(ND)
     A                                 15 22'Item #  '
     A                                      DSPATR(UL)
     A                                      COLOR(WHT)
     A                                 15 47'Vendors X-Ref Item #'
     A                                      COLOR(WHT)
     A                                      DSPATR(UL)
     A                                 15 70'GL Acct #'
     A                                      COLOR(WHT)
     A                                      DSPATR(UL)
     A                                 15 42'U/M'
     A                                      COLOR(WHT)
     A                                      DSPATR(UL)
     A                                 18  5'Item Desc:'
     A                                      COLOR(WHT)
     A                                 19  4'Other Text:'
     A                                      COLOR(WHT)
     A                                  8 44'Vendor Address'
     A                                      COLOR(WHT)
     A                                      DSPATR(UL)
     A                                 15  2'Line #'
     A                                      DSPATR(UL)
     A                                      COLOR(WHT)
     A                                  8  3'Ship To Address'
     A                                      COLOR(WHT)
     A                                      DSPATR(UL)
     A            SEARCHLINE     3Y 0B 14 18EDTCDE(Z)
     A  56                                  DSPATR(RI)
     A  51                                  DSPATR(ND)
     A  56                                  DSPATR(PC)
     A  51                                  DSPATR(PR)
     A            LINENO         3Y 0O 16  5EDTCDE(Z)
     A            CRTBY         10A  O  5 19
     A            MARKFOR       20A  B  5 54
     A  63                                  DSPATR(RI)
     A  63                                  DSPATR(PC)
     A            REQFOR        20A  B  6 21
     A            VENDNO         5Y 0B  6 54EDTCDE(Z)
     A  54                                  DSPATR(RI)
     A  54                                  DSPATR(PC)
     A            VENDNAME      20A  B  7 57
     A            PROJNO        15A  B  7 14
     A            QTY            6Y 0B 16 32EDTCDE(O)
     A  59                                  DSPATR(RI)
     A  59                                  DSPATR(PC)
     A            UNITS          3A  B 16 42
     A  60                                  DSPATR(RI)
     A  60                                  DSPATR(PC)
     A            VENDITEM      20A  B 16 47
     A            GLACCT         9Y 0B 16 70EDTCDE(Z)
     A  61                                  DSPATR(RI)
     A  61                                  DSPATR(PC)
     A                                 15 32'Quantity'
     A                                      COLOR(WHT)
     A                                      DSPATR(UL)
     A                                 14 35'999=Last Line'
     A                                      COLOR(BLU)
     A  51                                  DSPATR(ND)
     A                                 14 50'PgUp=Prev. Line'
     A                                      COLOR(BLU)
     A  51                                  DSPATR(ND)
     A                                 14 67'PgDn=Next Line'
     A                                      COLOR(BLU)
     A  51                                  DSPATR(ND)
     A                                 14 22'SEARCH HELP:'
     A                                      COLOR(BLU)
     A  51                                  DSPATR(ND)
     A            ITDESC        40A  B 18 16
     A  62                                  DSPATR(RI)
     A            TEXT1         40A  B 19 16
     A  65                                  DSPATR(RI)
     A  65                                  DSPATR(PC)
     A            TEXT2         40A  B 20 16
     A  66                                  DSPATR(RI)
     A  66                                  DSPATR(PC)
     A            TEXT3         40A  B 21 16
     A  67                                  DSPATR(RI)
     A  67                                  DSPATR(PC)
     A            TEXT4         40A  B 22 16
     A  68                                  DSPATR(RI)
     A  68                                  DSPATR(PC)
     A            SHIPADD1      30A  B  9  3
     A  55                                  DSPATR(RI)
     A  55                                  DSPATR(PC)
     A            SHIPADD2      30A  B 10  3
     A            SHIPADD3      30A  B 11  3
     A            VENDADD1      30A  B  9 44
     A            VENDADD2      30A  B 10 44
     A            VENDADD3      30A  B 11 44
     A                                 15 10'Deliver By'
     A                                      COLOR(WHT)
     A                                      DSPATR(UL)
     A            DLVRBY         8Y 0B 16 10EDTCDE(Y)
     A  57                                  DSPATR(RI)
     A  57                                  DSPATR(PC)
     A            ITEM           8Y 0B 16 22
     A  58                                  DSPATR(RI)
     A  58                                  DSPATR(PC)
     A                                      EDTCDE(Z)
     A            PGMHEADER2    21A  O 13 30COLOR(BLU)
     A                                      DSPATR(UL)
     A            TEXTKEY1       3S 0O 19 58
     A            TEXTKEY2       3S 0O 20 58
     A            TEXTKEY3       3S 0O 21 58
     A            TEXTKEY4       3S 0O 22 58
     A            ERRMSG        75   O 23  3
     A N69                                  COLOR(RED)
     A  69                                  COLOR(WHT)
     A          R SEARCHFOOT
     A*%%TS  SD  20190412  141017  USER0024    REL-V7R3M0  5770-WDS
     A                                 24 11'F3=Exit'
     A                                      COLOR(BLU)
     A                                 24 20'F5=Refresh'
     A                                      COLOR(BLU)
     A                                 24  3'F1=Help'
     A                                      COLOR(BLU)
     A                                 24 67'F12=Cancel'
     A                                      COLOR(BLU)
     A          R REQFOOT
     A*%%TS  SD  20190411  215737  USER0024    REL-V7R3M0  5770-WDS
     A                                 24 11'F3=Exit'
     A                                      COLOR(BLU)
     A                                 24 20'F5=Refresh'
     A                                      COLOR(BLU)
     A                                 24  2'F1=Help'
     A                                      COLOR(BLU)
     A                                 24 32'F6=Create Line'
     A                                      COLOR(BLU)
     A                                 24 48'F7=Delete Line'
     A                                      COLOR(BLU)
     A                                 24 64'F24=More Options'
     A                                      COLOR(BLU)
     A          R REQFOOT2
     A*%%TS  SD  20190411  215737  USER0024    REL-V7R3M0  5770-WDS
     A                                 24 64'F24=More Options'
     A                                      COLOR(BLU)
     A                                 24  4'F9=Print Requisition'
     A                                      COLOR(BLU)
     A                                 24 28'F12=Cancel'
     A                                      COLOR(BLU)
