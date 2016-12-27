       DATAS  SEGMENT
       DATA1  DB        01H,02H,05H,04H,03H     ;将无符号字节数存在数据段DATA1
       DATAS  ENDS
       CODES  SEGMENT
              ASSUME    CS:CODES,DS:DATAS
      START:  MOV       AX,DATAS
              MOV       DS,AX
              MOV       SI,4        ;外循环次数
              MOV       CX,1        ;标志位置1，进入循环子程序
              ;外循环
       SORT:
              MOV       DI,0        ;指针置0
              CMP       CX,0        ;循环判断条件：标志位为0，则退出循环
              JE        EXIT
              MOV       CX,0        ;  在循环程序中，初始化标志位为0
              ;内循环
      SORT1:
              MOV       AL,[DATA1+DI]           ;将DATA1中的相邻两个值移入AL、BL
              MOV       BL,[DATA1+DI+1]         ;进行比较
              CMP       AL,BL
              JB        NOCHANGE    ;若AL<BL(前一位<后一位)，进入子程序NOCHANGE
              XCHG      AL,BL       ; 若AL>BL(前一位>后一位)，交换两者的值，大数往后移
              MOV       [DATA1+DI],AL           ;        将比较调整后AL、BL的值移到数据段中
              MOV       [DATA1+DI+1],BL
              MOV       CX,1        ;       调整过后，标志位置1
              INC       DI          ;       指针递增
              CMP       DI,SI       ;      比较指针和设定的循环次数，作为第一层循环的判断条件
              JNZ       SORT1
              DEC       SI
              CMP       SI,0
              JZ        EXIT        ;;内循环结束，跳转到结束
              JMP       SORT        ;
   NOCHANGE:  ADD       DI,1        ; 子程序NOCHANGE，不执行交换，只改
              CMP       DI,SI       ;   变指针
              JNZ       SORT1
              ;内循环
              DEC       SI
              CMP       SI,0
              JZ        EXIT        ;内循环结束，跳转到结束
              JMP       SORT
              ;外循环

       EXIT:  MOV       AX,4C00H
              INT       21H
       CODES  ENDS
              END       START

