global main
extern printf

section .data
    vector dw 5,6,11,7,1
    texto0 db "Minimo: %hi",10,0
    texto1 db "Maximo: %hi",10,0
    texto2 db "Promedio: %hi",10,0

section .bss
    minimo resw 1
    maximo resw 1
    promedio resw 1

section .text

main:
    mov rdi, 4
    mov rbx, 2

    mov cx, [vector]
    mov [minimo], cx
    mov [maximo], cx

loop_0:
    mov cx, [vector + rbx]
    cmp [minimo], cx
    jl loop_1
    call nuevo_minimo

loop_1:
    mov cx, [vector + rbx]
    cmp [maximo], cx
    jg loop_2
    call nuevo_maximo

loop_2:
    add rbx, 2
    sub rdi, 1
    cmp rdi, 0
    jz calcular_promedio
    call loop_0

nuevo_minimo:
    mov [minimo], cx
    ret

nuevo_maximo:
    mov [maximo], cx
    ret

calcular_promedio:
    mov rdi, 5
    mov rbx, 0
    mov dx, 0

calcular_promedio_0:
    add dx, [vector + rbx]

    add rbx, 2
    sub rdi, 1
    cmp rdi, 0
    jnz calcular_promedio_0

calcular_promedio_1:
    mov ax, dx
    mov dx, 0
    mov bx, 5
    idiv bx
    mov [promedio], ax

imprimir:
    mov rcx, texto0
    mov rdx, [minimo]
    sub rsp,32
    call printf
    add rsp,32

    mov rcx, texto1
    mov rdx, [maximo]
    sub rsp,32
    call printf
    add rsp,32

    mov rcx, texto2
    mov rdx, [promedio]
    sub rsp,32
    call printf
    add rsp,32

    ret