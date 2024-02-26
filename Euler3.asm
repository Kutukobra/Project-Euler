%include "asmio.asm"

section .text
global _start:

_start:
	sub rsp, 0x10

	;mov QWORD [rsp + 0x8], 600851475143
	mov rcx, 600851475143
	
	mov rdi, rcx
_testLoop:	
	dec rcx
	printUINT rcx
	mov rax, rdi
	mov edx, edi
	div rcx

	test edx, edx
	jnz _testLoop
	
	printUINT rcx

	mov rax, 0x3C
	mov rdi, 0
	syscall
	
