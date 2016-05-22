.model small
.data
        msg1 db "Enter the first input and press a key...$"
        msg2 db "Enter the second input and press a key..$"
        pa  equ 9800H
        pb  equ 9801H
        pc  equ 9802H
        cwr equ 9803H
        cw  equ   82H           ; Port B is an input port
.code
        mov ax,@data
        mov ds,ax

        mov dx,cwr              ; Copying the port address of control word register
        mov al,cw               ; Copying the control word value
        out dx,al               ; Initializing the control word register

        lea dx,msg1             ; Loading the effective address of array msg1
        mov ah,09H              ; Code to display array of bytes delimited by '$'
        int 21h                 ; DOS interrupt (Displaying the message)

        mov ah,08H              ; Code to input a character without echoing on screen
        int 21h                 ; DOS interrupt (Inputting a character)

        mov dx,pb               ; Copying the port B address into dx
        in al,dx                ; Inputting the first number from port B

        mov bl,al               ; Copying the input data into bl

        mov dl,0AH              ; Copying ASCII code for newline character
        mov ah,02H              ; Code to display a character
        int 21h                 ; DOS interrupt (Displaying the newline character)

        lea dx,msg2             ; Loading the efffective address of array msg2
        mov ah,09H              ; Code to display an arrya of bytes delimited by '$'
        int 21h                 ; DOS interrupt (Displaying the message)

        mov ah,08H              ; Code to input a character without echoing on screen
        int 21h                 ; DOS interrupt (Inputting a character)

        mov dx,pb               ; Copying the port B address into dx
        in al,dx                ; Taking byte input into al from port addressed in dx

        mul bl                  ; Multiplying value in al by value in bl and storing into ax

        mov dx,pa               ; Copying port A address into dx
        out dx,al               ; Sending the lower 8 bytes of result to port A

        call delay              ; Waiting for acknowledgement of output

        mov al,ah               ; Copying the upper 8 bytes of result into al
        out dx,al               ; Sending the upper 8 bytes of result to port A

        call delay              ; Waiting for acknowledgement of output

        mov ah,4ch              ; Code to terminate a process
        int 21h                 ; DOS interrupt (Terminating the program)
delay proc
        push bx                 ; Storing bx value into stack
        push cx                 ; Storing cx value into stack

        mov cx,0fffH            ; Initializing the outer loop count
loop1:
        mov bx,00ffH            ; Initializing the inner loop count
loop2:
        dec bx                  ; Decrementing number of executions of inner loop
        jnz loop2               ; Jumping to label loop2 if bx!=0
        loop loop1              ; Decrementing cx value and jumping to label loop1 if cx!=0

        pop cx                  ; Restoring cx value from stack
        pop bx                  ; Restoring bx value from stack
        ret
delay endp
end
