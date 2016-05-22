.model small
.data
        msg1 db "Enter the input and press a key...$"
        res  db "No. of 1's in the input : $"
        pa  equ 9800H
        pb  equ 9801H
        pc  equ 9802H
        cwr equ 9802H
        cw  equ   82H           ; Port B is an input port
.code
        mov ax,@data
        mov ds,ax

        mov dx,cwr              ; Loading the port address of control word register
        mov al,cw               ; Copying the control word into al
        out dx,al               ; Sending the control word data in dl to port addressed in dx

        mov dx,offset msg1      ; Loading the effective address of array msg1
        mov ah,09H              ; Code to display an array of bytes delimited by '$'
        int 21H                 ; DOS interrupt (Displaying the message)

        mov ah,08H              ; Code to input a character without echo on screen
        int 21h                 ; DOS interrupt (Inputting a character)

        mov dx,pb               ; Copying port B address
        in al,dx                ; Inputting data from port B

        mov bl,al               ; Copying the input data into bl
        add al,00H              ; Setting the flags without any change in the value of input
        JPE evenp               ; Jumping to label evenp if parity flag is set

        mov al,00H              ; Storing 00 for odd parity
        jmp display             ; Jumping to label display
evenp:
        mov al,0ffH             ; Storing ffH for even parity
display:
        mov dx,pa               ; Copying the port A address into dx
        out dx,al               ; Sending data in al to port addressed in dx

        mov dl,0AH              ; ASCII value for newline character
        mov ah,02h              ; Code to display a character
        int 21h                 ; DOS interrupt (Displaying a character)

        lea dx,res              ; Loading the effective address off array res
        mov ah,09H              ; Code to display an array of bytes delimited by '$'
        int 21h                 ; DOS interrupt (Displaying the message)

        mov cx,08H              ; Initializing the count as 8
        mov dl,00H              ; Setting the initial 'number of 1's' count as 0
        mov al,bl               ; Copying the input into al
again:
        ror al,01H              ; Rotating bits in al to right using the carry flag
        JNC next                ; If carry flag is not set, jumping to label next
        inc dl                  ; Incrementing the count of number of 1's
next:
        loop again              ; Repeating the process 8 times for all the 8 bits

        mov ah,02H              ; Code to display a character stored in dl
        add dl,30H              ; Converting the number to its ASCII value
        int 21h                 ; DOS interrupt (Displaying a character)

        mov ah,4ch              ; Code to terminate a process
        int 21h                 ; DOS interrupt (Terminating the program)
end
