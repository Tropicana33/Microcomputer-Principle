;////////////////////////////////////////////////////////////////////
;// 字 符 矩 阵                                                    //
;// CopyRight CCSoft 2002.11.5                                     //
;//                                                                //
;// 运行后输入一个大写字符，然后看输出结果吧！                     //
;// 注意：一定是大写字符，否则后果难料。程序中注释详尽，可以参照   //
;// 改动一下，使之可以适应各种输入。                               //
;//                                                                //
;////////////////////////////////////////////////////////////////////

;///////////////////////macro define segment/////////////////////////
;output pstr
moutput macro pstr
mov dx,offset pstr
mov ah,09h
int 021h
endm
;if pa(pr)pb,goto pl
mloop macro pb,pa,pr,pl
mov al,pa
cmp al,pb
j&pr pl
endm
;///////////////////////stack segment////////////////////////////////
stacks segment stack
db 128 dup(?)
stacks ends
;///////////////////////data segment/////////////////////////////////
datas segment
n db 0 ;number to loop
cline db 13,10,'$' ;change line
oc db ?,'$' ;put out a letter
ld db ? ;record times l1 looped
l1 db ? ;first lay loop counter
l2a db ? ;second lay loop counter
l2ad db 0 ;record times l2a looped
l2b db ?
l2c db ?
ds1 db 9,?,?,'$'
datas ends
;///////////////////////code segment/////////////////////////////////
codes segment
assume cs:codes,ds:datas
;///////////////////////////////////
start proc far
;initialize the programme
mov ax,datas
mov ds,ax
;read a character to draw
mov ah,01h ;get a character
int 021h
sbb al,41h ;get the number of the character
mov n,al
mov cl,2
imul cl
inc al
mov l1,al ;l1=n*2+1
mov ld,0 ;no loop done
mov al,n
adc al,41h
mov oc,al ;set c n
call piniset
;begin to draw!
moutput cline ;change line to separate input and output
lu1: mloop l1,1,a,el1 ;if l1<1 then goto el1(exit loop 1)
call pl2a ;output down characters
call pl2b ;output flat characters
call pl2c ;output up caharacters
;set the times 2a,2b,2c should looped
call pmark ;mark the line number
moutput cline ;after a line is output,change lines
inc ld ;looped 1 more
dec l1
call piniset
ld1: jmp lu1
el1: nop
mov ax,4c00h ;return to dos
int 21h
start endp
;///////////////////////////////////
;initialize the l2a,l2b,l2c accroding to l1 and ld
piniset proc near
mov al,n
cmp al,ld
jb nb1 ;if ld>n then goto nb1
je ne1 ;if ld=n then goto ne1
ja na1 ;if ld<n then goto na1
nb1: mov al,ld
sbb al,n
inc al
mov cl,2
mul cl
inc al
mov l2b,al ;l2b=(ld-n+1)*2+1
mov al,n
mov cl,2
mul cl
sbb al,ld
mov l2a,al ;l2a=2*n-ld-1
mov l2c,al ;l2a=2*n-ld-1
jmp pe
ne1: mov al,n
mov l2a,al
mov l2c,al
mov l2b,1
jmp pe
na1: mov al,n
mov cl,2
imul cl
inc al
sbb al,ld
sbb al,ld
mov l2b,al ;l2b=2*n+1-ld-ld
mov al,ld
mov l2a,al ;l2a=ld
mov l2c,al ;l2a=ld
jmp pe
pe: nop
ret
piniset endp
;///////////////////////////////////
;output the first part,down letters
pl2a proc near
lu2a: mloop l2a,1,a,el2a ;if l2a<1 then goto el2a(exit loop 2a)
moutput oc ;output oc
dec oc ;oc=oc-1
dec l2a ;l2a=l2a-1
jmp lu2a
el2a: nop
ret
pl2a endp
;///////////////////////////////////
;output the second part,flat letters
pl2b proc near
lu2b: mloop l2b,1,a,el2b ;if l2b<1 then goto el2b(exit loop 2b)
moutput oc ;output oc
dec l2b
jmp lu2b
el2b: nop
ret
pl2b endp
;///////////////////////////////////
;output the third part,coresponded to the first part,up letters
pl2c proc near
lu2c: mloop l2c,1,a,el2c ;if l2c<1 then goto el2b(exit loop 2c)
inc oc ;oc=oc+1
moutput oc ;output oc
dec l2c
jmp lu2c
el2c: nop
ret
pl2c endp
;///////////////////////////////////
;mark the line number
pmark proc near
push ax
push dx

mov ah,0
mov al,ld
inc al
mov dl,10

div dl
adc ah,30h
mov ds1+2,ah
mov ah,0

div dl
adc ah,30h
mov ds1+1,ah
mov ah,0

mov dx,offset ds1
mov ah,9
int 21h
pop dx
pop ax
ret
pmark endp
codes ends
end start
