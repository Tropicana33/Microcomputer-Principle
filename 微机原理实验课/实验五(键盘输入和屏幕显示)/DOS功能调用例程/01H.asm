        DATA  SEGMENT
       DATA1  DB        "INPUT DECIMAL:$"
        DATA  ENDS
        CODE  SEGMENT
              ASSUME    CS:CODE,DS:DATA
      START:  MOV       AX,DATA
              MOV       DS,AX
              
              MOV       AH,9        ;显示字符串，并以$结尾
              MOV       DX,OFFSET DATA1
              INT       21H
              MOV       AH,1              ;键盘输入并回显，AL=输入
              INT       21H
                            
       EXIT:  MOV       AH,4CH
              INT       21H
        CODE  ENDS
              END       START

