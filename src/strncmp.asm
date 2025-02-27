section .text
global strncmp

strncmp:
    ; Vérifier si les arguments sont NULL
    test rdi, rdi            ; Vérifier si le pointeur vers la première chaîne (rdi) est NULL
    jz .done                 ; Si oui, on termine la fonction
    test rsi, rsi            ; Vérifier si le pointeur vers la deuxième chaîne (rsi) est NULL
    jz .done                 ; Si oui, on termine la fonction
    test rdx, rdx            ; Vérifier si la taille (rdx) est 0
    jz .done                 ; Si oui, on termine la fonction

.loop:
    mov al, byte [rsi]       ; Charger le caractère de la deuxième chaîne dans al
    cmp byte [rdi], al       ; Comparer le caractère de la première chaîne avec al
    jne .final               ; Si les caractères ne sont pas égaux, on termine
    test al, al              ; Vérifier si al est NULL (fin de la chaîne)
    jz .equal                ; Si c'est la fin de la chaîne, les chaînes sont égales jusqu'ici
    dec rdx                  ; Réduire la taille restante
    jz .equal                ; Si la taille devient 0, les chaînes sont égales jusqu'à la taille donnée
    inc rdi                  ; Passer au caractère suivant de la première chaîne
    inc rsi                  ; Passer au caractère suivant de la deuxième chaîne
    jmp .loop                ; Revenir au début de la boucle

.equal:
    xor eax, eax             ; Mettre eax à 0 (signifiant que les chaînes sont égales)
    jmp .done                ; Terminer la fonction

.final:
    movzx eax, byte [rdi]    ; Charger le caractère de la première chaîne dans eax
    sub al, byte [rsi]       ; Soustraire le caractère de la deuxième chaîne de al
    movsx rax, al            ; Mettre le résultat de la soustraction dans rax

.done:
    ret                      ; Retourner le résultat
