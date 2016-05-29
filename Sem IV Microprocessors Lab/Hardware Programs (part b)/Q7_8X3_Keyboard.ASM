.model small
.data
        m1 db "The entered key is : $"
        m2 db "Row number is : $"
        m3 db "Column number is : $"
        row db 0
        col db 0
        arr db "0123456789.+-*/%ACK=MRXY" ; Array values as stored in the keyboard row-wise 
        pa equ 9800H
        pb equ 9801H
        pc equ 9802H
        cw equ 9803H
        cwr equ 90H
.code
        mov ax,@data
        mov ds,ax

        mov dx,cw               ; Initializing
        mov al,cwr              ; the control 
        out dx,al               ; word register
again:
        mov dx,pc               ; Selecting the 
        mov al,01H              ; first column
        out dx,al               ; of the keyboard

        mov dx,pa               ; Inputting the column status
        in al,dx                ; bits of the first row

        cmp al,00               ; Checking if any 
        jne first               ; key was pressed

        mov dx,pc               ; Selecting the
        mov al,02H              ; second row
        out dx,al               ; of the keyboard

        mov dx,pa               ; Inputting the column status
        in al,dx                ; bits of the second row

        cmp al,00               ; Checking if any key
        jne second              ; was pressed

        mov dx,pc               ; Selecting the
        mov al,04H              ; third row
        out dx,al               ; of the keyboard

        mov dx,pa               ; Inputting the column status
        in al,dx                ; bits of the third row

        cmp al,00               ; Checking if any key
        jne third               ; was pressed

        jmp again               ; Repeating till a key is pressed
first:
        mov row,00H             ; Storing the row value
        jmp next
second:
        mov row,01H             ; Storing the row value
        jmp next
third:
        mov row,02H             ; Storing the row value
next:
        mov bl,al               ; Making a copy of the status bits
        mov cx,0008H            ; Setting the counts for 8 bits
        mov bh,00H              ; Initializing the column count
shift:
        and al,01H              ; Masking the higher 7 bits
        cmp al,01H              ; Checking if the bit is set
        je display              ; Jumping if bit is set
        inc bh                  ; Increment count if bit not set
        shr bl,01H              ; Shifting the column status bits to right
        mov al,bl               ; Moving the value for comparison
        loop shift              ; looping for all 8 bits
display:
        mov col,bh              ; Storing the column value

        lea dx,m1               ; Displaying
        mov ah,09h              ; the first
        int 21h                 ; message

        mov ah,00H              ; clearing ah register
        mov al,row              ; storing the row index
        mov cl,03H              ; setting count as 3
        shl ax,cl               ; shifting al bits to left (multiplying it by 8)
        add al,col              ; add the column index
        mov si,ax               ; loading the net index in si

        mov dl,arr[si]          ; loading the character to be displayed in dl
        mov ah,02H              ; code to display a character
        int 21h                 ; displaying the character

        mov al,0AH              ; Displaying a 
        int 21h                 ; new line character

        mov dx,offset m2        ; Displaying
        mov ah,09h              ; the row
        int 21h                 ; message

        mov dl,row              ; loading the row value
        add dl,01H              ; indexing starts from 0, adjusting it to 1
        add dl,30H              ; storing the ASCII value for the number
        mov ah,02H              ; Code to print a character
        int 21h                 ; displaying the character stored in dl

        mov dl,0AH              ; Displaying a
        int 21h                 ; new line (AH is already 02)

        mov dx,offset m3        ; Displaying
        mov al,09H              ; the column
        int 21h                 ; message

        mov dl,col              ; storing the row value in dl
        add dl,01H              ; Adding to change indexing from 0 to 1
        add dl,30H              ; Storing the ASCII code for the number
        mov ah,02H              ; Code to print a character
        int 21h                 ; DOS interrupt (Displaying the character)

        mov ah,4ch              ; Code to terminate the process
        int 21h                 ; DOS interrupt (terminating the process)
end
