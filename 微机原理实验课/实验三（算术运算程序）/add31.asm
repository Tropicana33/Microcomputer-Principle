       DATAS  SEGMENT
       DATA1  DB        9AH,0BCH,0DEH,8AH
       DATA2  DB        12H,34H,56H,90H
       DATA3  DB        5 DUP(?)    ;�˴��������ݶδ���
       DATAS  ENDS

      STACKS  SEGMENT
    ;�˴������ջ�δ���
      STACKS  ENDS

       CODES  SEGMENT
              ASSUME    CS:CODES,DS:DATAS,SS:STACKS
      START:
              MOV       AX,DATAS
              MOV       DS,AX
              LEA       SI,DATA1    ;ȡ�������ݵ��׵�ַ
              LEA       DI,DATA2
              LEA       BP,DATA3

              MOV       DL,0
              MOV       BL,DATA2-DATA1          ;����λ��
              MOV       CL,BL

      LOOP1:  MOV       AL,[SI]
              ADC       AL,[DI]
              MOV       [BP],AL
              INC       SI
              INC       DI
              INC       BP
              DEC       CX
              JNZ       LOOP1       ;ת��ָ������Ϊ0����ת��loop1

              MOV       AL,0
              ADC       AL,0
              MOV       [BP],AL

              MOV       AH,4CH
              INT       21H
       CODES  ENDS
              END       START
