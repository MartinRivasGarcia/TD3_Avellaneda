extrn CONTAR:far
public COUNT_SEC
data  segment
MSG0 db 10,10,13,'Programa cuenta de letras a, b y c $'
MSG1 db 10,10,13,'Ingrese letras: $'
MSG2 db 10,10,13,'La cantidad de veces que usted ingreso la secuencia fue : '
COUNT_SEC db '0'
MSG3 db 10,10,13,'Ingrese una tecla para salir $'
data   ends

extradata   segment
extradata   ends

pila segment
     dw 128 DUP(?) 
tope label word
pila ends

codigo segment
       assume ds:data, es:extradata, ss:pila, cs:codigo

INICIO:
    mov ax,data
    mov ds,ax
    mov ax,extradata
    mov es,ax
    mov ax,pila
    mov ss,ax
    mov sp,offset tope

; MI PROGRAMA
	; anuncio de inicio de programa
	mov dx,offset MSG0
	mov ah,09h
	int 21h
	; anuncio "Ingrese secuencia"
	mov dx,offset MSG1
	mov ah,09h
	int 21h
	; preparo las variables para el ciclo
	mov cx,9 ; para controlar el CICLO
	mov bx,0 ; para la cantidad de secuencia de abc

CICLO:	
    mov ah,01h ; espero letra
	int 21h ; Call System
	cmp al,0Dh; es ENTER?
	je FIN
	
	call far ptr CONTAR
	loop CICLO
FIN:

	mov dx,offset MSG2
	mov ah,09h
	int 21h
	
	mov ah,01h
	int 21h
	
	mov ah, 4ch
	int 21h
	
codigo ends
end INICIO
 