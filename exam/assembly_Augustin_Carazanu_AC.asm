; ============================================================
; Variant 23
; Calculate Y based on Z parity:
;   If Z is odd:  Y = 2*X + Z - 54
;   If Z is even: Y = Z/4 + 73 + X
; X, Y, Z are bytes
; ============================================================

section .data                       ; Data segment
    X       db 25                   ; Define byte X = 25
    Z       db 7                    ; Define byte Z = 7
    Y       db 0                    ; Reserve byte for result Y

    msg_odd db 'Z is odd. Y = 2*X + Z - 54', 10  ; Odd branch message
    msg_odd_len equ $ - msg_odd                    ; Length of odd message

    msg_even db 'Z is even. Y = Z/4 + 73 + X', 10 ; Even branch message
    msg_even_len equ $ - msg_even                   ; Length of even message

    msg_res db 'Result Y = '                        ; Result label
    msg_res_len equ $ - msg_res                     ; Length of result label

    newline db 10                                    ; Newline character
    buffer  db '000', 10                             ; Buffer for number output
    buf_len equ 4                                    ; Buffer length with newline

section .text                       ; Code segment
    global _start                   ; Entry point for linker

_start:                             ; Program entry
    mov al, [Z]                     ; Load Z into AL
    test al, 1                      ; Test bit 0 of Z (check odd/even)
    jz even_case                    ; Jump if bit 0 = 0 (Z is even)

odd_case:                           ; Z is odd: Y = 2*X + Z - 54
    ; Print odd message
    mov eax, 4                      ; sys_write syscall number
    mov ebx, 1                      ; File descriptor 1 = stdout
    mov ecx, msg_odd                ; Address of message
    mov edx, msg_odd_len            ; Length of message
    int 0x80                        ; Call kernel

    mov al, [X]                     ; AL = X
    shl al, 1                       ; AL = 2 * X (shift left by 1)
    add al, [Z]                     ; AL = 2*X + Z
    sub al, 54                      ; AL = 2*X + Z - 54
    mov [Y], al                     ; Store result in Y
    jmp display                     ; Jump to display

even_case:                          ; Z is even: Y = Z/4 + 73 + X
    ; Print even message
    mov eax, 4                      ; sys_write syscall number
    mov ebx, 1                      ; File descriptor 1 = stdout
    mov ecx, msg_even               ; Address of message
    mov edx, msg_even_len           ; Length of message
    int 0x80                        ; Call kernel

    mov al, [Z]                     ; AL = Z
    shr al, 1                       ; AL = Z / 2 (shift right once)
    shr al, 1                       ; AL = Z / 4 (shift right again)
    add al, 73                      ; AL = Z/4 + 73
    add al, [X]                     ; AL = Z/4 + 73 + X
    mov [Y], al                     ; Store result in Y

display:                            ; Convert Y to decimal and print
    ; Print result label
    mov eax, 4                      ; sys_write
    mov ebx, 1                      ; stdout
    mov ecx, msg_res                ; Address of label
    mov edx, msg_res_len            ; Length of label
    int 0x80                        ; Call kernel

    ; Convert byte in Y to 3-digit ASCII
    movzx eax, byte [Y]            ; Load Y into EAX (zero-extend)

    mov bl, 100                     ; Divisor = 100
    div bl                          ; AL = Y/100 (hundreds), AH = remainder
    add al, '0'                     ; Convert hundreds to ASCII
    mov [buffer], al                ; Store hundreds digit in buffer

    movzx eax, ah                   ; Move remainder to EAX (zero-extend)
    mov bl, 10                      ; Divisor = 10
    div bl                          ; AL = remainder/10 (tens), AH = ones
    add al, '0'                     ; Convert tens to ASCII
    mov [buffer+1], al              ; Store tens digit in buffer
    add ah, '0'                     ; Convert ones to ASCII
    mov [buffer+2], ah              ; Store ones digit in buffer

    ; Print the number
    mov eax, 4                      ; sys_write
    mov ebx, 1                      ; stdout
    mov ecx, buffer                 ; Address of number buffer
    mov edx, buf_len                ; Length (3 digits + newline)
    int 0x80                        ; Call kernel

    ; Exit program
    mov eax, 1                      ; sys_exit syscall number
    xor ebx, ebx                    ; Exit code 0
    int 0x80                        ; Call kernel