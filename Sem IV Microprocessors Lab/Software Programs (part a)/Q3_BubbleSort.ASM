.model small

.data
arr db 09h,07h,03h,08h,05h
len equ ($-arr)
m2 db "The sorted array is : $"

.code
mov ax,@data
mov ds,ax

lea dx,m2
mov ah,09h
int 21h

mov bl,len
dec bl

loop1:
mov cl,bl
mov si,00H
loop2:
mov al,arr[si]
cmp al,arr[si+1]
jb next
xchg al,arr[si+1]
mov arr[si],al
next:
inc si
loop loop2

dec bl
jnz loop1


mov dl,0AH
mov ah,02h
int 21h

mov cl,len
mov si,00
mov ah,02h
disp:
mov dl,arr[si]
add dl,30H
int 21h
mov dl,' '
int 21h
inc si
loop disp

mov ah,4ch
int 21h
end