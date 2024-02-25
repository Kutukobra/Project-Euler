section .data
    printBuff db 0, 10

section .bss
    digitsBuff resb 21

section .text

; Integer printing
; ==============================================
%macro printUINT 1
    mov rax, %1
    call _printUINT
%endmacro

_printUINT:
    push rdi
    push rbx
    push rcx
    push rdx
    push rsi

    mov rbx, 1
    mov rcx, 10
    push 10

_beginPush:
    inc rbx
    mov rdx, 0
    div rcx ; Divide by 10
    add dl, 0x30
    push rdx    ; Push remainder to stack

    test rax, rax
    jnz _beginPush

    mov rdi, digitsBuff
_beginPop:
    pop rax
    mov [rdi], al   ; Store stack into buffer
    inc rdi
    dec rbx
    test rbx, rbx
    jnz _beginPop

    mov rax, 1
    sub rdi, digitsBuff
    mov rdx, rdi
    mov rdi, 1
    mov rsi, digitsBuff
    syscall ; Print the buffer
    pop rsi
    pop rdx
    pop rcx
    pop rbx
    pop rdi
    ret

; String Printing
; ============================================
%macro printString 1
    mov rax, %1
    call _printString
%endmacro

_printString:
    push rax
    mov rbx, 0
_printStringLoop:
    inc rax
    inc rbx
    mov cl, [rax]
    test cl, cl
    jnz _printStringLoop

    mov rax, 1
    mov rdi, 1
    pop rsi
    mov rdx, rbx
    syscall
    ret

