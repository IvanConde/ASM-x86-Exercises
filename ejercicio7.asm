global main
extern printf

section .data
	matriz  dw	11,12,13
			dw	21,22,23
			dw	31,32,33
    texto db "La traza es: %hi",0
section .bss

section .text

main:
    mov rax, [matriz]
    add rax, [matriz + 8]
    add rax, [matriz + 16]

    mov rcx, texto
    mov rdx, rax
    sub rsp, 32
    call printf
    add rsp, 32

    ret