.model small

.data
		str db 80 dup(?)
		m1 db "What is your name? $"
		m2 db "My name is : $"

.code
		mov ax,@data
		mov ds,ax

		mov dx,offset m1 		; Loading the effective address of array m1 in dx
		mov ah,09h 				; Storing code to display an array of bytes delimited by '$'
		int 21h 				; DOS interrupt (Displaying an array of bytes)

		lea si,str 				; Loading the effective address of array str in si
		mov ah,01h 				; Storing the code to input a character
read:
		int 21h 				; DOS interrupt (Reading a character)
		cmp al,0DH 				; Comapring input with carriage return character
		je next 				; Jumping to label next if equal
		mov [si],al 			; Storing the input into memory reference by si
		inc si 					; Pointing si to the next memory location
		jmp read 				; Jumping to read label to continue reading

next:
		mov al,'$' 				; Storing '$' in al
		mov [si],al 			; Storing the character in al at the end of array as delimiter

		mov ax,0003h 			; Storing code to clear the screen
		int 10h					; BIOS interrupt (Clearing the screen)

		lea si,str 				; Loading the effective address of array str in si

		mov ah,02h 				; Storing code to select video mode
		mov bh,00h 				; Specifying the number of pages
		mov dl,25h 				; Specifying the column number
		mov dh,10h 				; Specifying the row number
		int 10h					; BIOS interrupt (Setting the cursor position)

		mov dx,offset m2 		; Loading the effective address of array m2
		mov ah,09h 				; Storing code to display array of bytes delimited by '$'
		int 21h 				; DOS interrupt (Displaying the array of bytes)

		mov dx,offset str 		; Loading the effective address of array str
		int 21h 				; DOS interrupt (Displaying the array of bytes)

		mov ah,4ch 				; Storing the code to terminate a process
		int 21h 				; DOS interrupt (Terminating the program)
end