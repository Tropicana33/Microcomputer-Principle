; �� AX �Ĵ����е�4λ BCD ��ת����2��16������������������� AX ��

        CODE  SEGMENT
              ASSUME    CS:CODE
      START:  MOV       AX,9999H    ; �����ֵΪʮ������9999D
              MOV       BX,AX       ; ��˷���������õ� AX �Ĵ��������ܻ��ƻ�ԭʼ���ݣ�������ת�浽 BX ��

              MOV       BP,10       ; ����10��ÿ������10��
              XOR       AX,AX       ; �������� AX ����
              MOV       CH,4        ; ѭ��4��
      RETRY:  MOV       CL,4        ; ��λ����4
              ROL       BX,CL       ; ѭ����λ4λ���� BX �е����λ�������λ
              PUSH      BX          ; BX ѹ���ջ�ݴ�
              AND       BX,0FH      ; �� BX ��12λ��ֻ������4λ
              MUL       BP          ; ����10
              ADD       AX,BX       ; ��ǰ�������ȡ�õ����λ
              POP       BX          ; �ָ� BX ��ֵ
              DEC       CH          ; ����ѭ��
              JNZ       RETRY
              MOV       AH,4CH      ; �����˳�
              INT       21H
        CODE  ENDS
              END       START

