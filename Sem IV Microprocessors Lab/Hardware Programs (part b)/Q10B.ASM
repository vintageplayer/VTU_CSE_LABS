.model small
.data
        pa equ 9800H
        pb equ 9801H
        pc equ 9802H
        cwr equ 9803H
        cw equ 80H
        values DB 8CH,99H,0A6H,0B2H,0BEH,0C9H,0D3H,0DDH,0E5H,0ECH,0F3H,0F7H
               DB 0FBH,0FDH,0FEH,0FDH,0FBH,0F7H,0F3H,0ECH,0EFH,0DDH,0D3H
               DB 0C9H,0BEH,0B2H,0A6H,99H,8CH,7FH,7FH,7FH,7FH,7FH,7FH,7FH
               DB 7FH,7FH,7FH,7FH,7FH,7FH,7FH,7FH,7FH,7FH,7FH,7FH,7FH,7FH,7FH
               DB 7FH,7FH,7FH,7FH,7FH,7FH,7FH,7FH,7FH
        msg db "Press any key to exit...$"
.code
        mov ax,@data
        mov ds,ax

        lea dx,msg          ; Loading the effective address of array msg
        mov ah,09H          ; Code to display an array of bytes delimited by '$'
        int 21H             ; DOS interrupt (Diplaying the message)

        mov dx,cwr          ; Copying the value of cwr in dx
        mov al,cw           ; Copying the control word in al
        out dx,al           ; Sending data in al at port address in dx
repeat:
        lea si,values       ; Loading the effective value of array values
        mov cx,60           ; Setting the count as 60
next:
        mov dx,pa           ; Copying the address of port A into dx
        mov al,[si]         ; Copying the currently indexed element into al
        out dx,al           ; Sending the data in al to port address in dx
        call check          ; Invoking procedure check
        jnz terminate       ; If a key is pressed, terminating
        call delay          ; Invoking delay procedure
        inc si              ; Indexing the next element
        loop next           ; Repeating to index all elements
        jmp repeat          ; Repeating the complete sine wave
terminate:
        mov ah,4ch          ; Code to terminate a process
        int 21h             ; DOS interrupt (Terminating the program)
check proc
        mov ah,0BH          ; Code to check for an input
        int 21H             ; DOS interrupt (Checking for input status)
        cmp al,00H          ; Checking if no input
        ret
check endp
delay proc
        push bx             ; Storing the value of bx
        push cx             ; Storing the value of cx
        mov cx,0fffH        ; Initialzing outer loop count
loop1:
        mov bx,00ffH        ; Initialzing inner loop count
loop2:
        dec bx              ; Reducing iterator value
        jnz loop2           ; Jumping to label loop2 if value not 0
        loop loop1          ; Reducing cx. Jumping to label loop1 if cx!=0
        pop cx              ; Restoring cx value
        pop bx              ; Restoring bx value
        ret
delay endp
end

