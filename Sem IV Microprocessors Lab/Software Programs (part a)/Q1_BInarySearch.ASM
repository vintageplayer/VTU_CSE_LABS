.model small

.data
		list dw 1234H,2345H,3456H,4567H,5678H ; Array containing all the values
		len dw ($-list)/2 					  ; Calcualting the number of bytes and dividing by 2
		m1 db "Element not found!!$
		m2 db "Element found!!$"
		res db "Position : $"
		key dw 2445H 						  ; Element to search for

.code
		mov ax,@data
		mov ds,ax

		mov dx,len 							; Storing the lenght of array
		dec dx 								; Reducing it by one to point to the last element
		mov cx,key 							; Storing the element to search
		mov bx,00 							; Storing the index of first element

again:
		mov si,bx 							; copying the lowest element to be compared with
		add si,si 							; Adjusting index for double byte size
		cmp cx,list[si]						; Comparing key with lowest element
		jb fail 							; If key is lower, jumping to fail

		mov ax,bx 							; Storing lower index in ax
		add ax,dx 							; Adding the upper element index to lower element index
		shr ax,01 							; Shifting bits right by 1 (dividing sum by 2)
		mov si,ax							; Storing the index in si
		add si,si 							; Adjusting index for double byte size
		cmp cx,list[si] 					; Compare the search element with the current mid
		jae big 							; Jumping to bug label if key is bigger or equal to mid

		dec ax 								; Reducing index by 1
		mov dx,ax							; Storing mid-1 as the new upper index
		jmp again 							; Repeating the search

big:
		je success 							; If key is equal to mid element, jumping to success label

		inc ax 								; Incementing mid by one
		mov bx,ax							; Storing mid+1 as the new lower index
		jmp again 							; repeating the search

success:
		mov cl,al 							; Storing the index to the element
		lea dx,m2 							; Loading the success message address in dx
		mov ah,09h							; Code to print an array 
		int 21h 							; DOS interrupt (displaying the message)

		mov dl,0AH 							; ASCII code for carriage-return (end of line)
		mov ah,02h 							; Code to print one character
		int 21h 							; DOS interrupt (printing a character)

		mov dx,offset res 					; Loading the address of res array in dx
		mov ah,09h 							; Code to print an array of bytes delimited by '$' 
		int 21h 							; DOS interrupt (displaying the message)

		mov dl,cl 							; Copying the position of the element in dl
		add dl,01h 							; Incrementing to start indexing from 1 instead of 0
		add dl,30H							; Storing the ASCII code of the digit to be printed
		mov ah,02h 							; Code to  print a character
		int 21h 							; DOS interrupt (printing the characer)
		jmp terminate

fail:
		mov dx,offset m1 					; Loading the message address
		mov ah,09h 							; Code to print an array
		int 21h								; DOS interrupt (printing the message)

terminate:
		mov ah,4ch 							; Code to terminate the process
		int 21h 							; DOS interrupt (terminating the process)
end