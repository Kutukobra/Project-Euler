%include "asmio.asm"

section .text
global _start

_start:
    sub rsp, 0x10

    mov DWORD [rsp + 0x4], 0    ;   First value
    mov DWORD [rsp + 0x8], 1    ;   Second Value
    mov DWORD [rsp + 0xC], 0    ;   Temporary
    mov DWORD [rsp + 0x10], 0   ;   Accumulator

_fibonacciLoop:

    mov ecx, DWORD [rsp + 0x8]
    mov edx, DWORD [rsp + 0x4]

    add DWORD [rsp + 0x8], edx
    mov DWORD [rsp + 0x4], ecx

    mov edx, 0x1
    test edx, DWORD [rsp + 0x8]

    jnz _skipAdding

    mov edx, DWORD [rsp + 0x8]
    printUINT rdx
    add DWORD [rsp + 0x10], edx

_skipAdding:

    cmp DWORD [rsp + 0x8], 4000000
    jle _fibonacciLoop

    xor rax, rax
    mov eax, DWORD [rsp + 0x10]
    printUINT rax

    add rsp, 0xC
    
    mov rax, 0x3C
    mov rdi, 0
    syscall