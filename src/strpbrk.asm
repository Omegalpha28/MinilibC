section .text
global strpbrk

strpbrk:
    cmp rdi, 0           ; Vérifier si s est NULL
    je .null_return
    cmp rsi, 0           ; Vérifier si accept est NULL
    je .null_return

.loop_s:
    mov al, byte [rdi]   ; Charger s[i] dans AL
    test al, al          ; Vérifier si s[i] == '\0'
    jz .null_return      ; Si oui, on retourne NULL

    mov rdx, rsi         ; Pointer sur accept
.loop_accept:
    mov bl, byte [rdx]   ; Charger accept[j] dans BL
    test bl, bl          ; Vérifier si accept[j] == '\0'
    jz .next_s           ; Si on a fini accept, tester le prochain s[i]
    cmp al, bl           ; Comparer s[i] avec accept[j]
    je .found            ; Si égal, on a trouvé
    inc rdx              ; Passer au caractère suivant de accept
    jmp .loop_accept

.next_s:
    inc rdi              ; Passer au caractère suivant de s
    jmp .loop_s          ; Continuer la boucle

.found:
    mov rax, rdi         ; Retourner le pointeur vers s[i]
    ret

.null_return:
    xor rax, rax         ; Retourner NULL
    ret
