;------------------------------------------------
;               3.3 labwork
;               "memchr"
;------------------------------------------------
.model tiny
.code
;------------------------------------------------
; constants
char            equ 9f6fh
count           equ 5
;------------------------------------------------
org 100h
;------------------------------------------------
start:          jmp main

include lib.asm

main:           push offset buffer
                call prints

                push count
                push char
                push offset buffer
                call memchr

                push ax
                call prints
                .exitprog
;-------------------------------------------------------
;void *memchr(const void *buffer, int ch, size_t count);
;search for char byte in the first count bytes of buffer
;expects:arguments in stack( c order )
;destroy: ax, bx, cx, di, es
;return: ptr on first entry of char(or null) in ax
;-------------------------------------------------------
memchr proc
                push bp
                mov bp, sp

                mov ax, [bp+6]
                mov cx, [bp+8]
                mov di, [bp+4]

                mov bx, ds
                mov es, bx

                cld
                repne scasb

                jne null

                dec di
                mov ax, di
                jmp exit

null:           mov ax, 0

exit:           pop bp
                ret 6
                endp
;-------------------------------------------------------
.data

buffer             db 'Hello,memchr!', 0dh, 0ah, '$'
;-------------------------------------------------------
end start
