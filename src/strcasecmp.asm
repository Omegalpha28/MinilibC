section .text
global strcasecmp

strcasecmp:
    xor eax, eax            ; Initialiser eax à 0 (résultat de comparaison)
    xor rcx, rcx            ; Initialiser rcx à 0 (index des chaînes)

.loop:
    mov bl, BYTE [rdi+rcx]  ; Charger un caractère de str1[rcx] dans bl
    mov dl, BYTE [rsi+rcx]  ; Charger un caractère de str2[rcx] dans dl
    cmp bl, 0               ; Vérifier si le caractère de str1 est nul (fin de str1)
    je .done                 ; Si fin de str1, on termine
    cmp dl, 0               ; Vérifier si le caractère de str2 est nul (fin de str2)
    je .done                 ; Si fin de str2, on termine

    sub bl, 'A'             ; Vérifier si le caractère de str1 est une majuscule
    cmp bl, 0               ; Si bl est < 'A', il est déjà minuscule, pas de modification
    jl .upper               ; Si bl est < 'A', passer à l'étape suivante
    add bl, 32              ; Convertir bl en minuscule en ajoutant 32

.upper:
    sub dl, 'A'             ; Vérifier si le caractère de str2 est une majuscule
    cmp dl, 0               ; Si dl est < 'A', il est déjà minuscule, pas de modification
    jl .lower               ; Si dl est < 'A', passer à l'étape suivante
    add dl, 32              ; Convertir dl en minuscule en ajoutant 32

.lower:
    cmp bl, dl              ; Comparer les deux caractères
    jne .diff               ; Si les caractères sont différents, aller à l'étape de différence
    inc rcx                 ; Si les caractères sont égaux, on passe à l'indice suivant
    jmp .loop               ; Recommencer la boucle

.diff:
    movsx eax, bl           ; Déplacer bl dans eax (résultat de la différence)
    movsx ebx, dl           ; Déplacer dl dans ebx
    sub eax, ebx            ; Calculer eax = bl - dl (retourner la différence)

.done:
    ret                     ; Retourner le résultat de la comparaison

