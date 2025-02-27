section .text
section .text
    global strchr

strchr:
    test rdi, rdi         ; Vérifier si la chaîne est NULL
    jz .not_found
    test rsi, rsi         ; Vérifier si le caractère est NULL
    jz .not_found
    mov al, sil           ; Charger le caractère recherché

.loop:
    cmp byte [rdi], 0     ; Vérifier la fin de la chaîne
    je .not_found
    cmp byte [rdi], al    ; Comparer avec le caractère recherché
    je .found
    inc rdi               ; Passer au caractère suivant
    jmp .loop

.not_found:
    xor rax, rax          ; Retourner NULL (0)
    ret

.found:
    mov rax, rdi          ; Retourner l'adresse du caractère trouvé
    ret

