		.model flat,c

		.code

PrImStr proc
	Prolog:
		push esi
		push ebx
		mov esi,[esp+08h]			; esi = "old eip"
			
	NxtChar:
		lodsb			; al = *esi++
		test al,al		; EFLAGS = al & al
		jz Epilog		; if(EFLAGS.ZF == 1)goto Done
		
		mov ah,0Eh		; print character in teletype mode
		mov ebx,01h		; page 0, foreground color
		;int 10h			; for BIOS in real mode only
		jmp NxtChar

	Epilog:
		mov eax, esi
		pop ebx
		pop esi
		jmp eax
PrImStr endp

PrStr proc
	Prolog:
		push esi
		push ebx

		mov esi, dword ptr[esp+08h]			; *esi == current ret
		shl esi, 2							; /* *esi == (char*)str == new ret*/
		mov dword ptr[esp+08h], esi			; old ret = new ret
		
	NxtChar:
		lodsb			; al = *esi++
		test al,al		; EFLAGS = al & al
		jz Epilog		; if(EFLAGS.ZF == 1)goto Done
		
		mov ah,0Eh		; print character in teletype mode
		mov ebx,01h		; page 0, foreground color
		;int 10h			; for BIOS in real mode only
		jmp NxtChar

	Epilog:
		pop ebx
		pop esi
		ret
PrStr endp


		end