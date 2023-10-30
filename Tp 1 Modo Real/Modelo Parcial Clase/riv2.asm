extrn CONTAR_XYZ:far
public COUNT_SEC
data  segment
MSG1 db 10,10,13,'Ingrese letras: $'
MSG2 db 10,10,13,'La cantidad de veces que se ingresaron X, Y o Z fueron : '
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
	; anuncio "Ingrese secuencia"
	mov dx,offset MSG1
	mov ah,09h
	int 21h
	; preparo las variables para el ciclo
	mov cx,9 ; para controlar el CICLO
	mov bx,0 ; para la cantidad que se repite el ciclo

CICLO:	
    mov ah,01h ; espero letra
	int 21h ; Call System
	cmp al,13; es ENTER?
	je FIN
	
	call far ptr CONTAR_XYZ

	mov dx,offset MSG1
	mov ah,09h
	int 21h
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
 