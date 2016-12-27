        DATA  SEGMENT
        BCD1  DW        1234H
        HEX1  DW        ?
        BCD2  DW        1235H
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
           
              MOV       AX,STACK1
              MOV       SS,AX


              MOV       AX,1234     ;通过寄存器传递
              CALL      BCDTOH
              MOV       HEX1,AX

              MOV       AH,4CH      ; 结束退出
              INT       21H



      BCDTOH  PROC                  ; 将 AX 寄存器中的4位 BCD 码转换成2（16）进制数，结果保存在 AX 中
              
              MOV       BX,AX       ; 因乘法运算必须用到 AX 寄存器，可能会破坏原始数据，所以先转存到 BX 中

              MOV       BP,10       ; 乘数10，每次扩大10倍
              XOR       AX,AX       ; 保存结果的 AX 清零
              MOV       CH,4        ; 循环4次
      RETRY:  MOV       CL,4        ; 移位次数4
              ROL       BX,CL       ; 循环移位4位，将 BX 中的最高位移至最低位
              PUSH      BX          ; BX 压入堆栈暂存
              AND       BX,0FH      ; 清 BX 高12位，只保留低4位
              MUL       BP          ; 乘以10
              ADD       AX,BX       ; 当前结果加上取得的最低位
              POP       BX          ; 恢复 BX 的值
              DEC       CH          ; 继续循环
              JNZ       RETRY
              RET
      BCDTOH  ENDP
              
        CODE  ENDS
              END       START

