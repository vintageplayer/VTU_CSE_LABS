readkey  macro
mov ah,01h 			; Storing the code to read a character
int 21h 			; BIOS interrupt (Reading a character)
endm
