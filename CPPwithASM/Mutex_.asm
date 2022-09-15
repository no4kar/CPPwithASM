                    .model  flat, c

;include AsmHeader_.inc                 ;for assemblers header files(name_.inc)
extern _Thrd_yield:proc                 ;for calling external functions from .cpp files

ABC = 1       ;dont need that "define ABC 1"

                    .code

;extern "C" void Lock_(bool* var);
Lock_ proc

        Prolog:
            push ebp
            mov ebp, esp                       ; ebp,esp,edi,esi aren't volatile

        Prepaer:
            xor al, al                      ; al^=al
            not al                          ; al~=al
            ;setz al                        ; /*not al => al~=al*/ or /*setz al => if(EFLAGS.ZF)al=01h*/
            mov ebx, dword ptr[ebp+08h]     ; (void*)ebx = p_var

        CheckMutexValue :
            mov ah, byte ptr[ebx]           ;  better for cache savings
            test ah, al                     ; ah & al
            jnz Yeild                        ; if (!(ah & al)) goto Yeild
            
            mov ah, al
            xchg ah, byte ptr[ebx]          ; eXCHanGe value between al and *((bool*)ebx), corrupts te cache
            test ah, al
            jz Epilog       ; if (!(ah & al)) goto Epilog

        Yeild:
            call _Thrd_yield        ; yeild the CPU
            jmp CheckMutexValue     ; If the mutex value is not zero, check againe

        Epilog :
            pop ebp
            ret                             ; eip = *esp, esp-=4;

Lock_ endp



;extern "C" void Unlock_(bool* var);
Unlock_ proc

        Prolog:
            push ebp
            mov ebp,esp

        ; Prepaer
            xor eax, eax                ;eax ^= eax
            mov ebx, [ebp+8]            ;ebx = var

        ; Check the mutex value
            xchg al, [ebx]               ; exchange value between al and *var
            call _Thrd_yield        ; maybe another is waiting to enter in critical section

        Epilog :
            pop ebp
            ret

Unlock_ endp



                    end