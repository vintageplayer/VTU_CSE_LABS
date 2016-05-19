.model small
.data
        msg db "Press any key to exit....$"
        pa equ 9800H
        pb equ 9801H
        pc equ 9802H
        cwr equ 9803H
        cw equ 82H
.code
        mov ax,@data
        mov ds,ax

        lea dx,msg
        mov ah,09H
        int 21H

        mov dx,cwr
        mov al,cw
        out dx,al

        mov al,00H
up:
        mov dx,pa
        out dx,al
        call check
        jnz terminate
        call delay
        cmp al,99H
        je down
        add al,01H
        DAA
        jmp up
down:
        mov dx,pa
        out dx,al
        call check
        jnz terminate
        call delay
        cmp al,00H
        je terminate
        sub al,01H
        DAS
        jmp down
terminate:
        mov ah,4ch
        int 21h
delay proc
        push cx
        push bx
        mov cx,0fffH
loop1:
        mov bx,00ffH
loop2:
        dec bx
        jnz loop2
        loop loop1
        pop bx
        pop cx
        ret
delay endp

check proc
        push ax
        mov ah,0BH
        int 21H
        cmp al,00
        pop ax
        ret
check endp
end
