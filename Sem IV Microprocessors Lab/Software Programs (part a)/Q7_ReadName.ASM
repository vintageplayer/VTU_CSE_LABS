.model small

.data
		str db 80 dup(?)
		m1 db "What is your name? $"
		m2 db "My name is : $"

.code
		mov ax,@data
		mov ds,ax

		mov dx,offset m1
		mov ah,09h
		int 21h

		lea si,str
		mov ah,01h
read:
		int 21h
		cmp al,0DH
		je next
		mov [si],al
		inc si
		jmp read

next:
		mov al,'$'
		mov [si],al

		mov ax,0003h
		int 10h

		lea si,str

		mov ah,02h
		mov bh,00h
		mov dl,25h
		mov dh,10h
		int 10h

		mov dx,offset m2
		mov ah,09h
		int 21h

		mov dx,offset str
		int 21h

		mov ah,4ch
		int 21h
end