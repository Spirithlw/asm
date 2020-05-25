;------------------------------------------------
;               3.8 labwork
;               "strcpy"
;------------------------------------------------
.model tiny
.code
;------------------------------------------------
; constants
null           equ 00h
;------------------------------------------------
org 100h
;------------------------------------------------
start:          jmp main

include lib.asm

main:           push offset msg
                call prints

                push offset str2
                push offset str1
                call strcpy

                push offset str1
                call prints
                .exitprog
;=======================================================
;char *strcpy(char *str1, const char *str2);
;copies string str2 to buffer str1
;arguments:     [bp+4] - addres copy to
;               [bp+6] - addres copy from
;destroy: ax, es, si, di
;return: addres of buffer str1 in ax
;=======================================================
strcpy proc
                push bp
                mov bp, sp

                mov ax, ds
                mov es, ax

                mov si, [bp+6]
                mov di, [bp+4]

                cld
??cycle:        cmp byte ptr es:[si], null
                je ??exit
                movsb
                jmp ??cycle

??exit:         movsb
                mov ax, [bp+4]
                pop bp
                ret 4
                endp
;------------------------------------------------
.data

str1            db 'Hello,strcpy!', 0ah, 0dh, '$'
str2            db '12345', null
msg             db "Strcpy test.Expects: '12345 strcpy!'", 0ah, 0dh, '$'
;------------------------------------------------
end start
