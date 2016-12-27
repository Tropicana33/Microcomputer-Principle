;386以上微机适用
;tasm4.1或以上编译
;*********************;
;* 键盘显示 8255LED  *;
;*********************;
 ioport       equ 0cc00h-280h
 a8255    	equ ioport+288H         ;8255端口,a口  段码
 b8255    	equ ioport+289H         ;8255端口,b口 位码
 c8255    	equ ioport+28aH         ;8255端口,c口 键盘
 k8255    	equ ioport+28bH         ;8255端口,控制口
data segment
 table1    dw 0770h,0B70h,0D70h,0E70h,07B0h,0BB0h,0DB0h,0EB0h
           dw 07D0h,0BD0h,0DD0h,0ED0h,07E0h,0BE0h,0DE0h,0EE0h    ;键盘扫描码表
 LED       DB 3FH,06H,5BH,4FH,66H,6DH,7DH,07H,7FH,6FH,77H,7CH
           DB 39h,5EH,79h,71h,0ffh           ;LED段码表，0,1,2,3,4,5,6,7,8,9,a,b,c,d,e,f
 char      db '0123456789ABCDEF'     ;字符表
 key_in    db 'G'
 CHAR1     DB 0FFH
 mes       db 0ah,0dh
           db 'PLAY ANY KEY IN THE SMALL KEYBOARD! ',0ah,0dh
           db 'IT WILL BE ON THE SCREEN AND LED ! END WITH F or ANY KEY',0ah,0dh,'$'
data ends
stacks segment stack              ;堆栈空间
 	db 100 dup (?)

stacks ends
code segment
assume cs:code,ds:data,ss:stacks,es:data
start:
        cli
        mov ax,data
        mov ds,ax
        mov es,ax
        mov ax,stacks
        mov ss,ax
        mov dx,offset mes         	;显示提示信息
        mov ah,09
        int 21h
ky:     call key                  	;调键盘扫描子程序，得到一个字符
        call disply               	;调显示子程序，显示得到的字符
        mov ah,1
        int 16h
        jnz exit                  	;按任意键退出
        mov dl,byte ptr key_in
        cmp dl,'F'
        jnz ky
exit:   mov ax,4c00h              	;如果是“F”键则退出
        int 21h                   	;退出
KEY    PROC NEAR
key_loop: 	MOV DX,k8255
    	mov al,81h
    	out dx,al
    	mov dx,c8255
    	mov al,0fh
    	out dx,al
    	in al,dx                      	;读行扫描值
    	and al,0fh
    	cmp al,0fh
    	jz key1                       	;未发现有键按下则转
    	call delay                    	;延时
    	mov ah,al
    	MOV DX,k8255
    	mov al,88h
    	out dx,al
    	mov dx,c8255
    	mov al,ah
    	or al,0f0h
    	out dx,al
    	in al,dx                      	;读列扫描值
    	and al,0f0h
    	cmp al,0f0h
    	jz key1                       	;未发现有键按下则转
    
    	mov si,offset table1          	;键盘扫描码表首址
    	mov di,offset char            	;字符表首址
	mov cx,16                     	;待查表的表大小
key_tonext:
    	cmp ax,[si]                   
    	jz key_findkey      
    	dec cx
    	jz key1                       	;未找到对应扫描码
    	add si,2
    	inc di
	jmp key_tonext
key_findkey:
    	mov dl,[di]
    	mov ah,02
    	int 21h                       	;显示查找到的键盘码 
	mov byte ptr key_in,dl
key_waitup:
    	MOV DX,k8255
    	mov al,81h
    	out dx,al
    	mov dx,c8255
    	mov al,0fh
    	out dx,al
    	in al,dx                      	;读行扫描值
    	and al,0fh
    	cmp al,0fh
    	jnz key_waitup                	;按键未抬起转
    	call delay                    	;等待
key1:    	ret
KEY    ENDP
delay proc near
        push ax                   	       ;延时 50ms--100ms
        pushf
        mov ah,0
        int 1ah
	 mov bx,dx
delay1:
    	mov ah,0
    	int 1ah
    	cmp bx,dx
    	jz delay1
	mov bx,dx
delay2:
    	mov ah,0
    	int 1ah
    	cmp bx,dx
    	jz delay2
    	popf
    	pop ax
    	ret
delay endp
DISPLY    PROC NEAR
    	PUSH ax
    	MOV BX,OFFSET LED
    	MOV AL,byte ptr key_in
       SUB al,30h
       CMP al,09h
       JNG  DIS2
       SUB al,07h
DIS2: 	XLAT
    	MOV DX,a8255
    	OUT DX,AL                     ;输出显示数据，段码
    	MOV AL,0ffH
    	MOV DX,b8255
	MOV CX,0006                   ;段码显示,6位
DISPLY1:
    	OUT DX,AL                     ;输出显示数据，位码，打开显示
    	PUSH CX
	MOV CX,0A000H                 ;显示时间延迟
DISPLY_DELAY:
    	LOOP DISPLY_DELAY
    	POP CX
    	LOOP DISPLY1
    	POP AX
    	RET
DISPLY    ENDP
code ends
end start
