.model small
.stack
.data
        pa equ 9800H
        pb equ 9801H
        pc equ 9802H
        cwr equ 9803H
        cw equ 80H
        FIRE db 86H,88H,0F9H,8EH
        HELP db 8CH,0C7H,86H,89H
.code
        mov ax,@data
        mov ds,ax

        mov dx,cwr              ; Copying the port address of control word register
        mov al,cw               ; Copying the control word value
        out dx,al               ; Setting the control word register
 
        lea si,FIRE             ; Loading the effective address of the array FIRE
        mov cl,04H              ; Setting the count as 04
bk1:
        mov al,[si]             ; Copying the current element in al
        call display            ; Invoking the display procedure
        inc si                  ; Pointing to the next element
        loop bk1                ; Decreasing cx by 1. If cx!=0, jumping to label bk1

        call delay              ; Invoking delay procedure to acknowledge the change

        mov al,0ffH             ; Code to clear all the segments of a 7 segment display
        mov cl,04H              ; Storing the number of 7-segment displays
bk2:
        call display            ; Invoking the display function
        loop bk2                ; Decreasing cx by 1. If cx!=0 jumping back to label bk2
        call delay              ; Inovking delay procedure to acknowledge the change

        lea si,HELP             ; Loading the effective address of the array HELP
        mov cl,04H              ; Storing the count as 04
bk3:
        mov al,[si]             ; Copying the current element into al
        call display            ; Invoking the display procedure
        inc si                  ; Pointing to the next byte
        loop bk3                ; Reducing cx  value by 1. If cx!=0 jumping to label bk3

        mov al,0ffH             ; Copying the value to clear all the 7-segments of display
        mov cl,04H              ; Copying the count of number of displays
bk4:
        call display            ; Invoking the display procedure
        loop bk4                ; Reducing cx by 1. If cx!=0, jumping to label bk4

        call delay              ; Invoking delay procedure to acknowledge the change

        mov ah,4ch              ; Storing the code to terminate the process
        int 21h                 ; DOS interrupt (Terminating the program)
delay proc
        push cx                 ; Storing cx value in stack
        push bx                 ; Storing bx value in stack

        mov cx,0fffH            ; Initializing the count for outer loop
loop1:
        mov bx,0fffH            ; Initializing the count for inner loop
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
next:
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
        loop next               ; Decreasing cx value by 1. If cx!=0, jumping to label next

        pop cx                  ; Restoring cx value from stack
        pop ax                  ; Restoring ax value from stack
        ret
display endp
end
