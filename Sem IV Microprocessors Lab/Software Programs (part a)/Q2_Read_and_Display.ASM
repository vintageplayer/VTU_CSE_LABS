.model small

.data
		str db 80 dup(0) 			; Allocating memory for storing the characters

.code
		mov ax,@data
		mov dx,ax

		include readkb.asm			; Including the macro to read a character
		include dispch.asm			; Including the macro to display a character

		mov cx,00 					; Clearing the count to 0
		lea si,str 					; Loading the address of memory space in si

read:
		readkey 					; Calling the readkey macro
		cmp al,ODH					; Checking for end of input (delimiter as new line character)
		je next						; Jumping to next if end of input
		mov [si],al 				; Storing the input character in memory
		inc si 						; Pointing to next free memory space
		inc cx 						; Incrementing the count of number of characters
		jmp read 					; Reading again

next:
		mov dl,0AH					; Storing the ASCII value for newline character
		dispchar					; Using the macro to display one character

		lea si,str 					; Loading the effective address of the array
write:
		mov dl,[si] 				; Storing the character in dl
		dispchar					; Using the macro to display one character
		inc si 						; Pointing to the next character
		loop write					; Decrementing count. If not zero, displaying again

		mov ah,4ch					; Code to terminate the process
		int 21h						; BIOS interrupt (terminating the program)
end
