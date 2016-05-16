.model small
.data
		m1 db "The current system time is : $"
.code
		mov ax,@data
		mov ds,ax

		mov dx,offset m1
		mov ah,09h
		int 21h

		mov ah,2ch
		int 21h

		mov al,ch
		call disp

		mov dl,':'
		mov ah,02h
		int 21h

		mov al,cl
		call disp

		mov dl,':'
		mov ah,02h
		int 21h

		mov al,dh
		call disp

		mov ah,4ch
		int 21h
disp proc
		AAM
		mov bx,ax
		add bx,3030h
		mov dl,bh
		mov ah,02h
		int 21h

		mov dl,bl
		mov ah,02h
		int 21h
		ret
disp endp
end