global main
extern printf
extern sscanf
extern puts
extern gets

section .data
    textoIngresar   db      "Ingrese un numero: ",0
    numFormat       db      "%li",0  
    texto_1         db      "el vector ordenado es: %li",10,0  
    indice_externo  dq      4 ; lo inicialize con la cantidad de elementos de vector
    

section .bss
    vector      times   4  resq 1
    stringNumeroIngresado  resb 10

section .text

main:
    mov rdi,4
    mov rbx,0 ; se inicializa con 0

loop:
    mov rcx,textoIngresar

    sub rsp,32
    call printf
    add rsp,32
    mov rcx,stringNumeroIngresado
    sub rsp,32
    call gets
    add rsp,32

    mov rcx,stringNumeroIngresado
    mov rdx,numFormat
    lea r8,[vector + rbx]
    sub rsp,32
    call sscanf
    add rsp,32

    add rbx,8
    sub rdi,1

    cmp rdi,0
    jnz loop ;jump when not zero

    call ordenar

    mov rbx,0
    mov rdi,4
    call imprimir

ret

ordenar:
    mov rbx,0 ;INDICE DEL VECTOR

burbujeo:
    mov rdi,[vector + rbx] 
    mov rsi,[vector + rbx + 8]

    cmp rdi,rsi
    jng swap_1; salto si rdi <= rsi --> CF=1
    jmp no_swap

swap_1:
    call swap

no_swap:
    add rbx,8 ; aumento en 8 el INDICE DEL VECTOR
    cmp rbx,16

    jle burbujeo
        
    dec qword[indice_externo]
    cmp qword[indice_externo],0
    jnz ordenar

ret

swap:
    mov rdi,[vector + rbx] ;rbx = 0 al principio 
    mov rsi,[vector + rbx + 8]
    mov [vector + rbx],rsi ; pongo el siguiente en actual
    mov [vector + rbx + 8],rdi
ret

imprimir: 
    mov rcx,texto_1
    mov rdx,[vector + rbx]
    sub rsp,32
    call printf
    add rsp,32

    add rbx,8
    sub rdi,1

    cmp rdi,0
    jnz imprimir ;jump when not zero
ret