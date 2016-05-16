.model small
.stack
.data
		n equ 5
		r equ 2
		res db 0

.code
		mov ax,@data
		mov dx,ax
		mov al,n
		mov ah,00
		mov bl,r
		mov bh,00
		mov res,00h
		call ncr
		call disp
		mov ah,4ch
		int 21h

disp proc
		mov al,res
		aam
		add ax,3030h
		mov bx,ax

		mov dl,bh
		mov ah,02h
		int 21h

		mov dl,bl
		int 21h
		ret
disp endp

ncr proc
		cmp al,bl
		je dn1
		cmp bl,00h
		je dn1
		cmp bl,01h
		je dn2
		dec al
		cmp al,bl
		je dn3
		push ax
		push bx
		call ncr
		pop bx
		pop ax
		dec bl
		call ncr
		ret
dn1:
		inc res
		ret
dn3:
		inc res
dn2:
		add res,al 
		ret
ncr endp
end