        DATA  SEGMENT
      IOPORT  EQU       0EC00H-0280H
     IO8253A  EQU       IOPORT+280H
     IO8253B  EQU       IOPORT+283H
     IO8251A  EQU       IOPORT+2B8H
     IO8251B  EQU       IOPORT+2B9H
        MES1  DB        'you can play a key on the keybord!',0DH,0AH,24H
        MES2  DD        MES1
        DATA  ENDS
        CODE  SEGMENT
              ASSUME    CS:CODE,DS:DATA
      START:  MOV       AX,DATA
              MOV       DS,AX
              MOV       DX,IO8253B  ;设置8253计数器0工作方式
              MOV       AL,16H
              OUT       DX,AL
              MOV       DX,IO8253A
              MOV       AL,52       ;给8253计数器0送初值
              OUT       DX,AL
              MOV       DX,IO8251B  ;初始化8251
              XOR       AL,AL
              MOV       CX,03       ;向8251控制端口送3个0
      DELAY:  CALL      OUT1
              LOOP      DELAY
              MOV       AL,40H      ;向8251控制端口送40H,使其复位D6=1
              CALL      OUT1
              MOV       AL,4EH      ;设置为1个停止位,8个数据位,波特率因子为16
              CALL      OUT1
              MOV       AL,27H      ;向8251送控制字允许其发送和接收
              CALL      OUT1
              LDS       DX,MES2     ;显示提示信息 'you can play a key on the keybord!'
              MOV       AH,09
              INT       21H
      WAITI:  MOV       DX,IO8251B
              IN        AL,DX
              TEST      AL,01       ;发送是否准备好
              JZ        WAITI
              MOV       AH,01       ;是,从键盘上读一字符
              INT       21H
              CMP       AL,27       ;若为ESC,结束
              JZ        EXIT
              MOV       DX,IO8251A
              INC       AL
              OUT       DX,AL       ;发送
              MOV       CX,0F00H
        S51:  LOOP      S51         ;延时
       NEXT:  MOV       DX,IO8251B
              IN        AL,DX
              TEST      AL,02       ;检查接收是否准备好
              JZ        NEXT        ;没有,等待
              MOV       DX,IO8251A
              IN        AL,DX       ;准备好,接收
              MOV       DL,AL
              MOV       AH,02       ;将接收到的字符显示在屏幕上
              INT       21H
              JMP       WAITI
       EXIT:  MOV       AH,4CH      ;退出
              INT       21H

        OUT1  PROC      NEAR        ;向外发送一字节的子程序
              OUT       DX,AL
              PUSH      CX
              MOV       CX,0F00H
         GG:  LOOP      GG          ;延时
              POP       CX
              RET
        OUT1  ENDP
        CODE  ENDS
              END       START
