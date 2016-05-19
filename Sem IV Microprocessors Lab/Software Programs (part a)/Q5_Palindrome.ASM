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

        lea si,str1 			; Loading the effective address of array 1 in si
        lea di,str2 			; Loading the effective address of array 2 in di
        add di,len 				; Making di to point to the position of de-limiting character
        dec di 					; Reducing di to point to the position of last character
        mov cx,len 				; Storing the number of characters as count
again:
        mov al,[si] 			; Copying the current charater in al
		mov [di],al 			; Storing the current character in new array
		inc si 					; Pointing to the next character in source array
		dec di 					; Reducing the index inorder to reverse the string
		loop again				; Reducing cx value. If zero repeating the process

		lea si,str1				; Loading the effective address of the original string
		lea di,str2				; Loading the effective address of the reverse string
		mov cx,len				; Storing the number of characters in cx 
		CLD						; Clearing the direction flag

		repe cmpsb				; Repeatedly comparing the strings pointed by si and di till cx=0 or a character doesn't match
		JCXZ match				; Jumping to match label if cx = 0

		mov dx,offset m1		; Loading the effective address of m1 in dx
		mov ah,09h				; Code to display an array of bytes delimited by '$'
		int 21h					; DOS interrupt (Displaying the message)
		jmp terminate			; Jumping to terminate label
match:
		mov dx,offset m2		; Loading the effective address of the second message
		mov ah,09h				; Code to print a message delimited by '$'
		int 21h					; DOS interrupt (Displaying the message)

terminate:
		mov ah,4ch				; Code to terminate a process
		int 21h					; DOS interrupt (Terminating the program)
end
