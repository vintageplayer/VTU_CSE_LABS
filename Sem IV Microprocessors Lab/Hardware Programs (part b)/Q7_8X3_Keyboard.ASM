.model small
.data
        m1 db "The entered key is : $"
        m2 db "Row number is : $"
        m3 db "Column number is : $"
        row db 0
        col db 0
        arr db "0123456789.+-*/%ACK=MRXY"
        pa equ 9800H
        pb equ 9801H
        pc equ 9802H
        cw equ 9803H
        cwr equ 90H
.code
        mov ax,@data
        mov ds,ax

        mov dx,cw
        mov al,cwr
        out dx,al
again:
        mov dx,pc
        mov al,01H
        out dx,al

        mov dx,pa
        in al,dx

        cmp al,00
        jne first

        mov dx,pc
        mov al,02H
        out dx,al

        mov dx,pa
        in al,dx

        cmp al,00
        jne second

        mov dx,pc
        mov al,04H
        out dx,al

        mov dx,pa
        in al,dx

        cmp al,00
        jne third

        jmp again
first:
        mov row,00H
        jmp next
second:
        mov row,01H
        jmp next
third:
        mov row,02H
next:
        mov al,bl
        mov cx,0008H
        mov bh,00H
shift:
        and al,01H
        cmp al,01H
        je display
        inc bh
        shr bl,01H
        mov al,bl
        loop shift
display:
        mov col,bh

        lea dx,m3
        mov ah,09h
        int 21h

        mov ah,00H
        mov al,row
        mov cl,03H
        shl ax,cl
        add al,col
        mov si,ax

        mov dl,arr[si]
        mov ah,02H
        int 21h

        mov al,0AH
        int 21h

        mov dx,offset m2
        mov ah,09h
        int 21h

        mov dl,row
        add dl,31H
        mov ah,02H
        int 21h

        mov dl,0AH
        int 21h

        mov dx,offset m3
        mov al,09H
        int 21h

        mov dl,col
        add dl,31H
        mov ah,02H
        int 21h

        mov ah,4ch
        int 21h
end
