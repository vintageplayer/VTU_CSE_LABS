
.model small
.data
pa equ 0ed00h
pb equ 0ed01h
pc equ 0ed02h
cr equ 0ed03h
cw equ 82h
msg1 db "the number of 1's is:",13,10," $"
.code
mov ax,@data
mov ds,ax
lea dx,msg1
mov ah,09h
int 21h
mov al,cw
mov dx,cr
out dx,al
mov dx,pb
in al,dx
mov cx,08h
mov bl,00h
again: shr al,01h
       jnc skip
       inc bl

skip:  loop again
       mov cl,bl
       shr cl,01h
       jc odd_p
       mov al,0ffh
       jmp here
odd_p: xor al,al
here:  mov dx,pa
       out dx,al
       add bl,30h
       mov dl,bl
       mov ah,02h
       int 21h
       mov ah,4ch
       int 21h
       end

