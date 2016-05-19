.model small
.stack
.data
		n equ 5
		r equ 2
		res db 0

.code
		mov ax,@data
		mov dx,ax

		mov al,n 			; Copying n value in al
		mov ah,00 			; Clearing the higher ax byte
		mov bl,r 			; Copying r value in bl
		mov bh,00 			; Clearing the higer byte of bx register
		mov res,00h 		; Initializing the res value as 0
		call ncr 			; calling ncr procedure
		call disp 			; calling disp procedure
		mov ah,4ch 			; Storing code to terminate a process
		int 21h 			; DOS interrupt (Terminating the program)

disp proc
		mov al,res 			; Copying the result value in al
		aam 				; ASCII adjust after multiplication to
		add ax,3030h 		; Converting the two digits into their ASCII values
		mov bx,ax			; Storing the resultant into bx

		mov dl,bh 			; Copying the ten's digit into dl
		mov ah,02h 			; Storing the code to display a character
		int 21h 			; BIOS interrupt (Displaying a character)

		mov dl,bl 			; Copying the one's digit into dl
		int 21h 			; DOS interrupt (Displaying a character)
		ret
disp endp

ncr proc
		cmp al,bl 			; Comparing the n and r value
		je dn1 				; Jumping to label dn1 if equal
		cmp bl,00h 			; Coparing r value to 0
		je dn1 				; Jumping to dn1 if r = 0
		cmp bl,01h 			; Comparing r value with 1
		je dn2 				; Jumping to dn2 if r = 1
		dec al 				; Decrementing n value by 1
		cmp al,bl 			; Comparing new n value with r
		je dn3 				; Jumping to label dn3 if new n = r
		push ax 			; Storing the value of ax in stack
		push bx				; Storing the value of bx in stack
		call ncr			; Invoking the ncr procedure
		pop bx				; Restoring the value of bx from stack
		pop ax				; Restoring the value of ax from stack
		dec bl				; Decrementing r value
		call ncr			; Invoking ncr procedure
		ret
dn1:
		inc res 			; Adding 1 result
		ret
dn3:
		inc res 			; Adding 1 to result
dn2:
		add res,al 			; Adding n value to result
		ret
ncr endp
end