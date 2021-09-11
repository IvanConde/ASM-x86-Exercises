global main
extern puts

section .data
    texto db "Organizacion del Computador",0

section .bss

section .text
main:
    mov rcx, texto
    sub rsp, 32
    call puts
    add rsp, 32
    ret