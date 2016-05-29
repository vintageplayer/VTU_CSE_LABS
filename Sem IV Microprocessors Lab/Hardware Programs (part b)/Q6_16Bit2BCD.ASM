.model small
.data
        pa    equ  9800H
        pb    equ  9801H
        pc    equ  9802H
        cwr   equ  9803H
        cw    equ   80H
        value equ   0ffffH
        res    db  5   dup(0)
        BCD    db   0C0H,0F9H,0A4H,0B0H,99H,92H,82H,0F8H,80H,98H
.code
        mov ax,@data
        mov ds,ax

        mov ax,00       ; Initializing all
        mov bx,00       ; registers to
        mov dx,00       ; zero to represent 00000 (max 65535)

        mov cx,value    ; Setting Loop count
repeat:
        inc al          ; Incrementing one's digit
        cmp al,0AH      ; Checking if value exceeds 9
        jne next        ; Jumping to label next if a legal value

        inc ah          ; Incrementing 10's position digit
        mov al,00       ; Setting one's digit to 0

        cmp ah,0AH      ; Checking if one's digit value is greater than 9
        jne next        ; Jumping to label next if ah less than 10

        inc bl          ; Incrementing 100's digit by 1
        mov ah,00       ; Setting 10's digit as 0

        cmp bl,0AH      ; Checking if 100's digit register value greater than 9
        jne next        ; Jumping to label next if legal value

        inc bh          ; Incrementing 1000's place digit
        mov bl,00       ; Setting 100's place digit to 0

        cmp bh,0AH      ; Checking if 1000's digit value less than 10
        jne next        ; Jumping to label next if value is legal

        mov bh,00       ; Storing 0 in 1000's place
        inc dh          ; Incrementing 10000's place digit
next:
        loop repeat     ; Repeating till initial value becomes 0

        lea si,res      ; Loading effective address of array res

        mov [si],dh     ; Storing 10000's place digit
        mov [si+1],bh   ; Storing 1000's place digit
        mov [si+2],bl   ; Storing 100's place digit
        mov [si+3],ah   ; Storing 10's place digit
        mov [si+4],al   ; Storing 1's place digit

        mov bl,03H      ; Storing the total number of left-to-right and right-to-left display
        mov ch,00       ; Clearing higher 8 bits of count 
again:
        mov cl,05       ; Storing number of digits to be shown
        lea si,res      ; Loading the effective address of address storing the BCD value
l2r:
        mov al,bcd[si]  ; Copying the repective 7-segment code for decimal value into al
        call display    ; Invoking display procedure
        inc si          ; Pointing to the next digit
        loop l2r        ; Repeating for all digits

        mov cl,05       ; Storing number of digits in count
r2l:
        dec si          ; Pointing to the previous digit
        mov al,bcd[si]  ; Storing the respective 7-segment code for decimal value into al
        call display    ; Invoking display procedure
        loop r2l        ; Repeating for all digits

        dec bl          ; Decrementing remaining number of times value is to be displayed
        jnz again       ; Jumping to label again if value is yet to be displayed again

        mov ah,4ch      ; Code to terminate a process
        int 21h         ; DOS interrupt (Terminating the program)
display proc 
        push cx         ; Storing cx value into stack
        push bx         ; Storing bx value into stack
        push ax         ; Storing ax value into stack

        mov cl,08H      ; Storing the number of bits to be sent
        mov bl,al       ; Copying the 7-segment codes
disp:
        rol bl,01       ; Accessing each bit by rotating bits left
        mov al,bl       ; Storing the rotated value into al
        mov dx,pb       ; Copying the output port address
        out dx,al       ; Sending data in al to port addressed in dx

        mov dx,pc       ; Copying clock cycle port address
        mov al,0ffH     ; Storing code for logic high
        out dx,al       ; Sending data in al to port addressed in dx

        mov al,00H      ; Copying a logic low signal for clock
        out dx,al       ; Sending data in al to port addressed in dx

        loop disp       ; Repeating for all 8 bits
        pop ax          ; Restoring ax value from stack
        pop bx          ; Restoring bx value from stack
        pop cx          ; Restoring cx value from stack
        ret
display endp
end
