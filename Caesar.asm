.386
.model flat, stdcall
option casemap:none

include C:\masm32\include\kernel32.inc
include C:\masm32\include\windows.inc
includelib C:\masm32\lib\user32.lib
includelib C:\masm32\lib\kernel32.lib
BSIZE equ 128
.data
buf db BSIZE dup(?)
result db BSIZE dup(?)
stdin dd ?
stdout dd ?
cRead dd ?
cWritten dd ?
.code
start:

invoke GetStdHandle, STD_INPUT_HANDLE
mov stdin, eax
invoke ReadConsole, stdin, ADDR buf, BSIZE, ADDR cRead, NULL

mov esi, offset buf
mov edi, offset result

mov ebx, 0

loop1:
mov bl, [esi]
cmp bl, 13
je endloop
add bl, 1
mov [EDI], bl
inc esi
inc edi
loop loop1

endloop:
invoke GetStdHandle, STD_OUTPUT_HANDLE
mov stdout, eax
invoke WriteConsoleA, stdout, ADDR result, cRead, ADDR cWritten, NULL

invoke ExitProcess, 0

end start