        .MODEL flat,c

extern PrImStr:proc
extern PrStr:proc
    
        .DATA

        .CONST
    Msg1 db 'One is glad to be of sirvece',0

    public Msg1

        .CODE

    ; extern "C" void Test1_(void);
    Test1_ PROC

        IF 0            
            CallPrImStr:
                call PrImStr
                Msg3 db 'abcdefghijklmnopqrst',0     ; dont read '/0', the more characters, the better
        ENDIF
            CallPrStr:
                mov esi, offset Msg1
                call PrStr
        
    Test1_ ENDP



    ; extern "C" int CalcResult1_(int a, int b, int c);
    CalcResult1_ PROC
            Prolog:
                push ebp
                mov ebp,esp

                mov eax,[ebp+8]             ;eax = a
                mov ecx,[ebp+12]            ;ecx = b
                mov edx,[ebp+16]            ;edx = c

                add eax,ecx                 ;eax = a + b
                imul eax,edx                ;eax = (a + b) * c
            Epilog:
                pop ebp
                ret
    CalcResult1_ ENDP


                            END