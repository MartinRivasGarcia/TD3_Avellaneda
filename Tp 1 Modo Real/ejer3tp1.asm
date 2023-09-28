datos	segment

mens1	db	'Ingrese un numero del 4 al 9:','$'
mens2	db	13,10,	'Usted Ingreso el numero:'
numero	db	'0','$'
mens3	db	13,10,	'Usted ingreso cualquier numero!','$'

datos	ends

extra	segment
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

	mov dx, offset mens1	;Envio el mensaje 1
	mov ah, 9		
	int 21h	
	
	mov ah, 1		;Espero que ingrese un determinado numero
	int 21h

	cmp al,57 ;Hasta numero 9, compara si es mayor salta a salmal
	ja  salmal

	cmp al,52 ;Hasta numero 4, compara si es menor salta a salmal
	jb  salmal

	mov bx,offset numero	
	mov [bx],al

	mov dx, offset mens2	;Envio el mensaje 2
	mov ah, 9		
	int 21h
	jmp fin
	
salmal:	
	mov dx, offset mens3	;Envio el mensaje 3
	mov ah, 9		
	int 21h
	

fin:	mov ah,4ch
	int 21h

codigo	ends
	end inicio
