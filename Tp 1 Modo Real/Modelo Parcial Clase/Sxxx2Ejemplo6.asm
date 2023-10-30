public CONTAR ; libreria
extrn COUNT_SEC; variable

CODE_COUNT segment
	assume cs: CODE_COUNT

CONTAR proc
	cmp al, 'a'; es a?
	je INCREMENTAR_int_a
	cmp al, 'b' ; es b?
	je INCREMENTAR_int_b
	cmp al, 'c' ; es c?
	je INCREMENTAR
	
	mov bl,0 ; reseteo bx
	mov cl,0 ; reseteo cx
	retf 
INCREMENTAR_int_a:
	inc bl ; incremento bx
	retf
INCREMENTAR_int_b:
	cmp cl,1 ; ya paso previamente por a
	inc bl
	retf
INCREMENTAR:
	cmp bl,2
	inc COUNT_SEC
	mov bl,0
	mov cl,0 ; reseteo cx
	retf

CONTAR endp
CODE_COUNT ends

end