section .text
global memset

memset:
    ; rdi = destination (s)
    ; rsi = value (c)
    ; rdx = size (n)
    push rbx
    test rdi, rdi         ; Vérifier si le pointeur destination est nul
    jz .done              ; Si nul, retour
    test rsi, rsi         ; Vérifier si le pointeur source est nul
    jz .done
    mov rbx, rdi         ; rbx = s (pointeur vers le buffer)
    mov al, sil          ; Charger la valeur c (sil) dans al
    mov rcx, rdx         ; rcx = n (taille)
    test rbx, rbx        ; Vérifier si le pointeur s est valide
    jz .done             ; Si rbx == 0, jme casse

.loop:
    cmp rcx, 0           ; Vérifier si n == 0
    je .done             ; Si n == 0, finir
    mov [rbx], al        ; Remplir l'adresse de s avec la valeur c
    inc rbx              ; Passer à l'adresse suivante
    dec rcx              ; Décrémenter n
    jmp .loop            ; Répéter la boucle

.done:
    xor rcx, rcx         ; rcx = 0 (NULL)
    pop rbx
    xor rdi, rdi
    xor rsi, rsi
    ret