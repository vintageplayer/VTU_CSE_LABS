dispchar macro
mov ah,02h 			; Storing the code to display a character
int 21h 			; BIOS interrupt (Displaying a character)
endm
