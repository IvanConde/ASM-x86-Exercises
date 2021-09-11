global main
extern gets
extern printf
extern puts
extern sscanf

section .data
    texto1 db "Ingrese su Nombre y Apellido:",0
    texto2 db "Ingrese su padron:",0
    texto3 db "Ingrese su anio de nacimiento:",0
    texto  db "El alumno %s de padron %li tiene %li anios",0
    anioActual dq 2020
    numFormat db "%li",0
    msjError db "Boludazo",0

section .bss
    nombre  resb 30
    padron  resb 7
    anio   resb 5
    npadron  resq 1
    nanio   resq 1

section .text

main:
    ; Obtengo los datos de nombre padron y año de nacimiento.
    mov rcx, texto1
    sub rsp, 32
    call puts
    add rsp, 32

    mov rcx, nombre
    sub rsp, 32
    call gets
    add rsp, 32

    mov rcx, texto2
    sub rsp, 32
    call puts
    add rsp, 32

    mov rcx, padron
    sub rsp, 32
    call gets
    add rsp, 32

    mov rcx, texto3
    sub rsp, 32
    call puts
    add rsp, 32

    mov rcx, anio
    sub rsp, 32
    call gets
    add rsp, 32

    ; Formateo el string padron y anio a numeros enteros %li.
    mov rcx, padron
    mov rdx, numFormat
    mov r8, npadron
    sub rsp, 32
    call sscanf
    add rsp, 32
    cmp rax, 1
    jl error

    mov rcx, anio
    mov rdx, numFormat
    mov r8, nanio
    sub rsp, 32
    call sscanf
    add rsp, 32
    cmp rax, 1
    jl error

    ; Resto al año correspondiente (2020) el año ingresado por el alumno.
    mov rcx, [anioActual]
    mov rdx, [nanio]
    sub rcx, rdx
    mov [anioActual], rcx

    ; Imprimo con printf el texto pedido.
    mov rcx, texto
    mov rdx, nombre
    mov r8, [npadron]
    mov r9, [anioActual]
    sub rsp, 32
    call printf
    add rsp, 32

    ret

error:
    mov rcx, msjError
    sub rsp, 32
    call puts
    add rsp, 32

    ret