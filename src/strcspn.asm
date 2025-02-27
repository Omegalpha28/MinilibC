section .text
global strcspn

strcspn:
    ; Arguments:
    ; rdi - const char * string
    ; rsi - const char * rejectedCharacters
    test rdi, rdi
    jz .return_zero
    test rsi, rsi
    jz .return_zero       ; Vérifier si l'un des arguments est NULL
    xor rax, rax          ; Initialiser le compteur de longueur

.loop_string:
    mov dl, byte [rdi]    ; Charger s[i] dans DL
    test dl, dl           ; Vérifier si s[i] == '\0'
    jz .end               ; Si oui, on a fini
    mov rbx, rsi          ; Début de la liste des caractères rejetés

.loop_rejected:
    mov cl, byte [rbx]    ; Charger rejected[j] dans CL
    test cl, cl           ; Vérifier si rejected[j] == '\0'
    jz .next_char         ; Si oui, continuer avec le prochain caractère
    cmp dl, cl            ; Comparer s[i] avec rejected[j]
    je .end               ; Si match, on retourne la longueur
    inc rbx               ; Passer au caractère suivant de rejected
    jmp .loop_rejected

.next_char:
    inc rdi               ; Passer au caractère suivant de s
    inc rax               ; Augmenter la longueur
    jmp .loop_string      ; Continuer la boucle

.return_zero:
    xor rax, rax          ; Retourner 0 si NULL
    ret

.end:
    ret
