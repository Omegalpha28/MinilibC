section .text
global strstr

strstr:
    test rdi, rdi
    jz .done
    test rsi, rsi
    jz .done

.next_char:
    mov rax, rdi
    mov rbx, rsi

.compare:
    mov al, byte [rax]
    cmp al, byte [rbx]
    jne .not_found
    test al, al
    jz .found
    inc rax
    inc rbx
    jmp .compare

.not_found:
    inc rdi
    cmp byte [rdi], 0
    jnz .next_char

.found:
    mov rax, rdi
    ret

.done:
    xor rax, rax
    ret
