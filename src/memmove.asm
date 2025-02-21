section .text
global memmove

memmove:
    push rbx
    test rdi, rdi         ; Check if the destination pointer is null
    jz .done              ; If null, return
    test rsi, rsi         ; Check if the source pointer is null
    jz .done
    mov rbx, rdi         ; rbx = dest (destination pointer)
    mov rcx, rsi         ; rcx = src (source pointer)
    mov rax, rdx         ; rax = n (size)
    cmp rbx, rcx         ; Compare the destination and source addresses
    je .done             ; If they are equal, return
    cmp rbx, rcx         ; Compare the destination and source addresses
    jb .forward          ; If destination < source, copy forward
    sub rbx, rax         ; Otherwise, adjust the destination backward
    sub rcx, rax         ; Adjust the source backward
    jmp .copy

.forward:
    add rbx, rax         ; Adjust the destination forward
    add rcx, rax         ; Adjust the source forward

.copy:
    cmp rax, 0           ; Check if n == 0
    je .done             ; If n == 0, return
    cmp rbx, rcx         ; Compare the destination and source addresses
    jae .copy_forward    ; If destination >= source, copy forward
    mov dl, byte [rcx+rax-1] ; Load a byte from the source (copy backward)
    mov [rbx+rax-1], dl  ; Copy the byte to the destination
    dec rax              ; Decrement n
    jmp .copy

.copy_forward:
    mov dl, byte [rcx]   ; Load a byte from the source (copy forward)
    mov [rbx], dl        ; Copy the byte to the destination
    inc rcx              ; Move to the next source address
    inc rbx              ; Move to the next destination address
    dec rax              ; Decrement n
    jmp .copy

.done:
    pop rbx
    mov rax, rdi
    xor rdi, rdi
    xor rsi, rsi         ; Return the destination pointer
    ret