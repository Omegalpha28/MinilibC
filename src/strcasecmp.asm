section .data
section .text
global strcasecmp

strcasecmp:
    test rdi, rdi
    jz .done
    test rsi, rsi
    jz .done

.loop:

    mov al, byte [rsi]
    cmp byte [rdi], al
    je .equal
    cmp byte [rdi], al
    je .equal
    sub al, 32
    cmp byte [rdi], al
    je .equal
    jmp .final

.equal:
    test al, al
    jz .done
    inc rdi
    inc rsi
    jmp .loop

.final:
    movzx eax, byte [rdi]  ; Charger l'octet de rdi dans al
    sub al, byte [rsi]      ; Soustraire l'octet de rsi
    movsx rax, al           ; Étendre le résultat signé vers rax
              ; Mettre à jour les flags
    jmp .done               ; Aller à .done avec rax intact


.done:
    ret