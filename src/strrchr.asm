section .text
global strrchr

strrchr:
    test rdi, rdi         ; Vérifier si la chaîne est NULL
    jz .not_found
    test rsi, rsi         ; Vérifier si le caractère est NULL
    jz .not_found
    mov al, sil           ; Charger le caractère recherché
    xor rdx, rdx          ; Dernière occurrence trouvée (NULL par défaut)
    mov rcx, rdi          ; Sauvegarder le début de la chaîne

.loop:
    cmp byte [rdi], 0     ; Vérifier la fin de la chaîne
    je .done
    cmp byte [rdi], al    ; Comparer avec le caractère recherché
    jne .next
    mov rdx, rdi          ; Mettre à jour la dernière occurrence trouvée

.next:
    inc rdi               ; Passer au caractère suivant
    jmp .loop

.done:
    mov rax, rdx          ; Retourner l'adresse de la dernière occurrence trouvée
    ret

.not_found:
    xor rax, rax          ; Retourner NULL (0)
    ret
