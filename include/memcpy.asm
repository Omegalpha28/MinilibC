section .text
global memcpy

memcpy:
    push rbx
    test rdi, rdi         ; Vérifier si le pointeur destination est nul
    jz .done              ; Si nul, retour
    test rsi, rsi         ; Vérifier si le pointeur source est nul
    jz .done
    mov rbx, rdi         ; rbx = dest (pointeur destination)
    mov rcx, rsi         ; rcx = src (pointeur source)
    mov rax, rdx         ; rax = n (taille)

.loop:
    cmp rax, 0           ; Vérifier si n == 0
    je .done             ; Si n == 0, bye bye
    mov dl, byte [rcx]   ; Charger un octet de la source
    mov [rbx], dl        ; Copier l'octet à la destination
    inc rcx              ; Passer à l'adresse suivante de source
    inc rbx              ; Passer à l'adresse suivante de destination
    dec rax
    jmp .loop

.done:
    pop rbx
    mov rax, rdi
    xor rdi, rdi
    xor rsi, rsi         ; Retourner le pointeur de destination
    ret