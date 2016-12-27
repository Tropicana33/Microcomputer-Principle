        DATA  SEGMENT
       DATA1  DB        ' ','2','6','8','5','9','$'         ;' '空格用来存放最高位进位，'$'是DOS功能调用INT 21H中9号功能要求的要显示字符串的结束标志。
       DATA2  DB        '+','1','4','7','6','4','=',0DH,0AH,'$'         ;0DH,0AH,'$'中0DH和0AH分别是回车和换行的ASCII码
        DATA  ENDS
      STACK1  SEGMENT   PARA STACK 'STACK1'
              DB        100 DUP (?)
      STACK1  ENDS
        CODE  SEGMENT
              ASSUME    CS:CODE,DS:DATA,SS:STACK1
      START:
              MOV       AX,DATA
              MOV       DS,AX
              MOV       AX,STACK1
              MOV       SS,AX

              LEA       DX,DATA1    ;等价于MOV   DX，OFFSET DATA1
              MOV       AH,09H
              INT       21H
              LEA       DX,DATA2
              MOV       AH,09H
              INT       21H
      
              MOV       DI,5
              MOV       SI,5
              MOV       CX,5
              MOV       AH,0
      NEXT1:
              MOV       AL,DATA2[SI]
              ADD       AL,DATA1[DI]
              AAA
              OR        AL,30H      ;调整为ASCII码
              MOV       DATA1[DI],AL
              DEC       DI
              DEC       SI
              DEC       CX
              JCXZ      EXIT        ;CX=0则转移
              JMP       NEXT2

          
      NEXT2:
              MOV       AL,DATA1[DI]
              ADD       AL,AH
              MOV       DATA1[DI],AL
              MOV       AH,0
              JMP       NEXT1

       EXIT:
              LEA       DX,DATA1
              MOV       AH,09H
              INT       21H
              MOV       AH,4CH      ;返回dos
              INT       21H
        CODE  ENDS
              END       START

