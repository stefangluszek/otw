; write
; eax: 4, ebx: fd, ecx: char *, edx: len
; nasm -f elf write_string.asm
; ld -s -o write write_string.o -m elf_i386

BITS 32
global  _start
_start:
    xor eax,eax
    push 0x68732f6e     ;n/sh
    push 0x69622f2f     ;//bi
    push eax
    mov eax,4           ;sys_write
    mov ebx,1           ;fd
    mov ecx,esp         ;pointer to our string
    mov edx,16          ;length
    int 0x80

    mov eax,1
    int 0x80
