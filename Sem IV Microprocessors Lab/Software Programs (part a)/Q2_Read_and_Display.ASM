.model small

.data
str db 80 dup(0)

.code
mov ax,@data
mov dx,ax

include readkb.asm
include dispch.asm

mov cx,00
lea si,str

read:
readkey
cmp al,' '
je next
mov [si],al
inc si
inc cx
jmp read

next:
mov dl,0AH
dispchar
lea si,str

write:
mov dl,[si]
dispchar
inc si
loop write

mov ah,4ch
int 21h
end
