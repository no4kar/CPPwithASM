        .model flat,c

        .data
        msg db 'Hello, World',13,10,'$'

        .code
;extern "C" int IntegerMulDiv_(int a, int b, int* prod, int* quo, int* rem);

IntegerMulDiv_ proc
    
    ;Function prolog
        push ebp
        mov ebp,esp
        push ebx
    
    ;Make sure the devisior is not zero
        xor eax,eax                 ;set error return code
        mov ecx,[ebp+08h]           ;eac = 'a'([ebp+04h] is a return address)
        mov edx,[ebp+0Ch]           ;edx = 'b'
        or edx,edx
        jz InvalidDivisor           ;jump if 'b' is zero
    
    ;Calculate product, save result
        imul edx,ecx                ;edx = 'b'*'a'
        mov ebx,[ebp+10h]           ;ebx = '*prod'
        mov [ebx],edx               ;save product

    ;Calculate quotient and remainder, save result
        mov eax,ecx                 ;
        cdq                         ;
        idiv dword ptr [ebp+0Ch]    ;

        mov ebx,[ebp+14h]           ;
        mov [ebx],eax               ;save quotient
        mov ebx,[ebp+18h]           ;
        mov [ebx],edx               ;save remainder
        mov eax,1                   ;set success retuen code

    ;Function epilog
    InvalidDivisor:
        pop ebx
        pop ebp
        ret
    
IntegerMulDiv_ endp

end