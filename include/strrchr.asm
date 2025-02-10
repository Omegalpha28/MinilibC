section .text
global strrchr

strrchr:
    push rbx                 ; Sauvegarder rbx
    push rdi                 ; Sauvegarder rdi (adresse de la chaîne s)
    push rsi                 ; Sauvegarder rsi (caractère c)
    mov rax, rdi             ; Copier l'adresse de s dans rax
    mov rdx, rsi             ; Copier c dans rdx (un octet)
    xor rcx, rcx             ; Initialiser rcx à 0, ça va être le compteur
    xor rbx, rbx             ; Initialiser rbx à 0 (aucune adresse trouvée pour le moment)

.loop:
    cmp byte [rax + rcx], dl ; Comparer le caractère actuel avec c
    je .update_last          ; Si égal, mettre à jour le dernier pointeur trouvé

    cmp byte [rax + rcx], 0  ; Vérifier si on atteint la fin de la chaîne
    je .done                 ; Si oui, terminer la boucle

    inc rcx                  ; Passer au caractère suivant
    jmp .loop                ; Reprendre la boucle

.update_last:
    lea rbx, [rax + rcx]      ; Calculer l'adresse et la mettre dans rbx
    inc rcx                   ; Passer au caractère suivant
    jmp .loop                 ; Continuer la boucle

.done:
    mov rax, rbx             ; Retourner l'adresse de la dernière occurrence trouvée
    pop rsi                  ; Restaurer rsi
    pop rdi                  ; Restaurer rdi
    pop rbx                  ; Restaurer rbx
    ret
