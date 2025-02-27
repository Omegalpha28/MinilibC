section .text
global memmove

memmove:
    cmp rdx, 0              ; Vérifier si la taille est nulle
    je .done                ; Si oui, on sort de la fonction
    test rsi, rsi           ; Vérifier si la source est nulle
    jz .done                ; Si oui, on sort de la fonction
    test rdi, rdi           ; Vérifier si la destination est nulle
    jz .done                ; Si oui, on sort de la fonction
    cmp rdi, rsi            ; Vérifier si source et destination sont égales
    je .done                ; Si oui, on sort de la fonction
    cmp rdi, rsi            ; Si la destination est avant la source
    ja .forward_copy        ; Copier de l'avant vers l'arrière
    ja .reverse_copy        ; Cas où la source et la destination se chevauchent (de l'arrière vers l'avant)

.forward_copy:
    xor rcx, rcx            ; Initialiser l'index à 0
    jmp .update             ; Aller à l'écriture dans la pile



.update:
    cmp rcx, rdx            ; Est-ce que l'index a atteint la taille ?
    je .read                ; Si oui, on passe à la lecture
    movsx rbx, BYTE [rsi+rcx] ; Charger un octet de la source
    push rbx                ; Pousser cet octet sur la pile
    jmp .add                ; Continuer l'incrémentation

.read:
    dec rcx                 ; Décrémenter l'index
    pop rbx                 ; Récupérer l'octet de la pile
    mov BYTE [rdi+rcx], bl  ; Placer cet octet dans la destination
    cmp rcx, 0              ; Est-ce qu'on a fini ?
    je .done                ; Si oui, terminer
    jmp .read               ; Sinon, répéter la lecture

.add:
    inc rcx                 ; Incrémenter l'index
    jmp .update

.reverse_copy:
    lea rdi, [rdi + rdx - 1] ; Déplacer rdi à la fin de la destination
    lea rsi, [rsi + rdx - 1] ; Déplacer rsi à la fin de la source
    std                     ; Activer la direction inverse
    xor rcx, rcx            ; Initialiser l'index à 0
    jmp .update             ; Aller à l'écriture dans la pile

.done:
    mov rax, rdi            ; Retourner le pointeur de destination
    ret                     ; Adieu bisou je m'envooool!
