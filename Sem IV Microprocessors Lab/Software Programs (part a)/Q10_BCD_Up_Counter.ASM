.model small
.data

.code
		mov ax,@data
		mov ds,ax

		mov cx,00 			; clearing cx
		mov bh,00h 			; initializing Ten's digit
		mov ah,02h			; code to display a digit
outer:
		mov bl,00 			; initializing One's digit
		mov cl,0AH 			; resetting count
inner:
		call clear 			; calling the clear procedure
		call setcursor 		; calling the setcursor procedure

		mov dl,bh 			; Displaying the
		add dl,30h 			; Ten's digit
		int 21h 			; after ascii adjust

		mov dl,bl 			; Displying the
		add dl,30h 			; One's Digit 
		int 21h 			; after ASCII adjust

		call delay 			; calling delay procedures
		inc bl 				; incrementing One's digit

		loop inner

		inc bh 				; Incrementing Ten's digit
		cmp bh,0AH 			; checking for value 10 in bh
		jne outer

		mov ah,4ch
		int 21h

delay proc
		push cx
		push bx
		mov cx,0bffh
loop1:
		mov bx,00ffh
loop2:
		dec bx
		jnz loop2
		loop loop1
		pop bx
		pop cx
		ret
delay endp

clear proc
		push ax
		mov ax,0003h
		int 10h
		pop ax
clear endp
setcursor proc
		push ax
		push dx
		push bx

		mov bh,00h
		mov ah,02h
		mov dl,25h
		mov dh,0Ah
		int 10h

		pop bx
		pop dx
		pop ax
		ret
setcursor endp

end