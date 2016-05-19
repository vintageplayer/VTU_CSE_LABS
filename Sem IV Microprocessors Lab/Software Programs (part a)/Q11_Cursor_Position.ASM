.model small
.data
        msg1 db "Enter the row co-ordinates (00 to 24) : $"
        msg2 db "Enter the column co-ordinates (00 to 79) : $"
        row db 0
        col db 0
.code
        mov ax,@data
        mov ds,ax

        mov ax,0002H            ; Storing code to clear the screen
        int 10H                 ; BIOS interrupt (Clearing the screen)

        mov dx,offset msg1      ; Loading the effective address of the array msg1
        mov ah,09H              ; Code to display an array of bytes delimited by '$'
        int 21h                 ; DOS interrupt (Displaying the message)

        call read               ; Invoking the procedure to read co-ordinates
        mov row,al              ; Storing the input in row

        mov dl,0AH              ; Storing ASCII code for newline character in dl
        mov ah,02H              ; Storing the code to display a character
        int 21h                 ; DOS interrupt (Displaying a character)

        mov dx,offset msg2      ; Loading the effective address of the array msg2
        mov ah,09H              ; Code to display an array of bytes delimited by '$'
        int 21h                 ; DOS interrupt (Displaying the message)

        call read               ; Invoking the procedure to read co-ordinates
        mov col,al              ; Storing the input in col

        mov ah,02H              ; Code to select video mode
        mov dl,col              ; Copying the column co-ordinates
        mov dh,row              ; Copying the row co-ordinates
        mov bh,00H              ; Selecting the number of video pages
        int 10H                 ; BIOS interrupt (Placing the cursor)

        mov ah,4ch              ; Storing the code to terminate a process
        int 21h                 ; DOS interrupt (Terminating the program)

read proc
        mov ah,01H              ; Storing the code to read a character
        int 21h                 ; DOS interrupt (Reading a character into al)

        and al,0fH              ; Masking the higher 4 bits of the ASCII value
        mov bl,al               ; Storing the value in bl

        mov ah,01H              ; Storing the code to read a character
        int 21h                 ; DOS interrupt (Reading a character)

        and al,0fH              ; Masking the higher 4 bits of the ASCII value
        mov ah,bl               ; Storing  the higher digit into ah
        AAD                     ; Reducing the 2 digit into the required Hex value
        ret
read endp
end
