;*******************************;
;*        8255方式1实验1       *;
;*******************************;

        CODE  SEGMENT
              ASSUME    CS:CODE
      START:
              MOV       AX,CS
              MOV       DS,AX
              MOV       DX,OFFSET INT_PROC      ;中断函数的偏移地址
              MOV       AX,250BH
              INT       21H         ;设置IRQ3的中断矢量
              MOV       DX,21H
              IN        AL,DX       ;读中断屏蔽寄存器
              AND       AL,0F7H     ;开放IRQ3中断
              OUT       DX,AL       ;设置中断屏蔽寄存器
              MOV       DX,28BH     ;8255控制口
              MOV       AL,0A0H     ;设置A口味方式1输出
              OUT       DX,AL
              MOV       AL,0DH      ;将PC6置1，也就是是ACK失效
              OUT       DX,AL
              MOV       BL,1        ;初始值01h
         LL:  JMP       LL          ;循环等待中断
   INT_PROC:
              MOV       AL,BL
              MOV       DX,288H
              OUT       DX,AL       ;将AL的值送到A口控制灯
              MOV       AL,20H
              OUT       20H,AL      ;发出EOI结束中断，使响应的中断服务寄存器请0
              SHL       BL,1        ;左移1位
              JNC       NEXT        ;少于8次则继续等待
              IN        AL,21H
              OR        AL,08H      ;关闭IRQ3中断
              OUT       21H,AL
              STI                   ;设置中断标志位
              MOV       AH,4CH
              INT       21H
       NEXT:  IRET
        CODE  ENDS
              END       START
