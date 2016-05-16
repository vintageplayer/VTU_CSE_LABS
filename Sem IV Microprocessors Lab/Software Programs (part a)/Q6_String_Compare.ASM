.model small

.data
		str1 db 80 dup(?)
		str2 db 80 dup(?)
		m1 db "Enter the first string : $"
		m2 db "Enter the second string : $"
		case1 db "The strings are equal.$"
		case2 db "The strings aren't equal!!$"
		len1 db "Lenght of the first string is : $"
		len2 db "Lenght of the second string is : $"

.code
		mov ax,@data
		mov ds,ax
		mov es,ax

		CLD
		mov cx,00h
		mov dx,offset m1
		mov ah,09h
		int 21h

		lea si,str1
		call read
		mov bl,cl

		mov dx,offset m2
		mov ah,09h
		int 21h

		lea si,str2
		call read
		mov bh,cl

		cmp bl,bh
		jne nequal

		mov si,offset str1
		mov di,offset str2
		repe cmpsb
		JCXZ equal

nequal:
		mov dx,offset case2
		mov ah,09h
		int 21h
		jmp next

equal:
		mov dx,offset case1
		mov ah,09h
		int 21h

next:
		mov dl,0AH
		mov ah,02h
		int 21h

		mov dx,offset len1
		mov ah,09h
		int 21h

		mov dl,bl
		mov cl,04h
		shr dl,cl
		add dl,30H
		mov ah,02h
		int 21h

		mov dl,bl
		and dl,0fh
		add dl,30H
		mov ah,02h
		int 21h

		mov dl,0AH
		mov ah,02h
		int 21h

		mov dx,offset len2
		mov ah,09h
		int 21h

		mov dl,bh
		mov cl,04h
		shr dl,cl
		add dl,30H
		mov ah,02h
		int 21h

		mov dl,bh
		and dl,0fh
		add dl,30H
		mov ah,02h
		int 21h
		mov ah,4ch
		int 21h

read proc
		mov cl,00
		mov ah,01h
again:
		int 21h
		mov [si],al
		inc si
		inc cx
		cmp al,0DH
		jne again
		dec cx
read endp
ret
end