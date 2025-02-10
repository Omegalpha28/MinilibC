section .text
global strchr


strchr:
    push rbx             ; Sauvegarder rbx
    push rdi             ; Sauvegarder rdi (qui contient l'adresse de la chaîne)
    push rsi             ; Sauvegarder rsi (qui contient le caractère recherché)
    mov rax, rdi         ; Copier l'adresse de s dans rax (valeur de retour si trouvé)
    mov rdx, rsi         ; Copier c dans rdx (on ne garde que le 1er octet)

.loop:
    cmp byte [rax], dl   ; Comparer le caractère actuel avec c
    je .yeah             ; Si égal, on retourne le pointeur

    cmp byte [rax], 0    ; Vérifier si on atteint la fin de la chaîne
    je .nope             ; Si oui, retourner NULL

    inc rax              ; Passer au caractère suivant
    jmp .loop            ; Boucler

.nope:                   ; le caractère n'est pas trouvé
    mov rax, 0           ; Retourner NULL (0)
    jmp .epilogue        ; Aller à l'épilogue

.yeah:                   ; Si le caractère est trouvé
    jmp .epilogue        ; Aller à l'épilogue

.epilogue:
    pop rsi              ; Restaurer rsi
    pop rdi              ; Restaurer rdi
    pop rbx              ; Restaurer rbx
    ret                  ; Retourner à l'appelant

