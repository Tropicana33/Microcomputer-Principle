        DATA  SEGMENT
       DATA1  DB        "INPUT DECIMAL:$"
        DATA  ENDS
        CODE  SEGMENT
              ASSUME    CS:CODE,DS:DATA
      START:  MOV       AX,DATA
              MOV       DS,AX
              
              MOV       AH,9        ;��ʾ�ַ���������$��β
              MOV       DX,OFFSET DATA1
              INT       21H
              MOV       AH,1              ;�������벢���ԣ�AL=����
              INT       21H
                            
       EXIT:  MOV       AH,4CH
              INT       21H
        CODE  ENDS
              END       START

