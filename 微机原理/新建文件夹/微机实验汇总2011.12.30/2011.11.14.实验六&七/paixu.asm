        DATA  SEGMENT
         BUF  DW        80 DUP(?)   ;�ٶ�Ҫ���ŵ����Ѵ�����80���ֵ�Ԫ�� 
        DATA  ENDS
        CODE  SEGMENT
              ASSUME    CS:CODE,DS:DATA
      START:  MOV       AX,DATA
              MOV       DS��AX
              LEA       DI��BUF     ;DIָ��Ҫ�����������ַ
              MOV       BL,79       ;��ѭ��ֻ��79�μ���
            ;��ѭ���Ӵ˿�ʼ
      LOOP1:  MOV       SI,DI       ;SIָ��ǰҪ�Ƚϵ���
              MOV       CL,BL       ;CLΪ��ѭ����������ѭ������ÿ����1
            ;����Ϊ��ѭ��
      LOOP2:  MOV       AX��[SI]    ;ȡ��һ����Ni
              ADD       SI,2        ;ָ����һ����NJ
              CMP       AX,[SI]     ;NI��NJ��
              JNC       NEXT        ;�����ڣ��򲻽���
              MOV       DX,[SI]     ;���򣬽���NI��NJ
              MOV       [SI-2],DX
              MOV       [SI],AX
       NEXT:  DEC       CL          ;��ѭ��������
              JNZ       LOOP2       ;��δ�����������
            ;��ѭ�����˽���
              DEC       BL          ;��ѭ��������
              JNZ       LOOP1       ;��δ�����������
            ;��ѭ�������
              MOV       AH,4CH      ;����DOS
              INT       21H
        CODE  ENDS
              END       START
