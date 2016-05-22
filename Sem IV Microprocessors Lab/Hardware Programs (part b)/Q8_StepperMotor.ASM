.model small
.data
        pa  equ 9800H
        pb  equ 9801H
        pc  equ 9802H
        cwr equ 9803H
        cw  equ   80H
        n   equ   100           ; Number of rotations 
.code
        mov ax,@data
        mov ds,ax

        mov dx,cwr              ; Copying port address of control word register
        mov al,cw               ; Copying control word into al
        out dx,al               ; Sending the control word to the port address specified in dx

        mov cx,n                ; Storing number of rotations into cx
        mov al,88H              ; Storing the initial position of the motor
        mov dx,pa               ; Copying the output port address as port A
again:
        out dx,al               ; Sending the data in al to port addressed in dx

        call delay              ; Causing a delay to acknowledge the change
        ror al,1                ; Shifting bits right for clockwise rotation
        loop again              ; Repeating for the required number of rotations

        mov cx,n                ; Copying the number of rotations into cx
        mov al,11H              ; Setting up the initial position of the motor
again1:
        out dx,al               ; Sending the data in al to port addressed in dx

        call delay              ; Invoking delay procedure inorder to acknowledge change
        rol al,1                ; Rotating bits left by 1 for anti-clockwise rotation
        loop again1             ; Repeating for the required number of rotations

        mov ah,4ch              ; Code to terminate a process successfully
        int 21h                 ; DOS interrupt (Terminating the program)
delay proc
        push cx                 ; Storing cx value into stack
        push bx                 ; Storing bx value into stack

        mov cx,0FFFH            ; Initializing outer loop count
loop1:
        mov bx,00FFH            ; Initializing innner loop count
loop2:
        dec bx                  ; Reducing the inner loop count
        jnz loop2               ; Checking if bx = 0. If not, jumping to label loop2
        loop loop1              ; Reducing outer loop count. If not 0, jumping to label loop1

        pop bx                  ; Restoring bx value from stack
        pop cx                  ; Restoring cx value from stack
        ret
delay endp
end
