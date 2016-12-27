        DATA  SEGMENT
         BUF  DW        80 DUP(?)   ;假定要安排的数已存入这80个字单元中 
        DATA  ENDS
        CODE  SEGMENT
              ASSUME    CS:CODE,DS:DATA
      START:  MOV       AX,DATA
              MOV       DS，AX
              LEA       DI，BUF     ;DI指向要排序的数的首址
              MOV       BL,79       ;外循环只需79次即可
            ;外循环从此开始
      LOOP1:  MOV       SI,DI       ;SI指向当前要比较的数
              MOV       CL,BL       ;CL为内循环计数器，循环次数每次少1
            ;以下为内循环
      LOOP2:  MOV       AX，[SI]    ;取第一个数Ni
              ADD       SI,2        ;指向下一个数NJ
              CMP       AX,[SI]     ;NI≥NJ？
              JNC       NEXT        ;若大于，则不交换
              MOV       DX,[SI]     ;否则，交换NI和NJ
              MOV       [SI-2],DX
              MOV       [SI],AX
       NEXT:  DEC       CL          ;内循环结束？
              JNZ       LOOP2       ;若未结束，则继续
            ;内循环到此结束
              DEC       BL          ;外循环结束？
              JNZ       LOOP1       ;若未结束，则继续
            ;外循环体结束
              MOV       AH,4CH      ;返回DOS
              INT       21H
        CODE  ENDS
              END       START
