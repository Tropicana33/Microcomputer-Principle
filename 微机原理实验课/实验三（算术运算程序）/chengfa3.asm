       DATAS  SEGMENT
       DATA1  DB        0DEH,0BCH,9AH
       DATA2  DB        34H,12H

          T1  DB        0,0,0,0
          T2  DB        0,0,0,0
           R  DB        5 DUP(?)    ;�˴��������ݶδ���
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

              MOV       AL,[SI+2]   ;��һ��ѭ��
              MOV       BL,[DI+1]
              MUL       BL
              MOV       CL,AH       ;��λ
              MOV       [T1+3],AL

              MOV       AL,[SI+1]
              MUL       BL
              ADD       AL,CL
              MOV       [T1+2],AL
              ADC       AH,0
              MOV       CL,AH


              MOV       AL, [SI]
              MUL       BL
              ADD       AL,CL
              MOV       [T1+1],AL
              ADC       AH,0
              MOV       [T1],AH


              MOV       AL,[SI+2]   ;�ڶ���ѭ��
              MOV       BL,[DI]
              MUL       BL
              MOV       CL,AH       ;��λ����cl
              MOV       [T2+3],AL

              MOV       AL,[SI+1]
              MUL       BL
              ADD       AL,CL
              MOV       [T2+2],AL
              ADC       AH,0
              MOV       CL,AH


              MOV       AL, [SI]
              MUL       BL
              ADD       AL,CL
              MOV       [T2+1],AL
              ADC       AH,0
              MOV       [T2],AH

              ;T1,T2�����λ���  ����R
              LEA       DI,T1
              LEA       SI,T2

              MOV       AL,[T1+3]
              MOV       [R+4],AL

              MOV       AL,[T1+2]
              ADD       AL,[T2+3]
              MOV       [R+3],AL

              MOV       AL,[T1+1]
              ADC       AL,[T2+2]
              MOV       [R+2],AL

              MOV       AL,[T1]
              ADC       AL,[T2+1]
              MOV       [R+1],AL
              MOV       AL,[T2]
              ADC       AL,0
              MOV       [R],AL



              MOV       AH,4CH
              INT       21H
       CODES  ENDS
              END       START
