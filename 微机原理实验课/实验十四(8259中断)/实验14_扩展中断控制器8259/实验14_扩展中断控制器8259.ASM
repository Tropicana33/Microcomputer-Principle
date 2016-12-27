;8259-1.asm
;8259中断查询方式应用实验

;*****************************************************************
;         2008年03月为8259应用修改
;*****************************************************************
ioport	 equ   0ec00h-0280h
I8259_1  EQU   ioport+2B0H       ;8259的ICW1端口地址（A0=0，偶地址）
I8259_2  EQU   ioport+2B1H       ;8259的ICW2端口地址（A0=1，奇地址）
I8259_3  EQU   ioport+2B1H       ;8259的ICW3端口地址
I8259_4  EQU   ioport+2B1H       ;8259的ICW4端口地址
O8259_1  EQU   ioport+2B1H       ;8259的OCW1端口地址
O8259_2  EQU   ioport+2B0H       ;8259的OCW2端口地址
O8259_3  EQU   ioport+2B0H       ;8259的OCW3端口地址

data segment
 
 mes1 db 'you can play a key on the keyboard!',0dh,0ah,24h
 mes2 dd  mes1
 mess1 db 'Hello! This is interrupt    *  0  *!',0dh,0ah,'$'
 mess2 db 'Hello! This is interrupt    *  1  *!',0dh,0ah,'$'
 mess3 db 'Hello! This is interrupt    *  2  *!',0dh,0ah,'$'
 mess4 db 'Hello! This is interrupt    *  3  *!',0dh,0ah,'$'
 mess5 db 'Hello! This is interrupt    *  4  *!',0dh,0ah,'$'
 mess6 db 'Hello! This is interrupt    *  5  *!',0dh,0ah,'$'
 mess7 db 'Hello! This is interrupt    *  6  *!',0dh,0ah,'$'
 mess8 db 'Hello! This is interrupt    *  7  *!',0dh,0ah,'$'
data ends

stacks segment
 db 100 dup(?)
stacks ends
STACK1 SEGMENT STACK
        DW 256 DUP(?)
STACK1 ENDS

CODE SEGMENT
        ASSUME CS:CODE,DS:DATA,SS:stacks,ES:DATA
.386
START: mov ax,data
       mov ds,ax
       mov es,ax
       mov ax,stacks
       mov ss,ax
  

       MOV  DX,I8259_1         ;初始化8259的ICW1
       MOV  AL,13H             ;边沿触发、单片8259、需要ICW4
       OUT  DX,AL

       MOV  DX,I8259_2         ;初始化8259的ICW2
       MOV  AL,0B0H             ;00001011BIN,定义中断类型号，查询结果（IR1～IR7）将显示在低三位
       OUT  DX,AL
       ;MOV  AL,00H（8080/8085手动EOI的时候用）
       ;OUT  DX,AL
       MOV  AL,03H		;初始化ICW4，8086系统，自动EOI
       OUT  DX,AL

       MOV  DX,O8259_1         ;初始化8259的OCW1
       MOV  AL,00H            ;打开IR0和IR1的屏蔽位
       OUT  DX,AL
      
QUERY: MOV  AH,1               ;判断是否有按键按下
       INT  16H
       JNZ  QUIT               ;有按键则退出

       MOV  DX,O8259_3         ;向8259的OCW3发送查询命令
       MOV  AL,0CH
       OUT  DX,AL


       IN   AL,DX              ;读出查询字
       MOV  AH,AL
       AND  AL,80H
       TEST AL,80H             ;把低位清零查看最高位，判断中断是否已响应
       JZ   QUERY              ;没有响应则继续查询
       MOV  AL,AH       
       AND  AL,07H
       CMP  AL,00H
       JE   IR0ISR              ;若为IR0请求，跳到IR0处理程序
       CMP  AL,01H
       JE  IR1ISR              ;若为IR1请求，跳到IR1处理程序
       CMP  AL,02H
       JE   IR2ISR
       CMP  AL,03H
       JE   IR3ISR
       CMP  AL,04H
       JE   IR4ISR
       CMP  AL,05H
       JE   IR5ISR
       CMP  AL,06H
       JE   IR6ISR
       CMP  AL,07H
       JE   IR7ISR
       JMP  QUERY

IR0ISR: MOV AX,DATA
        MOV DS,AX
        MOV DX,offset mess1     ;显示提示信息
        MOV AH,09
        INT 21H
        JMP  EOI

IR1ISR: MOV AX,DATA
        MOV DS,AX
        MOV DX,offset mess2     ;显示提示信息
        MOV AH,09
        INT 21H
        JMP  EOI

IR2ISR: MOV AX,DATA
        MOV DS,AX
        MOV DX,offset mess3     ;显示提示信息
        MOV AH,09
        INT 21H
        JMP  EOI
IR3ISR: MOV AX,DATA
        MOV DS,AX
        MOV DX,offset mess4     ;显示提示信息
        MOV AH,09
        INT 21H
        JMP  EOI
IR4ISR: MOV AX,DATA
        MOV DS,AX
        MOV DX,offset mess5     ;显示提示信息
        MOV AH,09
        INT 21H
        JMP  EOI
IR5ISR: MOV AX,DATA
        MOV DS,AX
        MOV DX,offset mess6    ;显示提示信息
        MOV AH,09
        INT 21H
        JMP  EOI
IR6ISR: MOV AX,DATA
        MOV DS,AX
        MOV DX,offset mess7     ;显示提示信息
        MOV AH,09
        INT 21H
        JMP  EOI
IR7ISR: MOV AX,DATA
        MOV DS,AX
        MOV DX,offset mess8     ;显示提示信息
        MOV AH,09
        INT 21H

EOI:  
       MOV  DX,O8259_2          ;向8259发送中断结束命令
       MOV  AL,20H
       OUT  DX,AL
       JMP  QUERY
       
QUIT:  MOV  AX,4C00H            ;结束程序退出
       INT  21H


CODE ENDS
     END START
