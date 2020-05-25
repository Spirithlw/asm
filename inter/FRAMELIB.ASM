;-------------------------------------------
;      		framelib
;-------------------------------------------
;constants

screen		equ 0b800h
space		equ 1e00h
color		equ 1eh
line_sz 	equ 80
shadow 		equ 6e00h

lef_up_c	equ 1ec9h	;symbols for frame
lef_dw_c	equ 1ec8h
rght_up_c	equ 1ebbh
rght_dw_c	equ 1ebch
horiz		equ 1ecdh
vert		equ 1ebah

x1 		equ 10		; sizes of frame
y1		equ 12
x2		equ 70
y2		equ 20
;-------------------------------------------
.exitprog macro

		mov ax, 4c00h
		int 21h

		endm
;-------------------------------------------
.screen macro
		mov bx, screen
		mov es, bx

		endm
;-------------------------------------------
.sym macro x, y, sym

		mov al, y
		mov cx, x
		mov dx, sym
		call drawsym

		endm
;-------------------------------------------
.spsym macro x, y, lbsym, hbsym

		mov dl, lbsym
		mov dh, hbsym
		mov al, y
		mov cx, x
		call drawsym

		endm
;-------------------------------------------
.horline macro x1, x2, y, sym

		mov dx, sym
		mov bh, x2
		mov bl, x1
		mov al, y
		call drawhorline

		endm
;-------------------------------------------
.vertline macro y1, y2, x, sym

		mov al, y1
		mov bl, y2
		mov bh, x
		mov di, sym
		call drawvertline

 		endm
;-------------------------------------------
;draws frame using videomemory
;expects: symbols and coordinats
;for frame in constants
;destroy: ax, bx, cx, dx, di, si, es
;return: none 
;------------MAIN---------------------------
frame proc
		mov bx, screen
		mov es, bx


		.horline x1+1, x2-1, y1, horiz
		.horline x1+1, x2-1, y2, horiz

		.vertline y1+1, y2-1, x1, vert
		.vertline y1+1, y2-1, x2, vert

		.sym x1, y1, lef_up_c
		.sym x2, y1, rght_up_c
		.sym x1, y2, lef_dw_c
		.sym x2, y2, rght_dw_c

		mov cx, y2-y1-1
		mov dx, space
		mov bl, x1+1
		mov bh, x2-1

fill:		add cl, y1
		mov al, cl
		sub cl, y1
		mov si, cx
		call drawhorline
		mov cx, si
		loop fill

		.horline x1+1, x2, y2+1, shadow
		.vertline y1+1, y2+1, x2+1, shadow

		ret
		endp
;-------------------------------------------
;draws horizontal line
;expects:
;al - row coordinate
;bl - start column coordinate of line
;bh - end column coordinate of line
;dx - symbol(as a word)
;es - addres of videosegment(in paragraphs)
;destroy: ax,cx,di
;return: none
;-------------------------------------------
drawhorline	proc

		mov cx, line_sz
		mul cl		;calculate first elem addr
		xor cx, cx
		mov cl, bl
		add ax, cx
		shl ax, 1

		mov di, ax	;making cycle
		mov ax, dx
		xor cx, cx
		mov cl, bh
		sub cl, bl
		add cx, 1

		cld		;drawing cycle
		rep stosw

		ret
		endp
;-------------------------------------------
;draws vertical line
;expects:
;al - start row coordinate of line
;bl - end row coordinate of line
;bh - column coordinate of line
;di - symbol(as a word)
;es - addres of videosegment(in paragraphs)
;destroy: ax,bx,cx,dx
;return: none
;-------------------------------------------
drawvertline	proc

		xor dx, dx;    	; count of repeats
		mov dl, bl
		sub dl, al
		add dl, 1

		mov cx, line_sz
		mul cl		;calculate first elem
		xor cx, cx
		mov cl, bh
		add ax, cx
		shl ax, 1

		mov bx, ax
		mov cx, dx

??cycle:
		mov word ptr es:[bx], di; drawing
		add bx, line_sz*2
		loop ??cycle

		ret
		endp
;-------------------------------------------
;draws a single symbol
;expects:
;al - row coordinate
;cx - column coordinate
;dx - symbol(as a word)
;es - addres of videosegment(in paragraphs)
;destroy: ax, bx
;return: none
;-------------------------------------------
drawsym		proc

		mov bl, line_sz
		mul bl	;calculate address
		add ax, cx
		shl ax, 1

		mov bx, ax
		mov word ptr es:[bx], dx

		ret
		endp
;-------------------------------------------
