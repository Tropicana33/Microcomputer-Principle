       DATAS  SEGMENT
       DATA1  DB        01H,02H,05H,04H,03H     ;���޷����ֽ����������ݶ�DATA1
       DATAS  ENDS
       CODES  SEGMENT
              ASSUME    CS:CODES,DS:DATAS
      START:  MOV       AX,DATAS
              MOV       DS,AX
              MOV       SI,4        ;��ѭ������
              MOV       CX,1        ;��־λ��1������ѭ���ӳ���
              ;��ѭ��
       SORT:
              MOV       DI,0        ;ָ����0
              CMP       CX,0        ;ѭ���ж���������־λΪ0�����˳�ѭ��
              JE        EXIT
              MOV       CX,0        ;  ��ѭ�������У���ʼ����־λΪ0
              ;��ѭ��
      SORT1:
              MOV       AL,[DATA1+DI]           ;��DATA1�е���������ֵ����AL��BL
              MOV       BL,[DATA1+DI+1]         ;���бȽ�
              CMP       AL,BL
              JB        NOCHANGE    ;��AL<BL(ǰһλ<��һλ)�������ӳ���NOCHANGE
              XCHG      AL,BL       ; ��AL>BL(ǰһλ>��һλ)���������ߵ�ֵ������������
              MOV       [DATA1+DI],AL           ;        ���Ƚϵ�����AL��BL��ֵ�Ƶ����ݶ���
              MOV       [DATA1+DI+1],BL
              MOV       CX,1        ;       �������󣬱�־λ��1
              INC       DI          ;       ָ�����
              CMP       DI,SI       ;      �Ƚ�ָ����趨��ѭ����������Ϊ��һ��ѭ�����ж�����
              JNZ       SORT1
              DEC       SI
              CMP       SI,0
              JZ        EXIT        ;;��ѭ����������ת������
              JMP       SORT        ;
   NOCHANGE:  ADD       DI,1        ; �ӳ���NOCHANGE����ִ�н�����ֻ��
              CMP       DI,SI       ;   ��ָ��
              JNZ       SORT1
              ;��ѭ��
              DEC       SI
              CMP       SI,0
              JZ        EXIT        ;��ѭ����������ת������
              JMP       SORT
              ;��ѭ��

       EXIT:  MOV       AX,4C00H
              INT       21H
       CODES  ENDS
              END       START

