.model small
.stack
.data
        pa equ 9800H
        pb equ 9801H
        pc equ 9802H
        cwr equ 9803H
        cw equ 80H
        msg db 86H,92H,0C6H,0FFH,0C6H,92H,80H,78H,0F9H,92H,86H,8CH
.code
        mov ax,@data
        mov ds,ax

        mov dx,cwr              ; Copying the port address of control word register
        mov al,cw               ; Copying the control word value
        out dx,al               ; Setting the control word register

        mov ch,00               ; Clearing the upper byte of cx
        mov bl,03H              ; Storing the number of rotations of message
again:
        lea si,msg              ; Loading the effective address of the array FIRE
        mov cl,12               ; Setting the count as 04
next:
        mov al,[si]             ; Copying the current element in al
        call display            ; Invoking the display procedure
        call delay
        inc si                  ; Pointing to the next element
        loop next               ; Decreasing cx by 1. If cx!=0, jumping to label bk1

        dec bl                  ; Reducing the number of rotations left
        jnz again               ; Jumping to label again if rotations are left

        mov ah,4ch              ; Storing the code to terminate the process
        int 21h                 ; DOS interrupt (Terminating the program)
delay proc
        push cx                 ; Storing cx value in stack
        push bx                 ; Storing bx value in stack

        mov cx,0fffH             ; Initializing the count for outer loop
loop1:
        mov bx,00ffH             ; Initializing the count for inner loop
loop2:
        dec bx                  ; Reducing the inner loop count by 1
        jnz loop2               ; If reduced value is not 0, jumping to label loop2
        loop loop1              ; Decreasing cx value by 1. If cx!=0, jumping to label loop1
        pop bx                  ; Resotring bx value
        pop cx                  ; Restoring cx value
        ret
delay endp

display proc
        push ax                 ; Storing ax value into stack
        push cx                 ; Storing cx value into stack

        mov cx,08H              ; Copying the number of bits as count (08)
nextb:
        mov dx,pb               ; Copying port address of port c into dx
        rol al,01H              ; Rotating bits to the left by 1 in al
        out dx,al               ; Sending the data in al to port addressed in dx

        push ax                 ; Storing ax value into stack

        mov dx,pc               ; Copying port c address into dx
        mov al,0ffH             ; Storing a logic 1 value for clock
        out dx,al               ; Sending data in al to port addressed in dx

        mov al,00H              ; Storing a logic 0 value for clock
        out dx,al               ; Sending data in al to port addressed in dx

        pop ax                  ; Restoring value in ax from stack
        loop nextb              ; Decreasing cx value by 1. If cx!=0, jumping to label nextb

        pop cx                  ; Restoring cx value from stack
        pop ax                  ; Restoring ax value from stack
        ret
display endp
end
