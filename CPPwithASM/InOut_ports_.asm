		.MODEL flat, c

		.CODE

	;void OutB_(U16_t _port, U8_t _value);
	OutB_ PROC _port:WORD, _value:BYTE
		YOURSELF = 0
			Prolog:
		IF YOURSELF
				push ebp                           ; WARNING!!! compiler does it yourself if use PROC
				mov ebp, esp                       ; ebp,esp,edi,esi aren't volatile
		ENDIF
				push edx;

				mov al, _value;
				mov dx, _port;
				out dx, al;
			Epilog :
				pop edx
		IF YOURSELF
				pop ebp
		ENDIF
				ret                             ; eip = *esp, esp-=4;
	OutB_ ENDP

	;void OutSB_(U16_t _port, void* _buf, size_t _count);
	OutSB_ PROC	_port:WORD, _buf:DWORD, _count:DWORD
		YOURSELF = 0
			Prolog:
		IF YOURSELF
				push ebp                           ; WARNING!!! compiler does it yourself when local varables defined
				mov ebp, esp                       ; ebp,esp,edi,esi aren't volatile
		ENDIF
				push ecx;
				push edx;
				push esi;

				mov ecx, _count;
				mov dx, _port;
				mov esi, _buf;
				rep outsw;

			Epilog :
				pop esi;
				pop edx;
				pop ecx;
		IF YOURSELF
				pop ebp
		ENDIF
				ret                             ; eip = *esp, esp-=4;
	OutSB_ ENDP



					END