;
; A simple boot program that demonstrates the stack.
;

mov ah, 0x0e    ; int (interrupt) 10/ah = 0eh -> scrolling teletype BIOS routine.

mov bp, 0x8000  ; Set the base of the stack a little above where BIOS loads our boot sector -
mov sp, bp      ; so it won't overwrite us.

push 'A'        ; Push some characters on the stack for later retreival.
push 'B'        ; Note, these are pushed on as 16-bit values, so the
push 'C'        ; most significant byte will be added by our assembler as 0x00

;pop bx          ; Note, we can only pop 16-bits, 

mov bx, 30

cmp bx, 4
jge if_block ;jumps to if block if bx is greater than or equal to 4

cmp bx, 40
jl else_block 
mov al, [0x7ffa] ; this writes 'C'
int 0x10



if_block:
mov al, [0x7ffe]    ; this writes 'A'
int 0x10        ; print (al)
jmp the_end

else_block:
mov al, [0x7ffc]  ; this writes 'B'
int 0x10          
jmp the_end


the_end:

jmp $

; Padding and magic BIOS number.

times 510-($-$$) db 0
dw 0xaa55