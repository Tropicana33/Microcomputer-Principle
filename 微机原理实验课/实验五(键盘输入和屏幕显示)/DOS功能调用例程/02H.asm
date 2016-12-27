        DATA  SEGMENT
       DATA1  DB        "INPUT DECIMAL:$"
        DATA  ENDS
        CODE  SEGMENT
              ASSUME    CS:CODE,DS:DATA
      START:  MOV       AX,DATA
              MOV       DS,AX
              
              MOV       AH,2        ;ÏÔÊ¾Êä³ö£¬DL=ÏÔÊ¾×Ö·û
              MOV       DL,35H
              INT       21H

                            
       EXIT:  MOV       AH,4CH
              INT       21H
        CODE  ENDS
              END       START

                                 
