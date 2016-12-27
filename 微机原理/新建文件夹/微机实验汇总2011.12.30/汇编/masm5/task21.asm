

        CODE  SEGMENT
              ASSUME    CS:CODE,
      START:  mov [bx],20h
mov ax,ip
mov cs,ax
mov [bx],[si]
mov ax,[bx+bp]
mov ax,[si+di]
mov ax,[bx-si]
mov ax,[dx]
in ax,2100h
lds ax,bx
push ip
pop cs
add ax,ds
inc [bx]
mul 20h
shl ax,4
              
              MOV       AH,4CH
              INT       21H
        CODE  ENDs
              END       START
