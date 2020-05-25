;------------------------------------------------
;               3.1 labwork
;               "memset"
;------------------------------------------------
.model tiny
.code
.386
;------------------------------------------------
; constants
char            equ 9f7fh
count           equ 5
;------------------------------------------------
org 100h
;------------------------------------------------
start:          jmp main

include lib.asm

main:           push offset buf
                call prints

                push count
                push char
                push offset buf
                call memset

                push offset buf
                call prints
                .exitprog
;------------------------------------------------
;void* memset(void *buf, int char, size_t count);
;copies first byte of char into first count
;positions of buffer buf
;expects:arguments in stack( c order )
;destroy: ax, bx, cx, di, es
;return: buf in ax
;------------------------------------------------
memset proc
                push bp
                mov bp, sp

                mov ax, [bp+6]
                mov ah, al
                mov cx, [bp+8]
                mov di, [bp+4]

                mov dl, cl
                and dl, 01h
                shr cx, 1

                mov bx, ds
                mov es, bx
                mov bx, di

                cld
                rep stosw

                mov cl, dl
                rep stosb

                mov ax, bx

                pop bp
                ret 6
                endp
;------------------------------------------------
.data

buf             db 'Hello,memset!', 0dh, 0ah, '$'
;------------------------------------------------
end start
