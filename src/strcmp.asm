section .text
global strcmp

strcmp:
    test rdi, rdi            ; Vérifie si le pointeur source (rdi) est nul
    jz .done                 ; Si rdi est nul, on termine la comparaison (les deux chaînes sont égales si la source est vide)
    test rsi, rsi            ; Vérifie si le pointeur destination (rsi) est nul
    jz .done                 ; Si rsi est nul, on termine la comparaison (les deux chaînes sont égales si la destination est vide)

.loop:
    mov al, byte [rsi]       ; Charge le caractère courant de la chaîne source (rsi) dans le registre al
    cmp byte [rdi], al       ; Compare ce caractère avec le caractère courant de la chaîne destination (rdi)
    jne .final               ; Si les caractères sont différents, on passe à l'étiquette .final
    test al, al              ; Vérifie si on a atteint la fin de la chaîne source (caractère nul '\0')
    jz .equal                ; Si on a atteint la fin, les chaînes sont égales
    inc rdi                  ; Incrémente le pointeur destination (rdi) pour le prochain caractère
    inc rsi                  ; Incrémente le pointeur source (rsi) pour le prochain caractère
    jmp .loop                ; Continue la boucle pour comparer les caractères suivants

.equal:
    xor eax, eax             ; Si les chaînes sont égales (on a atteint la fin de la chaîne sans différence), retourner 0 (égalité)
    jmp .done                ; Aller à l'étiquette .done pour retourner le résultat

.final:
    movzx eax, byte [rdi]    ; Si les chaînes sont différentes, charger le caractère de la chaîne destination (rdi)
    sub al, byte [rsi]       ; Soustraire le caractère de la chaîne source (rsi) du caractère de la destination (rdi)
    movsx rax, al            ; Signer l'extension de la différence pour retourner un résultat signé (positif ou négatif)

.done:
    ret                      ; Retourne le résultat dans eax : 0 si égales, un nombre positif ou négatif si différentes
