global main
extern puts

section .data
    dias db "DOLUMAMIJUVISA"
    dia dw "SA",0
    texto1 db "El dia es valido",0
    texto2 db "El dia es invalido",0
    
section .bss
    inputValido resb 1
    contador resq 1

section .text

main:
    mov	rbx,0						;Utilizo rbx como puntero al vector dias
	mov	rcx,7						;7 días por semana
    call validar_dia
	cmp byte[inputValido],'N'
    je print_invalido
    call print_valido
    ret

validar_dia:
	mov	byte[inputValido],'N'

	mov	qword[contador],rcx			;Resguardo el rcx en [contador] porque se va usar para cmpsb

    mov	rcx,2
	mov	rsi,dia
	lea rdi,[dias + rbx]
	repe cmpsb

    mov	rcx,qword[contador]			;Recupero el rcx para el loop

	je valido					;Si es valido el dia listo salgo
	add rbx,2						;Avanzo en el vector dias
	loop validar_dia

	jmp	invalido

valido:
	mov	byte[inputValido],'S'

invalido:
    ret

print_valido:
	mov		rcx, texto1
	sub		rsp, 32
	call	puts
	add		rsp, 32
    ret

print_invalido:
	mov		rcx, texto2	
	sub		rsp, 32
	call	puts
	add		rsp, 32
    ret