        DATA  SEGMENT
        BCD1  DW        1234H
        HEX1  DW        ?
        BCD2  DW        ?
        HEX2  DW        ?
        DATA  ENDS
        
      STACK1  SEGMENT
              DB        200 DUP(0)
      STACK1  ENDS
      
       

        CODE  SEGMENT
              ASSUME    CS:CODE,DS:DATA,SS:STACK1
      START:
              MOV       AX,DATA
              MOV       DS,AX
              MOV       BX,DS
              MOV       AX,STACK1
              MOV       SS,AX



              MOV       AX,BCD1
              MOV       BCD2,1234
              CALL      BCDTOH
              MOV       BX,AX

              

              MOV       AH,4CH      ; �����˳�
              INT       21H



      BCDTOH  PROC                  ; �� AX �Ĵ����е�4λ BCD ��ת����2��16������������������� AX ��
              
              MOV       BX,BCD2     ; ��˷���������õ� AX �Ĵ��������ܻ��ƻ�ԭʼ���ݣ�������ת�浽 BX ��

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
              RET
      BCDTOH  ENDP
              
        CODE  ENDS
              END       START

