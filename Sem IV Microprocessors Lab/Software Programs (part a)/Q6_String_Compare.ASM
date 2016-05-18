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

		CLD						; Clearing the direction flag
		mov cx,00h				; Initializing the count with 0
		mov dx,offset m1 		; Loading the effective address of array m1
		mov ah,09h				; Code to print an array of bytes delimited by '$'
		int 21h 				; BIOS interrupt (Displaying a message)

		lea si,str1 			; Loading the effective address of array str1 in si
		call read 				; Invoking the read procedure
		mov bl,cl 				; Moving the count in bl 

		mov dx,offset m2		; Loading the effective address of array m2 in dx
		mov ah,09h				; Code to display an array of bytes delimited by '$'
		int 21h					; BIOS interrupt (Displaying the message)

		lea si,str2 			; Loading the effective address of array str2 in si
		call read				; Calling the read procedure
		mov bh,cl 				; Storing the count in bh

		cmp bl,bh 				; Comparing the length of the two strings
		jne nequal 				; Jumping to nequal label if lenghts are different

		mov si,offset str1 		; Loading the effective address of array str1 in si
		mov di,offset str2 		; Loading the effective address of array str2 in di
		repe cmpsb 				; Repeatedly comparing the characters in the string till cx= or the characters are not same
		JCXZ equal				; Jumping to label equal if cx=0

nequal:
		mov dx,offset case2 	; Loading the effective address of array case2 in dx
		mov ah,09h 				; Code to display an array of bytes delimited by '$'
		int 21h 				; BIOS interrupt (Displaying the message)
		jmp next 				; Jumping to label next

equal:
		mov dx,offset case1 	; Loading the effective address of array case1 in dx
		mov ah,09h				; Code to display an array of bytes delimited by '$'
		int 21h					; BIOS interrupt (Displaying the message)

next:
		mov dl,0AH				; Storing the ASCII value for carriage return character
		mov ah,02h 				; Code for displaying one character
		int 21h					; BIOS interrupt (Displaying a character)

		mov dx,offset len1 		; Loading the effective address of array len1
		mov ah,09h				; Code to display an array of bytes delimited by '$'
		int 21h					; BIOS interrupt (Displaying the message)

		mov dl,bl				; Copying the lenght of the array in dl 
		mov cl,04h				; Storing the count as 04 in cl
		shr dl,cl 				; Shifting bytes in dl by 4 to the left (losing lower bits)
		add dl,30H				; Storin ASCII code for the digit
		mov ah,02h				; Code to display a character
		int 21h					; BOIS interrupt (Displaying a character)

		mov dl,bl				; Copying the length of first string into bl
		and dl,0fh				; Masking the higher 4 bits
		add dl,30H				; Storing the ASCII code of the digit to be printed
		mov ah,02h				; Code to display a character
		int 21h					; BIOS interrupt (Displaying a character)

		mov dl,0AH				; Storing the value of newline character
		mov ah,02h				; Code to display a character
		int 21h					; BIOS interrupt (Displaying a character)

		mov dx,offset len2 		; Loading the effective address of array len2 in dx
		mov ah,09h				; Storing code to display an array of bytes delimited by '$'
		int 21h 				; BIOS interrupt (Displaying an array of bytes)

		mov dl,bh 				; Copying the length of the second string in dl
		mov cl,04h				; Copying count as 04 in cl
		shr dl,cl 				; Shifting bits right in dl to store the higher digit
		add dl,30H				; Converting the digit to its ASCII code
		mov ah,02h				; Storing the code to display a character
		int 21h					; BIOS interrup (Displaying a character)

		mov dl,bh				; Copying the length of second string
		and dl,0fh				; Masking the higher 4 bits of the length in dl
		add dl,30H				; Converting the digit into its ASCII value
		mov ah,02h				; Storing the code to display a character
		int 21h					; BIOS interrupt (Displaying a character)

		mov ah,4ch				; Storing the code to terminate a process
		int 21h					; BIOS interrupt (terminating the program)

read proc
		mov cl,00 				; Initializing the count as 0
		mov ah,01H				; Storing the code to read a character from keyboard
again:
		int 21h 				; BIOS interrupt (Reading a character)
		mov [si],al 			; Storing the character in array referenced by si
		inc si 					; Referencing the next byte of memory location
		inc cx					; Incrementing the count
		cmp al,0DH 				; Comparing input with carriage return (newline character)
		jne again				; Reading again if not equal
		dec cx 					; Reducing the count due to counting carriage return
read endp
ret
end