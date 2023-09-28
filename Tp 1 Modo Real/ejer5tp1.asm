datos segment
    mens1 db 'Ingrese numeros del 1 al 9:', '$'
    mens2 db 13, 10, 'Usted Ingreso el numero:'
    numero db '0', '$'
    mens3 db 13, 10, 'Usted ingreso cualquier numero!', '$'
    mens4 db 13, 10, 'Usted ha ingresado ', '$', " numeros impares"
    impares db 0 ; Variable para contar números impares
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

    ; Inicializar la variable "impares" a 0
    mov byte ptr [impares], 0

    ; AQUI VA MI PROGRAMA
    MOV CX, 9
CICLO:
    mov dx, offset mens1   ; Envio el mensaje 1
    mov ah, 9
    int 21h

    mov ah, 1             ; Espero que ingrese un determinado numero
    int 21h

    cmp al, 57            ; Hasta numero 9
    ja  salmal

    cmp al, 49            ; Desde numero 1
    jb  salmal

    mov bx, offset numero
    mov [bx], al

    mov dx, offset mens2  ; Envio el mensaje 2
    mov ah, 9
    int 21h

    ; Verificar si el número es impar
    mov al, [bx]
    and al, 1            ; Comprobar el bit menos significativo (si es 1, es impar)
    jnz es_impar

    jmp no_es_impar

es_impar:
    ; Incrementar la variable "impares" si es impar
    inc byte ptr [impares]

no_es_impar:
    LOOP CICLO

    ; Mostrar la cantidad de números impares
    mov dx, offset mens4
    mov ah, 9
    int 21h

    mov al, [impares]     ; Cargar el valor de "impares" en AL
    add al, '0'           ; Convertir el valor en AL a carácter
    mov dl, al
    mov ah, 2             ; Mostrar el carácter en pantalla
    int 21h

    jmp fin

salmal:
    mov dx, offset mens3  ; Envio el mensaje 3
    mov ah, 9
    int 21h

fin:
    mov ah, 4ch
    int 21h

codigo ends
end inicio