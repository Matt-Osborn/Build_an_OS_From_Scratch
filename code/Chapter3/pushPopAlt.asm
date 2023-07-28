;
; A simple boot program that demonstrates the stack.
;

mov ah, 0x0e    ; int (interrupt) 10/ah = 0eh -> scrolling teletype BIOS routine.

mov bp, 0x8000  ; Set the base of the stack a little above where BIOS loads our boot sector -
mov sp, bp      ; so it won't overwrite us.

push 'A'        ; Push some characters on the stack for later retreival.
push 'B'        ; Note, these are pushed on as 16-bit values, so the
push 'C'        ; most significant byte will be added by our assembler as 0x00

pop bx          ; Note, we can only pop 16-bits, 
mov al, bl      ; so pop to bx, then copy bl to al
int 0x10        ; print (al)

pop bx          ; Pop the next value
mov al, bl
int 0x10        ; print (al)

mov al, [0x7fff]  ; To prove our stack grows downwards from bp,
                  ; fetch the char at 0x8000 - 0x2 (i.e 16-bits)

int 0x10          ; print(al)

jmp $

; Padding and magic BIOS number.

times 510-($-$$) db 0
dw 0xaa55