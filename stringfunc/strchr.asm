;------------------------------------------------
;               3.6 labwork
;               "strchr"
;------------------------------------------------
.model tiny
.code
;------------------------------------------------
; constants
char            equ 0073h
null            equ 00h
;------------------------------------------------
org 100h
;------------------------------------------------
start:          jmp main

include lib.asm

main:           push offset msg
                call prints

                push char
                push offset buffer
                call strchr

                push ax
                call prints
                .exitprog
;-------------------------------------------------------
;char *strchr(const char *str, int ch);
;search for first entry of char byte in the string str
;arguments:     [bp+4] - string addres
;               [bp+6] - char we are looking for
;destroy: ax, bx, di, es
;return: ptr on first entry of char(or null) in ax
;-------------------------------------------------------
strchr proc
                push bp
                mov bp, sp

                mov bx, ds
                mov es, bx

                mov ax, [bp+6]
                mov di, [bp+4]

                cld
??cycle:        cmp byte ptr es:[di], al
                je ??found
                cmp byte ptr es:[di], null
                je ??notfound
                inc di
                jmp ??cycle

??found:        mov ax, di
                jmp ??exit

??notfound:     xor ax, ax

??exit:         pop bp
                ret 4
                endp
;-------------------------------------------------------
.data

buffer             db 'Hello,strchr!', 00h,'$'
msg                db "Strchr test.Expects: 'strchr!'", 0ah, 0dh, '$'
;-------------------------------------------------------
end start
