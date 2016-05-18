.model small

.data
		arr db 09h,07h,03h,08h,05h
		len equ ($-arr)
		m2 db "The sorted array is : $"

.code
		mov ax,@data
		mov ds,ax

		lea dx,m2 				; Loading the effective address of the array m2
		mov ah,09h 				; Code to display an array of bytes delimited by '$'
		int 21h 				; BIOS interrup (Displaying the message)

		mov bl,len 				; Storing the lenght in bl
		dec bl					; Indexing from 0 instead of 1

loop1:
		mov cl,bl 				; Moving the inner loop count in cl
		mov si,00H 				; Starting with the first element of the array
loop2:
		mov al,arr[si]			; Copying the current element in al
		cmp al,arr[si+1]		; Comparing the current element with the next element
		jb next					; Jumping to next with current element is smaller
		xchg al,arr[si+1]		; exchanging value of al and next element 
		mov arr[si],al			; storing the value of next element in current element
next:
		inc si					; pointing si to the next element in the array
		loop loop2				; Decrementing count in cx. Repeating if not zero

		dec bl 					; Decrementing the outer loop count
		jnz loop1				; Repeating outer loop if not zero


		mov dl,0AH				; Moving the ASCII value for newline character
		mov ah,02h				; Code for displaying a character
		int 21h					; BIOS interrup (Displaying the newline character)

		mov cl,len				; Storing the number of elements in cl
		mov si,00				; Storing the index of the first element in si
		mov ah,02h				; Code to print one character
disp:
		mov dl,arr[si]			; Storing the currently index character in dl
		add dl,30H				; Storing the ASCII value for the digit to be displayed
		int 21h					; BIOS interrupt (displaying a character)
		mov dl,' '				; Moving the ASCII value of space character in dl
		int 21h					; BIOS interrupt (Displaying a character)
		inc si					; Indexing the next character in the array
		loop disp				; Decrementing cx register. Jumping to disp label if not zero

		mov ah,4ch				; Code to terminate a process
		int 21h					; BIOS interrupt (Terminating the program)
end