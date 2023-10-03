datos segment
    mens1 db 13, 10, 'Ingrese numeros del 1 al 9:', '$'
    mens2 db 13, 10, 'Usted ha ingresado ', '$'
    numero db '0', '$'
    teclas_numericas db 0 ; Variable para contar las teclas numéricas que cumplen con la condición
datos ends

extra segment
extra ends

pila segment stack
    dw 128 dup (?)
tope label word
pila ends

codigo segment
    assume ds:datos, es:extra, ss:pila, cs:codigo

inicio:
    mov ax, datos
    mov ds, ax
    mov ax, extra
    mov es, ax
    mov ax, pila
    mov ss, ax
    mov sp, offset tope

    ; Inicializar la variable "teclas_numericas" a 0
    mov byte ptr [teclas_numericas], 0



    ; AQUI VA MI PROGRAMA
    mov cx, 9 ; Establecer el contador a 9 (máximo de teclas)
no_ingresa_enter:
    mov dx, offset mens1   ; Envio el mensaje 1
    mov ah, 9
    int 21h

    mov ah, 1             ; Espero que ingrese un determinado numero
    int 21h

    ;call Sxxx2 ; Llamar a la subrutina para contar teclas numéricas que cumplen la condición
    ;mov al, dl ; Obtener el resultado de la subrutina en AL (número de teclas que cumplen la condición)
    
    cmp al, 54 ; Comparar con '6'
    ja es_valido ; Si es mayor a 6, es válido
    cmp al, 51 ; Comparar con '3'
    ja no_es_valido ; Si es mayor que 3, no es válido

    ; Si llegamos aquí, el número cumple con las condiciones
    ; Incrementar la variable de teclas numéricas válidas
es_valido:
    cmp al, 57 ; Comparar con '9'
    jae no_es_valido ; Si es mayor igual a 9, no es válido
    inc byte ptr [teclas_numericas]

no_es_valido:
    ; El número no cumple con las condiciones, continuar el programa según sea necesario
    cmp al, 13            ; Comparo con el enter
    ja  no_ingresa_enter       ; Si es mayor o menor al enter
    jb  no_ingresa_enter

 ;   LOOP CICLO
    dec byte ptr [teclas_numericas]
    ; Mostrar la cantidad de números letras
    mov dx, offset mens2
    mov ah, 9
    int 21h

    mov al, [teclas_numericas]     ; Cargar el valor de "letras" en AL
    add al, '0'           ; Convertir el valor en AL a carácter
    mov dl, al
    mov ah, 2             ; Mostrar el carácter en pantalla
    int 21h

    jmp fin

fin:
    mov ah, 4ch
    int 21h

codigo ends
end inicio