#define PRECOMP_HDR 0
#if  PRECOMP_HDR == 1
#include "stdafx.h"
#endif /*  PRECOMP_HDR == 1*/

#include"func_def.h"

#if PRECOMP_HDR == 1
int _tmain(int argc, _TCHAR* argv[])
#else
int main(int argc, char* argv[])
#endif
{
    /*int a = -10;/**/
    /*char msg[] = "One is glad to be of service";/**/
    /*fwrite(msg, sizeof msg[0], sizeof msg / sizeof msg[0], stdout);/**/
    
    OxO1(1);
    OxO2(17);

#define IN_OUT_ASM 0
#if IN_OUT_ASM == 1
#define MICR 0x20
#define MIMR 0x21
#define SICR 0xA0
#define SIMR 0xA1
    OutB_(SIMR, 0x00);
#endif



    system("pause");
    /*OutB_(10,1);/**/

    /*std::this_thread::yield();/**/
    /*printf("%d: %5.2f\n", i, bill *= 1.023f);/**/
    /*int dd = CalcResult1_(a, b, c);
    printf("a: %4d  b: %4d  c: %4d\n", a, b, c);
    printf("d: %4d\n", dd);/**/

    return 0;
}