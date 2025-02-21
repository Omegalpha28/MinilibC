section .text
global strlen

strlen:
    push rbp       ; Sauvegarder l'ancien base pointer (c'est mon prologue c'est le début)
    mov rbp, rsp   ; Définir un nouveau frame pointer
    sub rsp, 16    ; Réserver de l'espace sur la stack (si besoin)
    mov rax, 0     ; Initialise le compteur de longueur à 0 (le fameux "xor rax, rax" elle me fume cette commande)

.loop:
    cmp byte [rdi], 0  ; Vérifie si on atteint le caractère nul '\0'
    je .done           ; Sortir si c'est le cas ("Jump if Equal")
    inc rax            ; Incrémente la longueur
    inc rdi            ; Passe au caractère suivant (banger la commande inc)
    jmp .loop          ; Continue la boucle (récursive ayooooo)

.done:
    add rsp, 16    ; Restore l’espace alloué sur la stack pour l'epilogue
    mov rsp, rbp   ; Restore la stack pour l'epilogue
    pop rbp        ; Restore l'ancien base pointer pour l'epilogue jsp si c'est nécéssaire celui là mais comme ça on ne me fera pas de pb
    ret            ; Retourne la longueur de la chaîne