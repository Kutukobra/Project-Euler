%include "asmio.asm"

section .data
    hello db "%d", 10
    

section .text
    global _start

_start:
    sub rsp, 0x8
    mov DWORD [rsp + 0x4], 1 ; Iterator
    mov DWORD [rsp + 0x8], 0 ; Accumulator

_accumulateLoop:
    mov eax, DWORD [rsp + 0x4] ; Move iterator to eax
    xor edx, edx ; Clear edx
    mov cx, 0x3 ; Quotient 3
    div cx ; Divide by 3

    test edx, edx ; Test if remainder is 0
    jz _addIterator

    mov eax, DWORD [rsp + 0x4] ; Move iterator to eax
    xor edx, edx ; Clear edx, division in eax:edx
    mov cx, 0x5 ; Quotient 5
    div cx ; Divide by 5

    test edx, edx ; Test if remainder is 0
    jz _addIterator

    jmp _skipAdding

_addIterator:
    mov eax, DWORD [rsp + 0x4]  ; Move iterator to eax
    add DWORD [rsp + 0x8], eax ; Add accumulator by eax
    printUINT rax


_skipAdding:
    inc DWORD [rsp + 0x4]
    cmp DWORD [rsp + 0x4], 100
    jl _accumulateLoop


    mov eax, DWORD [rsp + 0x8]
    printUINT rax

    add rsp, 0x8
_exit:
    mov rax, 0x3C
    mov rdi, 0
    syscall