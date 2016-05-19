dispchar macro
mov ah,02h 			; Storing the code to display a character
int 21h 			; DOS interrupt (Displaying a character)
endm
