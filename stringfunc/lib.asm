;-------------------------------------------
;               mystdlib
;-------------------------------------------
.exitprog macro

                mov ax, 4c00h
		int 21h

		endm
;-------------------------------------------
; prints string in dos
; expects:
; 1st argument in stack - addres of stirng
; destroy: ah,dx
; return: none
;-------------------------------------------
prints proc
                push bp
                mov bp, sp

                mov dx, [bp+4]
                
                mov ah, 09h
                int 21h

                pop bp
                ret 2
                endp
;-------------------------------------------
