datos	segment
PRIMERO:	Db 256 DUP (?)
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
	
		MOV AL,255
		MOV CX,256
		MOV BX,OFFSET PRIMERO
CICLO:	MOV [bx],AL
		DEC AL
		INC BX 
		LOOP CICLO

	mov si,offset primero
	mov di,offset segundo
	mov cx,256
	rep
	movsb

SEGUIR:
	mov ah,4ch
	int 21h
codigo	ends
	end inicio
