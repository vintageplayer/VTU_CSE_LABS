.model small
.data
        n dw 400
.code
        mov ax,@data
        mov ds,ax
        mov dx,0ed03h
        mov al,80h
        out dx,al
        mov dx,0ed00h
        mov al,88h
        mov cx,n

again:out dx,al
      call delay
      ror al,01
      loop again
      mov cx,n
again1:out dx,al
       call delay
       ror al,01
       loop again1
       mov ah,4ch
       int 21h

       delay proc
       push cx
       push bx
       mov cx,0fffh
loop1:mov bx,0fffh
loop2:dec bx
      jnz loop2
      loop loop1
      pop bx
      pop cx
      ret
      delay endp

      end

