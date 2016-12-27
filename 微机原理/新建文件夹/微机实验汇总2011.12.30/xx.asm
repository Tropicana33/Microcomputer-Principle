        DATA  SEGMENT
           X  DB        '1','2','3','4','$'     ;存放被乘数
           Y  DB        '*','2','3','4','5','=',0DH,0AH,'$' ;存放乘数
           Z  DB        8 DUP(0)
              DB        0DH,0AH,'$' ;存放结果
        DATA  ENDS

      STACK1  SEGMENT   PARA STACK 'STACK1'
              DB        100 DUP (?)
      STACK1  ENDS

        CODE  SEGMENT
              ASSUME    CS:CODE,DS:DATA,SS:STACK1,ES:DATA   ;字符串比较需用
        MAIN  PROC      FAR
      START:
              MOV       AX,DATA
              MOV       DS,AX
              MOV       ES,AX
              MOV       AX,STACK1
              MOV       SS,AX
              LEA       DX,X
              MOV       AH,9
              INT       21H
              LEA       DX,Y
              MOV       AH,9
              INT       21H
    
              MOV       DI,4        ;乘数指针
    NEXTOUT:                        ;外循环

              MOV       CX,4
              MOV       SI,3        ;被乘数指针
     NEXTIN:                        ;内循环
    
              MOV       AL,X[SI]
              MOV       BL,Y[DI]
              AND       AL,0FH
              AND       BL,0FH
              MUL       BL
              AAM
              CALL      ADDS
              DEC       SI
              LOOP      NEXTIN
    
              DEC       DI
              JNZ       NEXTOUT
    
              MOV       CX,8
              MOV       SI,7
    
      TURNS:                        ;把结果转换成ASCII码
    
              MOV       AL,Z[SI]
              OR        AL,30H
              MOV       Z[SI],AL
              DEC       SI
              LOOP      TURNS
    
              MOV       CX,8
              MOV       SI,0
    
      FINDZ:                        ;把指针定位到结果的第一个非零处
    
              MOV       AL,Z[SI]
              CMP       AL,'0'
              JNE       EXIT1
              INC       SI
              LOOP      FINDZ

      EXIT1:
              LEA       DX,Z[SI]
              MOV       AH,9
              INT       21H
              MOV       AH,4CH
              INT       21H
              RET
        MAIN  ENDP

        ADDS  PROC      NEAR
              PUSH      SI
              PUSH      DI
              PUSH      CX
              MOV       CX,2        ;计2个数相乘后的两位数
            ;低一位加入结果Z
              MOV       DX,SI
              MOV       BX,DI
              ADD       BX,DX
              MOV       SI,BX       ;进位指针
              MOV       DI,SI       ;结果Z指针
              MOV       BX,AX       ;BX放入2个数乘后结果
              CLC
              ADD       AL,Z[SI]
              AAA
              MOV       Z[SI],AL
              JC        CARRY

       NEXT:                        ;高一位加入结果Z
              DEC       SI
              MOV       DI,SI
              MOV       AL,BH
              CLC
              ADD       AL,Z[SI]
              AAA
              MOV       Z[SI],AL
              JC        CARRY
              JNC       EXIT2
    
      CARRY:
              DEC       DI
              MOV       AL,Z[DI]
              CLC
              ADD       AL,1
              AAA
              MOV       Z[DI],AL
              JC        CARRY
              DEC       CX
              JCXZ      EXIT2
              JMP       NEXT
    
      EXIT2:
              POP       CX
              POP       DI
              POP       SI
              RET       3
        ADDS  ENDP
        CODE  ENDS
              END       START

