;------------------------------------------------
;               3.5 labwork
;               "strlen"
;------------------------------------------------
.model tiny
.code
;------------------------------------------------
; constants
null            equ 00h
;------------------------------------------------
org 100h
;------------------------------------------------
start:          jmp main

include lib.asm

main:           push offset msg
                call prints

                push offset string
                call strlen

                mov bx, offset string
                add bx, ax
                inc bx
                push bx
                call prints
                .exitprog
;-------------------------------------------------------
;size_t strlen(const char *str);
;calculate length of null-terminated string
;expects:arguments in stack( c order )
;[bp+4] - addres of string
;destroy: ax, bx, di, es
;return: length of string in ax
;-------------------------------------------------------
strlen proc
                push bp
                mov bp, sp

                mov di, [bp+4]

                mov ax, ds
                mov es, ax
                mov bx, di
                mov ax, null

                cld
??cycle:        scasb
                jne ??cycle

                sub di, bx
                mov ax, di
                dec ax

                pop bp
                ret 2
                endp
;-------------------------------------------------------
.data

string             db 'Hello,memchr!', 00h,'right$'
msg                db "Strlen test.Expects: 'right'", 0ah, 0dh, '$'
;-------------------------------------------------------
end start
