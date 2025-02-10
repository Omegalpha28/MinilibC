section .text
global memcpy

memcpy:
    ; Arguments (mdr pas besoin de faire des push c'est beau):
    ; rdi = destination (dest)
    ; rsi = source (src)
    ; rdx = size (n)
    push rbx
    mov rbx, rdi         ; rbx = dest (pointeur destination)
    mov rcx, rsi         ; rcx = src (pointeur source)
    mov rax, rdx         ; rax = n (taille)

.loop:
    cmp rax, 0           ; Vérifier si n == 0
    je .done             ; Si n == 0, bye bye
    mov dl, byte [rcx]   ; Charger un octet de la source
    mov [rbx], dl        ; Copier l'octet à la destination
    inc rcx              ; Passer à l'adresse suivante de source
    inc rbx              ; Passer à l'adresse suivante de destination
    dec rax
    jmp .loop

.done:
    pop rbx
    mov rax, rdi         ; Retourner le pointeur de destination
    ret