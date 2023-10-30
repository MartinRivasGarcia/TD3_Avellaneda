public CONTAR_XYZ ; libreria
extrn COUNT_SEC; variable

CODE_COUNT segment
	assume cs: CODE_COUNT

CONTAR_XYZ proc

    ; Verificar si la letra es x, y o z
    cmp al, 90            ; Hasta letra Z
    ja  no_es_x_y_z

    cmp al, 88            ; Hasta letra X
    jb  no_es_x_y_z

es_x_y_z:
    ; Incrementar la variable "letras"
    inc COUNT_SEC

no_es_x_y_z:
	mov bl,0
	mov cl,0 ; reseteo cx
	retf

CONTAR_XYZ endp
CODE_COUNT ends

end
