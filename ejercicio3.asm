global main
extern gets
extern puts
extern sscanf
extern printf

section .data
    texto1 db "Ingrese X:",0
    texto2 db "Ingrese Y:",0
    numFormat db "%li",0
    msjError db "Boludazo",0
    msjFinal db "El resultado es: %li",0

section .bss
    numX  resb 10
    numY   resb 10
    nnumX  resq 1
    nnumY   resq 1
    resultado   resq 1

section .text

main:
    ; Obtengo los datos de nombre numX y año de nacimiento.
    mov rcx, texto1
    sub rsp, 32
    call puts
    add rsp, 32

    mov rcx, numX
    sub rsp, 32
    call gets
    add rsp, 32

    mov rcx, texto2
    sub rsp, 32
    call puts
    add rsp, 32

    mov rcx, numY
    sub rsp, 32
    call gets
    add rsp, 32

    ; Formateo el string numX y numY a numeros enteros %li.
    mov rcx, numX
    mov rdx, numFormat
    mov r8, nnumX
    sub rsp, 32
    call sscanf
    add rsp, 32
    cmp rax, 1
    jl error

    mov rcx, numY
    mov rdx, numFormat
    mov r8, nnumY
    sub rsp, 32
    call sscanf
    add rsp, 32
    cmp rax, 1
    jl error

; RCX CONTADOR, RAX ACUM
    mov rcx, [nnumY]
    mov rax, 1

floop:
    imul rax, qword[nnumX]
    dec rcx
    cmp rcx, 0
    jg floop

    mov [resultado], rax

    ; Imprimo el resultado
    mov rcx, msjFinal
    mov rdx, [resultado]
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