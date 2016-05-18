.model small
.data
		m1 db "Menu :$"
		m2 db "1. Create a file.  2. Delete a file.$"
		m3 db "Enter the option number : $"
		m4 db "Error!! Exiting...$"
		file db "justhappen.txt$",0
.code
		mov ax,@data
		mov ds,ax

		lea dx,m1 		; Loading the effective address of array m1
		mov ah,09h 		; Storing the code to display an array of bytes delimited by '$'
		int 21h 		; BIOS interrupt (Displaying the message)

		mov dl,0AH 		; Storing the ASCII value of newline character
		mov ah,02h		; Storing the code to display a character
		int 21h 		; BIOS interrupt (Displaying a character)

		lea dx,m2 		; Loading the effective address of array m2
		mov ah,09h 		; Storing the code to display an array of bytes delimited by '$'
		int 21h 		; BIOS interrupt (Displaying the message)

		mov dl,0AH 		; Storing the ASCII value for a newline character
		mov ah,02h 		; Storing the code to display a character
		int 21h			; BIOS interrupt (Displaying a character)

		lea dx,m3 		; Loading the effective address of array m3
		mov ah,09h 		; Storing the code to display an array og bytes delimited by '$'
		int 21h 		; BIOS interrupt (Displaying the message)

		mov ah,01h 		; Storing the code to read a character
		int 21h 		; BIOS interrupt (Reading a character)

		cmp al,'1'		; Comparing the input value with '1'
		je create 		; Jumping to label one if equal

		cmp al,'2'		; Comparing the input value with '2'
		je delete 		; Jumping to label delete if equal

error :
		mov dl,0AH 		; Storing the ASCII value of newline character in dl
		mov ah,02h 		; Storing the code to display a character
		int 21h 		; BIOS interrupt (Displaying a character)

		lea dx,m4 		; Loading the effective address of array m4
		mov ah,09h		; Storing the code to dispay an array of bytes delimited by '$'
		int 21h 		; BIOS interrupt (Displaying the message)
exit :
		mov ah,4ch 		; Storing the code to terminate a process
		int 21h 		; BIOS interrupt (Terminating the program)
		jmp stop
create :
		mov ah,3ch 		; Storing the code to create a file
		lea dx,file 	; Loading the effective address of array file into dx
		int 21h 		; BIOS interrupt (Creating the file)
		jc error 		; Jump to error if carry flag is set
		jmp exit 		; Jump to exit label
delete :
		mov ah,41h		; Storing the code to delete a file
		lea dx,file 	; Loading the effective address of the array file
		int 21h 		; BIOS interrupt (Deleting the file)
		jc error 		; Jump to label error if carry flag is set
		jmp exit 		; Jump to label exit
stop:
end