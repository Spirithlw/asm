;------------------------------------------------
;               3.9 labwork
;               "strstr"
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
                call strstr

                push ax
                call prints
                .exitprog
;=======================================================
;char *strstr(const char *str1, const char *str2)
;finds first entry of str2 in str1
;arguments:     [bp+4] - str1
;               [bp+6] - str2
;destroy: ax, es, si, di, bx
;return: addres of first entry(or null) in ax
;=======================================================
strstr proc
                push bp
                mov bp, sp

                mov ax, ds
                mov es, ax

                mov si, [bp+6]
                mov di, [bp+4]
                mov bx, di

??cycle:        mov ax, es:[di]
                cmp al, null
                je ??notfound
                cmp byte ptr es:[si], al
                je ??firstfnd
??cntn:         inc bx
                mov di, bx
                mov si, [bp+6]
                jmp ??cycle

??firstfnd:     cmp byte ptr es:[si], null
                je ??found
                cmpsb
                je ??firstfnd
                jmp ??cntn

??found:        mov ax, bx
                jmp ??exit

??notfound:     mov ax, 00h

??exit:         pop bp
                ret 4
                endp
;------------------------------------------------
.data

str1            db '1234566', null, '!$'
str2            db '45', null
msg             db "Strstr test.Expects: '4566'", 0ah, 0dh, '$'
;------------------------------------------------
end start
