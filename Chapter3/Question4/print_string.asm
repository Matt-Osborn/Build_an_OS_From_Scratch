print_string:
mov ah, 0x0e ; interrupt 10 / ah=0x0e -> BIOS tele-type output
int 0x10     ; print the char in al
ret          ; return