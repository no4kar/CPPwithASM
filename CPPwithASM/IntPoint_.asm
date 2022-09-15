                    .MODEL  flat, c

;include AsmHeader_.inc                 ;for assemblers header files(name_.inc)
;extern _Thrd_yield:proc                 ;for calling external functions from .cpp files

                    .CODE

;extern "C" void IntPoint_(uint32_t entrPoint);
IntPoint_ PROC      entrPoint:dword

        ;Prolog:
            ;push ebp                           ; WARNING!!! compiler does it yourself
            ;mov ebp, esp                       ; ebp,esp,edi,esi aren't volatile

        Prepaer:
            xor eax, eax                      ; eax ^= eax
            mov eax, dword ptr[entrPoint]       ; eax = dword ptr[ebp+08h]
            shl eax, 1                          ; eax = eax << 1 (JMP is 2 byte wide)
            add eax, offset Switch              ; eax += (void*)Switch
            jmp eax                             ; jmp at address ((void*)Switch + (entrPoint*2))

        Switch:
            jmp One
            jmp Two
            jmp Three
            jmp Four
            jmp Five

        One :
            ;call SomeFunc1
            jmp Epilog
        Two :
            ;call SomeFunc2
            jmp Epilog
        Three :
            ;call SomeFunc3
            jmp Epilog              
        Four :
            ;call SomeFunc4
            jmp Epilog
        Five :
            ;call SomeFunc5
            jmp Epilog

        IF 0
            ;xchg al, byte ptr[ebx]      ; exchange value between al and *((bool*)ebx)
            ;mov ah, 01h
            ;test ah, al
            ;je Epilog       ; if (!(ah & al)) goto Epilog

            ;call _Thrd_yield
            ;jmp CheckMutexValue     ; If the mutex value is not zero, check againe
        ENDIF

        Epilog :
            ;pop ebp
            ret                             ; eip = *esp, esp-=4;

IntPoint_ ENDP


                    END