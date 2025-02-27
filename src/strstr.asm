section .text
global strstr

strstr:
    test rdi, rdi         ; Vérifier si la chaîne source est NULL
    jz .return_null
    test rsi, rsi         ; Vérifier si la sous-chaîne est NULL
    jz .return_null
    cmp byte [rsi], 0     ; Vérifier si la sous-chaîne est vide
    jz .return_rdi        ; Si oui, retourner rdi

.next_char:
    mov rax, rdi          ; Sauvegarder la position actuelle
    mov rbx, rsi          ; Début de la sous-chaîne

.compare:
    mov cl, byte [rax]    ; Charger le caractère actuel de la chaîne principale
    cmp cl, byte [rbx]    ; Comparer avec le caractère correspondant dans la sous-chaîne
    jne .not_found
    test cl, cl           ; Vérifier la fin de la chaîne principale
    jz .found
    inc rax               ; Passer au caractère suivant dans la chaîne principale
    inc rbx               ; Passer au caractère suivant dans la sous-chaîne
    cmp byte [rbx], 0     ; Vérifier la fin de la sous-chaîne
    jnz .compare          ; Continuer la comparaison si ce n'est pas la fin

.found:
    mov rax, rdi          ; Retourner le pointeur vers la première occurrence trouvée
    ret

.not_found:
    inc rdi               ; Passer au caractère suivant dans la chaîne principale
    cmp byte [rdi], 0     ; Vérifier si la fin de la chaîne est atteinte
    jnz .next_char        ; Continuer la recherche

.return_null:
    xor rax, rax          ; Retourner NULL
    ret

.return_rdi:
    mov rax, rdi          ; Retourner rdi si la sous-chaîne est vide
    ret
