datos segment
    mens1 db 13, 10, 'Ingrese numeros del 1 al 9:', '$'
    valores db 10 dup (?)  ; Arreglo para almacenar los valores ingresados
    cantidad db ?          ; Variable para almacenar la cantidad de valores ingresados
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

    ; Inicializar la variable "cantidad" a 0
    mov byte ptr [cantidad], 0

    ; AQUI VA MI PROGRAMA

    ; Llamar a la subrutina para contar y ordenar los valores
    call ContarYOrdenarValores

    ; Mostrar la cantidad de valores ingresados
    mov ah, 2           ; Función para mostrar carácter
    mov dl, [cantidad]  ; Cargar la cantidad en dl
    add dl, '0'         ; Convertir a carácter
    int 21h             ; Mostrar la cantidad

    ; Mostrar los valores ordenados
    mov si, offset valores  ; Cargar la dirección del arreglo en si
MostrarValores:
    lodsb                ; Cargar el siguiente byte de valores en al
    test al, al          ; Verificar si es el final del arreglo (0)
    jz FinMostrar        ; Si es 0, terminar
    mov ah, 2            ; Función para mostrar carácter
    mov dl, al           ; Cargar el valor en dl
    int 21h              ; Mostrar el valor
    jmp MostrarValores   ; Repetir para el siguiente valor

FinMostrar:
    jmp fin

ContarYOrdenarValores:
    mov cx, 10           ; Establecer el contador a 10 (máximo de valores)
    mov si, offset valores  ; Cargar la dirección del arreglo en si
    xor di, di           ; Inicializar el índice del segundo bucle a 0

    ; Leer valores y contar la cantidad de valores ingresados
    LeerValores:
        mov dx, offset mens1   ; Envio el mensaje 1
        mov ah, 9
        int 21h

        mov ah, 1         ; Función para leer un carácter
        int 21h           ; Leer un carácter desde el teclado
        cmp al, 0Dh       ; Verificar si es Enter (0Dh)
        je FinLeerValores ; Si es Enter, terminar
        stosb             ; Almacenar el valor en el arreglo
        inc byte ptr [cantidad]  ; Incrementar la cantidad de valores ingresados
        loop LeerValores  ; Repetir hasta leer todos los valores

    FinLeerValores:

    ; Ordenar los valores de menor a mayor usando el algoritmo de burbujeo
    movzx cx, byte ptr [cantidad] ; Cargar el valor de cantidad en cx y hacer una extensión de cero
    dec cx               ; Decrementar cx para el último índice del arreglo
    cmp cx, 0            ; Verificar si hay al menos dos valores para comparar
    jbe FinOrdenar       ; Si no hay, terminar

BucleExterno:
    mov di, 0            ; Inicializar el índice del bucle interno a 0
BucleInterno:
    mov al, [si]        ; Cargar el valor actual en al
    mov ah, [si + 1]    ; Cargar el siguiente valor en ah
    cmp al, ah          ; Comparar los valores
    jbe NoIntercambiar  ; Si al es menor o igual que ah, no intercambiar
    ; Intercambiar los valores
    xchg al, ah
    mov [si], al
    mov [si + 1], ah
NoIntercambiar:
    inc di              ; Incrementar el índice del bucle interno
    cmp di, cx          ; Verificar si hemos llegado al último índice del bucle interno
    jb BucleInterno     ; Si no, repetir el bucle interno
    loop BucleExterno   ; Repetir el bucle externo

FinOrdenar:

    ret
fin:
    mov ah, 4ch
    int 21h

codigo ends
end inicio