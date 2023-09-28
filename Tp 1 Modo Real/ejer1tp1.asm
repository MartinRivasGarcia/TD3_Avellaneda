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
	
		MOV AL,127
		MOV CX,128
		MOV BX,OFFSET PRIMERO
CICLO:	MOV [bx],AL
		DEC AL
		INC BX ;No se si BX lo tengo q decrementar o incrementar
		LOOP CICLO

		MOV AL,255
		MOV CX,256
		MOV BX,OFFSET segundo
CICLO:	MOV [bx],AL
		DEC AL
		INC BX
		LOOP CICLO

SEGUIR:
	mov ah,4ch
	int 21h
codigo	ends
	end inicio
