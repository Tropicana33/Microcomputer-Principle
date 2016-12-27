        DATA  SEGMENT
       ECHO1  DB        "INPUT DECIMAL:$"
       ECHO2  DB        "HEX RESULT IS:$"
       ECHO3  DB        "TOO BIG!$"
        DATA  ENDS
        CRLF  MACRO                 ;将一段程序定义成一个宏名表示的宏指令，模拟回车键
              MOV       AH,2
              MOV       DL,0AH
              INT       21H
              MOV       AH,2
              MOV       DL,0DH
              INT       21H
              ENDM
        CODE  SEGMENT               ;从键盘输入十进制，转换为十六进制，并显示
              ASSUME    CS:CODE
      START:  MOV       AX,DATA
              MOV       DS,AX
     REPEAT:  MOV       AH,9        ;显示字符串
              MOV       DX,OFFSET ECHO1
              INT       21H
              CALL      DECBIN      ;调用decbin，十进制转换为十六进制 ，断内直接调用
              CRLF                  ;换行
              MOV       AH,9
              MOV       DX,OFFSET ECHO2
              INT       21H
              CALL      BINHEX
              CRLF
              JMP       REPEAT      ;以上为主程序

     DECBIN:  MOV       BX,0
        NEW:  MOV       AH,1        ;键盘输入并回显，AL=输入字符
              INT       21H
              SUB       AL,30H      ;将输入字符ascii码转换成十进制
              JL        EXIT
              CMP       AL,9
              JG        EXIT        ;小于0大于9，格式不合格直接退出
              CBW                   ;字节扩展指令，al扩展为ax ,高位补0
              XCHG      AX,BX       ;输入的数字存入bx，bx用来存放累加的中间结果
              MOV       CX,0AH
              MUL       CX          ;ax*10，累加结果*10，结果放在（dx：ax）中
              JC        ERROR       ;有进位则发生错误，跳出程序
              XCHG      AX,BX       ;交换数据，将中间结果存入bx中
              ADD       BX,AX       ;中间结果与输入数字相加作为累加结果存入bx
              JC        ERROR
              JMP       NEW
       EXIT:  RET

      ERROR:  MOV       AH,9        ;程序结束
              MOV       DX,OFFSET ECHO3
              INT       21H
              MOV       AH,4CH
              INT       21H

     BINHEX:  MOV       CH,4        ;循环次数
     ROTATE:  MOV       CL,4        ;移动位数
              ROL       BX,CL       ;循环移动，取最高位
              MOV       AL,BL
              AND       AL,0FH      ;取得最高位
              ADD       AL,30H      ;转换为ascii码
              CMP       AL,3AH      ;判断是否大于9，如果小于9,只需加30H
              JL        PRINT
              ADD       AL,7        ;大于9，加37H
      PRINT:  MOV       DL,AL       ;在屏幕上显示
              MOV       AH,2
              INT       21H         ;显示输出
              DEC       CH
              JNZ       ROTATE
              RET
        CODE  ENDS
              END       START
      
