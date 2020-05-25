;------------------------------------------------
;               3.2 labwork
;               "memcpy"
;------------------------------------------------
.model tiny
.code
.386
;------------------------------------------------
; constants
count           equ 2
;------------------------------------------------
org 100h
;------------------------------------------------
start:          jmp main

include lib.asm

main:           push offset to
                call prints

                push count
                push offset from
                push offset to
                call memcpy

                push offset to
                call prints
                .exitprog
;=======================================================
;void *memcpy(void *to, const void *from, size_t count);
;copies first count positions from buffer "from"
;to buffer "to"
;expects:arguments in stack( c order )
;destroy: ax, es, si, di, cx
;return: "to" in ax
;=======================================================
memcpy proc
                push bp
                mov bp, sp

                mov si, [bp+6]
                mov ax, [bp+8]
                mov di, [bp+4]

                mov bh, al
                and bh, 00000011b
                shr ax, 2
                mov cx, ax

                mov ax, ds
                mov es, ax
                mov ax, di

                cld
                rep movsd

                mov cl, bh
                rep movsb


                pop bp
                ret 6
                endp
;------------------------------------------------
.data

to             db 'Hello,memcpy!', 0dh, 0ah, '$'
from           db '123456789$'
;------------------------------------------------
end start
