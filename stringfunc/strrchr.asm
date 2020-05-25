;------------------------------------------------
;               3.7 labwork
;               "strrchr"
;------------------------------------------------
.model tiny
.code
;------------------------------------------------
; constants
char            equ 0072h
null            equ 00h
;------------------------------------------------
org 100h
;------------------------------------------------
start:          jmp main

include lib.asm

main:           push offset msg
                call prints

                push char
                push offset string
                call strrchr

                push ax
                call prints
                .exitprog
;-------------------------------------------------------
;char *strrchr(const char *str, int ch);
;search for last entry char byte in the string str
;arguments:     [bp+4] - string addres
;               [bp+6] - char we are looking for
;destroy: ax, bx, cx, di, es
;return: ptr on last entry of char(or null) in ax
;-------------------------------------------------------
strrchr proc
                push bp
                mov bp, sp

                mov bx, ds
                mov es, bx

                mov cx, [bp+6]
                mov di, [bp+4]
                xor ax, ax

                cld
??cycle:        cmp byte ptr es:[di], cl
                je ??found
??continue:     cmp byte ptr es:[di], null
                je ??exit
                inc di
                jmp ??cycle

??found:        mov ax, di
                jmp ??continue

??exit:         pop bp
                ret 4
                endp
;-------------------------------------------------------
.data

string             db 'Hello,strrchr!', 00h,'$'
msg                db "Strrchr test.Expects: 'r!'", 0ah, 0dh, '$'
;-------------------------------------------------------
end start
