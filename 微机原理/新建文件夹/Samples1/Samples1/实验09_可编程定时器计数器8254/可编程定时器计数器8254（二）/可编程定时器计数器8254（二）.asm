      IOPORT  EQU       0D400H-0280H
     IO8253A  EQU       IOPORT+280H
     IO8253B  EQU       IOPORT+281H
     IO8253C  EQU       IOPORT+283H
        CODE  SEGMENT
              ASSUME    CS:CODE
      START:  MOV       DX,IO8253C  ;向8254写控制字
              MOV       AL,36H      ;使0通道为工作方式3
              OUT       DX,AL
              MOV       AX,1000     ;写入循环计数初值1000
              MOV       DX,IO8253A
              OUT       DX,AL       ;先写入低字节
              MOV       AL,AH
              OUT       DX,AL       ;后写入高字节
              MOV       DX,IO8253C
              MOV       AL,76H      ;设8254通道1工作方式2
              OUT       DX,AL
              MOV       AX,1000     ;写入循环计数初值1000
              MOV       DX,IO8253B
              OUT       DX,AL       ;先写低字节
              MOV       AL,AH
              OUT       DX,AL       ;后写高字节
              MOV       AH,4CH      ;程序退出
              INT       21H
        CODE  ENDS
              END       START
