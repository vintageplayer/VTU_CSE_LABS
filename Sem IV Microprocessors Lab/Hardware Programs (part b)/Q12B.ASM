.model small
.stack
.data
        msg db "Press any key to exit...$"
        pa  equ 9800H
        pb  equ 9801H
        pc  equ 9802H
        cwr equ 9803H
        cw  equ   82H
.code
        mov ax,@data
        mov ds,ax

        mov dx,cwr              // Copying the port address of control word register
        mov al,cw               // Copying the control word value
        out dx,al               // Sending data in al to port addressed in dx

        lea dx,msg              // Loading the effective address of array msg
        mov ah,09H              // Code to display an array of bytes delimited by '$'
        int 21H                 // DOS interrupt (Displaying the message)
repeat:
        mov al,10H              // Clearing all LEDs except ground floor LEDs
        mov dx,pa               // Storing the output port address
        out dx,al               // Sending data in al to port addressed in dx

        mov dx,pb               // Copying the input port address
        in al,dx                // Inputting data into al from port addressed in dx

        and al,0fH              // Masking the higher 4 bits of input

        cmp al,0dH              // Checking if first floor button is pressed
        je first                // Jumping to label first if a button is pressed

        cmp al,0bH              // Checking if second floor button is pressed
        je second               // Jumping to label second if the button is pressed

        cmp al,07H              // Checking if third floor button is pressed
        je third                // Jumping to label third if button is pressed

        jmp check               // Jumping to label check otherwise

third:
        mov al,0f9H             // Storing the code to glow all LEDs
        call service            // Invoking service procedure
first:
        mov al,0f3H             // Storing the code to glow LEDs upto first floor
        call service            // Invoking service procedure
        jmp check               // Jumping to label check
second:
        mov al,06fH             // Storing the code to glow LEDs upto second floor
        call service            // Invoking service procedure
        jmp check               // Jumping to label check

check:
        mov ah,0BH              // Code to check for a keyboard input
        int 21H                 // DOS interrupt (checking for an input)
        cmp al,00H              // Checking if no keyboard input is given
        jz repeat               // Jumping to label repeat if no input

        mov ah,4ch              // Code to terminate a program
        int 21h                 // DOS interrupt (Terminating the program)
delay proc
        push cx                 // Storing cx value in stack
        push bx                 // Storing bx value in stack

        mov cx,0fffH            // Initializing the outer loop count
loop1:
        mov bx,0ffH             // Initializing the inner loop count
loop2:
        dec bx                  // Iterating the inner loop once
        jnz loop2               // Jumping to label loop2 if inner loop iterations left
        loop loop2              // Decreasing cx by 1. Jumping to label loop1 if cx!=0

        pop bx                  // Restoring bx value from stack
        pop cx                  // Restoring cx value from stack
        ret
delay endp
service proc
        mov bl,al               // Copying the required output into bl
        mov al,0f0H             // Storing the code for no LED glow
        mov dx,pa               // Storing the output port address
up:
        call delay              // Invoking the delay procedure
        inc al                  // Storing code to make the next LED glow
        out dx,al               // Sending the data in al to port addressed in dx
        cmp al,bl               // Checking if all required LEDs glow
        jne up                  // If LEDs remain, jumping to label up

        call delay              // Invoking delay procedure
        call delay              // Invoking delay procedure
        call delay              // Invoking delay procedure

        and al,1fH              // Resetting the floor request buttons

        mov bl,010H             // Storing the code for final lift position
down:
        dec al                  // Cutting off power supply to top-most glowing LED
        out dx,al               // Sending the data in al to port addressed in dx
        call delay              // Invoking delay procedure
        cmp al,bl               // Checking if elevator is at required position
        jnz down                // Jumping to label down if more LEDs are glowing
        ret
service endp
end
