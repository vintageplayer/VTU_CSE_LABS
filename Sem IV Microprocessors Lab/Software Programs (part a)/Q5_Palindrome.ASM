.model small
.data
        str1 db "madam$"
        str2 db 80 dup(0)
        m1 db "Entered string is not a palindrome!!$"
        m2 db "The entered string is a palindrome!!$"
        len equ 5

.code
        mov ax,@data
        mov ds,ax
        mov es,ax

        lea si,str1
        lea di,str2
        add di,len
        dec di
        mov cx,len
again:
        mov al,[si]
		mov [di],al
		inc si
		dec di
		loop again

		lea si,str1
		lea di,str2
		mov cx,len
		CLD

		repe cmpsb
		JCXZ match

		mov dx,offset m1
		mov ah,09h
		int 21h
		jmp terminate
match:
		mov dx,offset m2
		mov ah,09h
		int 21h

terminate:
		mov ah,4ch
		int 21h
end
