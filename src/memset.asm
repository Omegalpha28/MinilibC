section .text
global memset
memset:
    xor rcx, rcx   ; On met rcx à 0 (compteur de boucle)
    xor rax, rax   ; On met rax à 0 (dans le cas ou ce n'est pas déja le cas (pas obligatoire imo))

my_loop:
    cmp rcx, rdx   ; On compare le compteur avec la taille à copier (rdx)
    je return      ; Si rcx == rdx, on sort de la boucle, ca veut dire que c'est bien set la mémoire
    mov byte[rdi + rcx], sil  ; On met la valeur de sil dans l'adresse mémoire (rdi + rcx)
    inc rcx        ; On incrémente le compteur
    jmp my_loop    ; On recommence la boucle

return:
    mov rax, rdi ; On retourne le pointeur d'origine (comme memset en C)
    ret          ; C'est le moment de jouer à star rail