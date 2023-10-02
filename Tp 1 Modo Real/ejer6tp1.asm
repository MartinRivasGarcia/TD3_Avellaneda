datos segment
    mens1 db 13, 10, 'Ingrese letras:', '$'
    letra db '0', '$'
    mens2 db 13, 10, 'Usted ha ingresado ', '$', " numeros letras"
    letras db 0 ; Variable para contar las lentras
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

    ; Inicializar la variable "letras" a 0
    mov byte ptr [letras], 0

    ; AQUI VA MI PROGRAMA
    MOV CX, 9 ;Esto es para ejecutar el ciclo 9 veces
;CICLO:
no_ingresa_enter:
    mov dx, offset mens1   ; Envio el mensaje 1
    mov ah, 9
    int 21h

    mov ah, 1             ; Espero que ingrese un determinado numero
    int 21h

    ; Verificar si la letra es a, b o c
    cmp al, 99            ; Hasta letra c
    ja  no_es_a_b_c

    cmp al, 97            ; Hasta letra a
    jb  no_es_a_b_c

es_a_b_c:
    ; Incrementar la variable "letras"
    inc byte ptr [letras]

no_es_a_b_c:
    cmp al, 13            ; Comparo con el enter
    ja  no_ingresa_enter       ; Si es mayor o menor al enter
    jb  no_ingresa_enter

 ;   LOOP CICLO

    ; Mostrar la cantidad de números letras
    mov dx, offset mens2
    mov ah, 9
    int 21h

    mov al, [letras]     ; Cargar el valor de "letras" en AL
    add al, '0'           ; Convertir el valor en AL a carácter
    mov dl, al
    mov ah, 2             ; Mostrar el carácter en pantalla
    int 21h

    jmp fin

<<<<<<< HEAD
=======
ContarLetrasABC:
    pop ax               ; Sacar la dirección de letras de la pila a AX
    mov al, ax         ; Cargar el contenido de letras en AL

    mov dl, al           ; Copiar el valor de letras a dl para comparar

    cmp dl, 'a'          ; Comparar con 'a'
    je EsLetraABC        ; Saltar si es 'a'

    cmp dl, 'b'          ; Comparar con 'b'
    je EsLetraABC        ; Saltar si es 'b'

    cmp dl, 'c'          ; Comparar con 'c'
    je EsLetraABC        ; Saltar si es 'c'

NoEsLetraABC:
    jmp FinContarLetras  ; Salir de la subrutina cuando se alcance el límite de 9 letras o después de pulsar Enter

EsLetraABC:
    inc byte ptr [letras]
    jmp FinContarLetras  ; Salir de la subrutina cuando se alcance el límite de 9 letras o después de pulsar Enter

FinContarLetras:
    ; En bx tienes el número de letras a, b, c
    ; Puedes hacer lo que quieras con bx, por ejemplo, mostrarlo o usarlo en tu programa principal

    ret

>>>>>>> 9d971f8454e36bc0759d53b068815893f098add4
fin:
    mov ah, 4ch
    int 21h

codigo ends
end inicio