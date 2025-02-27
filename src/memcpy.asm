section .text
global memcpy

memcpy:
    push rbx              ; Sauvegarder le registre rbx pour ne pas l'écraser
    test rdi, rdi         ; Vérifier si le pointeur de destination (rdi) est nul
    jz .done              ; Si le pointeur destination est nul, on termine l'opération
    test rsi, rsi         ; Vérifier si le pointeur source (rsi) est nul
    jz .done              ; Si le pointeur source est nul, on termine l'opération
    mov rbx, rdi          ; Mettre le pointeur de destination dans rbx
    mov rcx, rsi          ; Mettre le pointeur source dans rcx
    mov rax, rdx          ; Mettre la taille (n) dans rax

.loop:
    cmp rax, 0            ; Vérifier si la taille n est égale à 0
    je .done              ; Si n est 0, on a fini, on termine la fonction
    mov dl, byte [rcx]    ; Charger un octet de la source (à l'adresse rcx) dans dl
    mov [rbx], dl         ; Copier cet octet à la destination (à l'adresse rbx)
    inc rcx               ; Passer à l'octet suivant dans la source (augmenter rcx)
    inc rbx               ; Passer à l'octet suivant dans la destination (augmenter rbx)
    dec rax               ; Diminuer la taille (n) de 1
    jmp .loop             ; Revenir au début de la boucle pour copier l'octet suivant

.done:
    pop rbx               ; Restaurer le registre rbx
    mov rax, rdi          ; Mettre le pointeur de destination dans rax (pour le retour)
    xor rdi, rdi          ; Réinitialiser le registre rdi à zéro
    xor rsi, rsi          ; Réinitialiser le registre rsi à zéro
    ret                   ; Bisou mon pointeur s'envoooole
