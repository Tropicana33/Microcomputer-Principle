       DATAS  SEGMENT
       DATA1  DB        9AH,0BCH,0DEH,8AH
       DATA2  DB        12H,34H,56H,90H
       DATA3  DB        5 DUP(?)    ;此处输入数据段代码
       DATAS  ENDS

      STACKS  SEGMENT
    ;此处输入堆栈段代码
      STACKS  ENDS

       CODES  SEGMENT
              ASSUME    CS:CODES,DS:DATAS,SS:STACKS
      START:
              MOV       AX,DATAS
              MOV       DS,AX
              LEA       SI,DATA1    ;取两个数据的首地址
              LEA       DI,DATA2
              LEA       BP,DATA3

              MOV       DL,0
              MOV       BL,DATA2-DATA1          ;加数位数
              MOV       CL,BL

      LOOP1:  MOV       AL,[SI]
              ADC       AL,[DI]
              MOV       [BP],AL
              INC       SI
              INC       DI
              INC       BP
              DEC       CX
              JNZ       LOOP1       ;转移指令，结果不为0，则转到loop1

              MOV       AL,0
              ADC       AL,0
              MOV       [BP],AL

              MOV       AH,4CH
              INT       21H
       CODES  ENDS
              END       START
