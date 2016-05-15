.model small

.data
list dw 1234H,2345H,3456H,4567H,5678H
len dw ($-list)/2
m1 db "Element not found!!$"
m2 db "Element found!!$"
res db "Position : $"
key dw 2445H

.code
mov ax,@data
mov ds,ax
mov dx,len
dec dx
mov cx,key
mov bx,00

again:
mov si,bx
add si,si
cmp cx,list[si]
jb fail
mov ax,bx
add ax,dx
shr ax,01
mov si,ax
add si,si
cmp cx,list[si]
jae big
dec ax
mov dx,ax
jmp again

big:
je success
inc ax
mov bx,ax
jmp again

success:
mov cl,al
lea dx,m2
mov ah,09h
int 21h
mov dx,offset res
int 21h
mov dl,cl
add dl,31h
mov ah,02h
int 21h
jmp terminate

fail:
mov dx,offset m1
mov ah,09h
int 21h
terminate:
mov ah,4ch
int 21h
end