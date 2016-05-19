.model small
.data
mov al,82h
mov dx,0ed03h
out dx,al
mov dx, 0ed01h
in al,dx
mov bl,al
in al,dx
mul bl
mov dx,0ed00h
out dx,al
mov ah, 4ch
int 21h
end



