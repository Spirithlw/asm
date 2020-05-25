;------------------------------------------------
;               3.4 labwork
;               "memcmp"
;------------------------------------------------
.model tiny
.code
;------------------------------------------------
; constants
count           equ 4
;------------------------------------------------
org 100h
;------------------------------------------------
start:          jmp main

include lib.asm

main:           push count
                push offset buf2
                push offset buf1
                call memcmp

                mov bx, offset ans
                add bx, 1
                add bx, ax

                push bx
                call prints
                .exitprog
;=======================================================
;int memcmp(const void *buf1, const void *buf2, size_t count);
;compares first count bytes of two buffers
;expects:arguments in stack( c order )
;destroy: ax, es, si, di, cx
;return: result in ax( sgn(buf1-buf2) )
;=======================================================
memcmp proc
                push bp
                mov bp, sp

                mov di, [bp+6]
                mov cx, [bp+8]
                mov si, [bp+4]

                mov ax, ds
                mov es, ax

                cld
                repe cmpsb

                ja more
                jb less

                mov ax, 0
                jmp exit

more:           mov ax, 1
                jmp exit

less:           mov ax, -1

exit:           pop bp
                ret 6
                endp
;------------------------------------------------
.data

buf1            db '113445!$'
buf2            db '123456$'
ans             db '-0+$'
;------------------------------------------------
end start
