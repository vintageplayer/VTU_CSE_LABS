.model small

.data
m1 db "Enter an alphanumeric character : $"
m2 db "ASCII value of the character is : $"

.code
mov ax,@data
mov ds,ax
mov ax,0003h
int 10h
mov dx,offset m1
mov ah,09h
int 21h

mov ah,01h
int 21h

mov bl,al

mov dl,0ah
mov ah,02h
int 21h

mov dx,offset m2
mov ah,09h
int 21h

mov ah,02h
mov bh,00h
mov dh,0dh
mov dl,25h
int 10h

mov al,bl
mov cl,04h
shr al,cl
cmp al,0Ah
jb next1
add al,07H
next1:
mov bh,al

mov al,bl
and al,0fH
cmp al,0Ah
jb next2
add al,07H
next2:
mov bl,al
add bx,3030h

mov dl,bh
mov ah,02h
int 21h
mov dl,bl
mov ah,02h
int 21h

mov ah,4ch
int 21h
end
