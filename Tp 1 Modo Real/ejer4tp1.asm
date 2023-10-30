datos	segment
PRIMERO:	Db 128 DUP (?)
datos	ends

extra	segment
SEGUNDO:	Db 256 DUP (?)
extra	ends

pila    segment  stack
	dw 128 dup (?)
tope    label word
pila	ends

codigo	segment
	assume ds:datos,es:extra,ss:pila,cs:codigo

inicio: mov ax,datos
        mov ds,ax
	mov ax,extra
	mov es,ax
	mov ax,pila
	mov ss,ax
	mov sp,offset tope


; AQUI VA MI PROGRAMA	
    CALL LEER_INT_20

SEGUIR:
	mov ah,4ch
	int 21h

LEER_INT_20:
    MOV si, [20x4 + 2] ;si <- cs
    MOV di, [20x4 ] ;di <- Ip
    RET

codigo	ends
	end inicio

