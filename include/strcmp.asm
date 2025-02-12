section .text
global strcmp

strcmp:
    test rdi, rdi
    jz .done
    test rsi, rsi
    jz .done

.loop:
    mov al, byte [rsi]
    cmp byte [rdi], al
    jne .final
    test al, al
    jz .equal
    inc rdi
    inc rsi
    jmp .loop

.equal:
    xor eax, eax
    jmp .done

.final:
    movzx eax, byte [rdi]
    sub al, byte [rsi]
    movsx rax, al

.done:
    ret
