;------------------------------------------------
;               4 labwork
;               "intercept int 09"
;------------------------------------------------
.model tiny
.code
.386
;------------------------------------------------
;------------------------------------------------
org 100h
;------------------------------------------------
start:          jmp main
outstr          db '0123456789ABCDEF'
include         framelib.asm
;------------------------------------------------
;new function that handless 9'th intercept
;after pressing the key, draws frame and shows
;scan-code of that key and then goes to
;default handler
;------------------------------------------------
new09 proc
                push ax bx cx dx di si es

                call frame

                in al, 60h
                mov si, ax
                call byte_outH

                pop es si di dx cx bx ax
                db 0eah
old09           db 4 dup ('0')

                endp
;------------------------------------------------
main:           mov si, 9*4
                xor ax, ax
                mov ds, ax

                mov di, offset old09
                mov ax, cs
                mov es, ax

                movsd

                mov bx, 9*4

                cli
                mov ax, offset new09
                mov [bx], ax
                mov ax, es
                mov [bx+2], ax
                sti

                mov dx, offset fend
                shr dx, 4
                inc dx
                mov ax, 3100h
                int 21h
;------------------------------------------------
;prints low byte from register in hex form using videomemory
;expects:
;si - register with byte
;destroy: ax, bx, cl, dx, si
;return:none
;------------------------------------------------
byte_outH proc

                mov dx, si
                shr dl, 4
                mov bx, offset outstr
                add bl, dl
                mov byte ptr cl, cs:[bx]

                .screen
                .spsym 10, 5, cl, 1eh

                mov dx, si
                and dl, 00001111b
                mov bx, offset outstr
                add bl, dl
                mov byte ptr cl, cs:[bx]

                .spsym 11, 5, cl, 1eh

                ret
                endp
;------------------------------------------------
fend:
end start
