section .bss
	ch1 resb 4
	ch2 resb 4
	mono2 resb 4
	mono resb 4
	aja resb 1

section .text
	mov ax, 2
	mov [mono], ax

