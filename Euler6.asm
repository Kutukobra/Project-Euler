%include "asmio.asm"

section .text
global _start

_start:
    sub rsp, 0xC

    mov DWORD [rsp + 0x4], 0    ; Sum of squares
    mov DWORD [rsp + 0x8], 0    ; Sum 
    mov DWORD [rsp + 0xC], 1    ; Value to be added

_squaredSum:    ; Summing loop

    mov eax, DWORD [rsp + 0xC]
    add DWORD [rsp + 0x8], eax  ; Add value to sum
    
    mov ecx, eax
    printUINT rcx

    mov eax, DWORD [rsp + 0xC]  ; Square value
    mul eax

    add DWORD [rsp + 0x4], eax  ; Add squared value to sum

    inc ecx
    mov DWORD [rsp + 0xC], ecx
    cmp ecx, 100
    jle _squaredSum

    xor rax, rax
    mov eax, DWORD [rsp + 0x8]
    mul eax
    sub eax, DWORd [rsp + 0x4]

    printUINT rax

    add rsp, 0xC

    mov rax, 0x3C
    mov rdi, 0
    syscall