; 比较两个字符串STRING1和STRING2所含字符是否完全相同，若相同则显示'MATCH'，否则显示'NO MATCH'

        DATA  SEGMENT

       MATCH  DB        'Match'
         EOS  DB        0
      NMATCH  DB        'No match'

        STR1  DB        'abcd'
        STR2  DB        'abcd'
        STR3  DB        ?

        DATA  ENDS

        CODE  SEGMENT
        MAIN  PROC      FAR
              ASSUME    CS:CODE,DS:DATA,ES:DATA
      START:
              PUSH      DS
              SUB       AX,AX
              PUSH      AX

              MOV       AX,DATA
              MOV       DS,AX
              MOV       ES,AX

              MOV       CX,STR2-STR1            ; STRING1的长度保存到CX
              CMP       CX,STR3-STR2            ; 比较STRING1和STRING2的长度是否相同
              JNE       PRT_NM      ;不同则显示'NO MATCH'

              LEA       SI,STR1
              LEA       DI,STR2
       COMP:  MOV       BL,[SI]
              CMP       BL,[DI]
            ; cmp     bl,ds:[di]
              JNE       PRT_NM
              INC       SI
              INC       DI
              LOOP      COMP



              LEA       SI,MATCH    ; 以单个字符方式显示字符串'MATCH' ,用结束标志0控制循环次数
              MOV       AH,2
      CONTM:  MOV       DL,[SI]
              INT       21H
              INC       SI
              CMP       BYTE PTR [SI],0
              JNE       CONTM
              JMP       EXIT

     PRT_NM:  MOV       CX,8        ;以单个字符方式显示字符串'NO MATCH'，用字符串字符个数控制循环次数
              LEA       SI,NMATCH
              MOV       AH,02
     CONTNM:  MOV       DL,[SI]
              INT       21H
              INC       SI
              LOOP      CONTNM

       EXIT:  RET
        MAIN  ENDP

        CODE  ENDS
              END       START
