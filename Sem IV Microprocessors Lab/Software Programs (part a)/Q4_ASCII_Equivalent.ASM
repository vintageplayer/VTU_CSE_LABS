.model small

.data
		m1 db "Enter an alphanumeric character : $"
		m2 db "ASCII value of the character is : $"

.code
		mov ax,@data
		mov ds,ax
		mov ax,0003h		; code to clear the screen 
		int 10h				; BIOS interrupt

		mov dx,offset m1	; Displaying the
		mov ah,09h			; first
		int 21h				; message

		mov ah,01h			; Taking the input 
		int 21h				; from keyboard

		mov bl,al 			; Creating backup of the entered value

		mov dl,0Ah 			; Displaying
		mov ah,02h 			; a new-line
		int 21h 			; character

		mov dx,offset m2 	; Displaying the 
		mov ah,09h			; second
		int 21h				; message

		mov ah,02h 			; code to select cursor position

		mov bh,00h 			; selecting the screen page
		mov dh,0dh 			; Specifying the row number
		mov dl,25h 			; Specifying the column number
		int 10h 			; BIOS interrupt

		mov al,bl 			 
		mov cl,04h			; Storing the count
		shr al,cl 			; Replacing the lower digit with the higher one
		cmp al,0Ah 			; checking if value > 9
		jb next1 			; if value is less, jump
		add al,07H 			; convert value to decimal base 

next1:
		mov bh,al 			; store the result

		mov al,bl 			; reload the value
		and al,0fH 			; mask the higher digit
		cmp al,0Ah 			; check if value > 9
		jb next2 			; if value is less, jump
		add al,07H 			; conver value to decimal base
next2:
		mov bl,al 			; store the result
		add bx,3030h 		; make the numeric value to their respective ascii code

		mov dl,bh 			; mov the higher digit of the ascii code
		mov ah,02h 			; code to print a character
		int 21h 			; DOS interrupt - displaying the digit
		mov dl,bl 			; mov the lower digit of the ascii code
		mov ah,02h 			; code to print a character
		int 21h 			; DOS interrupt - displaying the digit

		mov ah,4ch 			; code to terminate a program
		int 21h 			; terminating the program
end
