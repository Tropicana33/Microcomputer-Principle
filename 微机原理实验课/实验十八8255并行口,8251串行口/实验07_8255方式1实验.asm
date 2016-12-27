;08.10.2 test OK
.MODEL        SMALL
.386
         IO_8255_ADDRESS  EQU       200H        ;8255基址值
        DATA  SEGMENT
         TAB  DB        01H,02H,04H,08H,10H,20H,40H,80H
        DATA  ENDS
        CODE  SEGMENT
              ASSUME    CS:CODE,DS:DATA
      START:
              MOV       AX,DATA
              MOV       DS,AX
              MOV       DX,IO_8255_ADDRESS+3    ;控制口
              MOV       AL,0B0H     ;A口方式1，输入，C口输入
              OUT       DX, AL
              MOV       AL,08H      ;设置INTEA＝0  ,pc4置0
              OUT       DX, AL
              MOV       DX,IO_8255_ADDRESS+1    ;A口
              MOV       AL,00H      ;设置初值=00H 熄灭LED
              OUT       DX, AL
               
                
        SS0:  MOV       DX,IO_8255_ADDRESS+2    ;8255 C口
        SS1:  IN        AL, DX      ;输入C口数据到AL
              TEST      AL,00100000B            ;pc5=1?  忙则继续等待
              JZ        SS1         ;=0  wait
              MOV       DX,IO_8255_ADDRESS      ;A口
              IN        AL,DX       ;A口输入AL
              AND       AL,07H      ;取低3位
              MOV       BX,OFFSET TAB
              XLAT      TAB         ;换码指令，al--al+bl        ,tab为首地址
              MOV       DX,IO_8255_ADDRESS+1
              OUT       DX,AL       ;AL输出到B口
              JMP       SS0
                 
       
        CODE  ENDS
              END       START

