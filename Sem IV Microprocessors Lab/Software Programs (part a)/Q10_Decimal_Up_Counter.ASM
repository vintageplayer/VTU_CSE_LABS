.model small
.data

.code
		mov ax,@data
		mov ds,ax

		mov cx,00 			; clearing cx
		mov bh,00h 			; initializing Ten's digit
		mov ah,02h			; code to display a digit
outer:
		mov bl,00 			; initializing One's digit
		mov cl,0AH 			; resetting count
inner:
		call clear 			; calling the clear procedure
		call setcursor 		; calling the setcursor procedure

		mov dl,bh 			; Displaying the
		add dl,30h 			; Ten's digit
		int 21h 			; after ascii adjust

		mov dl,bl 			; Displying the
		add dl,30h 			; One's Digit 
		int 21h 			; after ASCII adjust

		call delay 			; calling delay procedures
		inc bl 				; incrementing One's digit

		loop inner

		inc bh 				; Incrementing Ten's digit
		cmp bh,0AH 			; checking for value 10 in bh
		jne outer

		mov ah,4ch 			; Terminating the
		int 21h 			; process

delay proc
		push cx 			; Storing the cx register value
		push bx 			; Storing the bx register value
		mov cx,0bffh 		; Initializing the outer loop count
loop1:
		mov bx,00ffh 		; Initializing the inner loop count
loop2:
		dec bx 				; Reducing the inner loop count
		jnz loop2 			; Checking for end of inner loop
		loop loop1 			; Checking cx value and jumping to loop1 if cx!=0
		pop bx 				; restoring bx value
		pop cx 				; restoring cx value
		ret
delay endp

clear proc
		push ax 			; Storing ax register value
		mov ax,0003h 		; Code to clear a screen
		int 10h 			; BIOS interrup (clearing the  screen)
		pop ax 				; Restoring ax register value
clear endp
setcursor proc
		push ax 			; Storing the
		push dx 			; register values
		push bx				; in stack

		mov bh,00h 			; Setting the number of video pages to 1
		mov ah,02h 			; Setting the code to set cursor position
		mov dl,25h 			; Setting the column number
		mov dh,0Ah 			; Setting the row number
		int 10h 			; Calling BIOS interrupt (Setting the cursor position)

		pop bx 				; Restoring the
		pop dx				; register values
		pop ax				; from stack
		ret
setcursor endp

end