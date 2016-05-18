.model small
.data
		m1 db "The current system time is : $"
.code
		mov ax,@data
		mov ds,ax

		mov dx,offset m1 		; Loading the effective address of array m1 in dx
		mov ah,09h 				; Storing code to display an array of bytes delimited by '$'
		int 21h 				; BIOS interrupt (Displaying array of bytes)

		mov ah,2ch 				; Storing code to get system time in ch,cl,dh
		int 21h 				; BIOS interrupt (Getting the system time)

		mov al,ch 				; Copying hours in al
		call disp 				; Invoking display procedure

		mov dl,':' 				; Storing the ASCII code for ':' in dl
		mov ah,02h 				; Storing the code to display a character
		int 21h 				; BIOS interrupt (Displaying a character)

		mov al,cl 				; Copying the minutes value in al
		call disp 				; Calling the display procedure

		mov dl,':'				; Storing the ASCII value of ':' in dl
		mov ah,02h				; Storing the code to display a character
		int 21h 				; BIOS interrupt (Displaying a character)

		mov al,dh 				; Copying the seconds value in al
		call disp 				; Invoking the display procedure

		mov ah,4ch 				; Storing the code to terminate a process
		int 21h 				; BIOS interrupt (Terminating the program)
disp proc
		AAM 					; ASCII adjust after multiplication
		mov bx,ax 				; Copying the unpacked value in bx
		add bx,3030h 			; Converting the two digits to their ASCII values

		mov dl,bh				; Copying the ten's digit in dl
		mov ah,02h				; Storing the code to display a character
		int 21h 				; BIOS interrupt (Displaying a character)

		mov dl,bl 				; Copying the one's digit into dl
		mov ah,02h 				; Storing the code to display a character
		int 21h					; BIOS interrupt (Displaying a character)
		ret
disp endp
end