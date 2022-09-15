/*#include<stdarg.h>/*Solution Explorer -> alt+enter -> C/C++ -> Precompiled Heders*/

#include<thread>
/*#include<stdint.h>/**/

#define MUTEX_ASM 1
#define MTX_LOCK (~0)
#define MTX_UNLOCK (0)

#if MUTEX_ASM

extern "C" void Lock_(bool* p_var);
extern "C" void Unlock_(bool* p_var);

#else
void Lock_(bool* p_var) {
	__asm {
		mov al, MTX_LOCK
		mov ebx, dword ptr[ebp + 08h]; ebx = var

		CheckMutexValue :
		xchg al, byte ptr[ebx]; al = *var
			cmp al, MTX_LOCK;
		jne Epilog; if (al != 1) goto Epilog

			call _Thrd_yield
			jmp CheckMutexValue

			Epilog :
	}
}

void Unlock_(bool* p_var) {
	__asm {
		mov al, MTX_UNLOCK
		mov ebx, dword ptr[ebp + 08h]; ebx = var
		xchg al, byte ptr[ebx]; ebx = var
	}
}
#endif // MUTEX_ASM

int
AttemptMtx_(
	int argc,
	char* argv[]
) {

	bool var = MTX_UNLOCK;
	Lock_(&var);/**/
	Unlock_(&var);/**/

	return 0;
}