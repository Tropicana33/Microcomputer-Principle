        DATA  SEGMENT
       ARRAY  DB        2,3,4,6,8,5,1,7,0,9     ;要排序的数
         LEN  EQU       $-ARRAY     ;元素个数
        DATA  ENDS
        
      STACK1  SEGMENT
              DB        200 DUP(0)
      STACK1  ENDS
      
        CODE  SEGMENT
              ASSUME    CS:CODE,DS:DATA,SS:STACK1
      START:  MOV       AX,DATA
              MOV       DS,AX
              LEA       SI,ARRAY    ;显示未排序数组
              MOV       CL,LEN
              CALL      OSTR
          ;    MOV       AH,02H
           ;   MOV       DL,0DH
           ;   INT       21H
              MOV       DL,0AH
              INT       21H
              CALL      SORTP       ;调用排序子程序
              MOV       CL,LEN
              LEA       SI,ARRAY    ;显示排序后数组
              CALL      OSTR
              MOV       AH,4CH      ;返回DOS
              INT       21H
        OSTR  PROC                  ;显示字符子程序
       LOP1:  MOV       AL,[SI]
              ADD       AX,30H      ;转成ASCII码
              MOV       DL,AL
              MOV       AH,02H      ;显示字符
              INT       21H
            
              INC       SI
              MOV       DL,','
              MOV       AH,02H
              INT       21H
              LOOP      LOP1
              RET
        OSTR  ENDP
       SORTP  PROC                  ;排序子程序
              LEA       DI,ARRAY
              MOV       BX,-1       ;标志-1赋给BC
       LOP2:  CMP       BX,-1       ;BX=-1，则没比较完
             
              JNE       SEND        ;BX不等于-1，则比较结束
              XOR       BX,BX
              MOV       SI,DI
              MOV       CL,LEN      ;比较次数
              DEC       CL
       LOP3:  MOV       AL,[SI]
              CMP       AL,[SI+1]
              JLE       CHE         ;[SI]小于等于[SI+1]，不交换
              XCHG      [SI+1],AL   ;否则交换
              MOV       [SI],AL
              MOV       BX,-1
        CHE:  ADD       SI,1
              LOOP      LOP3
              JMP       LOP2        ;结束，继续下一轮排序
       SEND:  RET
       SORTP  ENDP
       
        CODE  ENDS
              END       START
