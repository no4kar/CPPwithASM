========================================================================
    CONSOLE APPLICATION : Example1 Project Overview
========================================================================

AppWizard has created this Example1 application for you.

This file contains a summary of what you will find in each of the files that
make up your Example1 application.


Example1.vcxproj
    This is the main project file for VC++ projects generated using an Application Wizard.
    It contains information about the version of Visual C++ that generated the file, and
    information about the platforms, configurations, and project features selected with the
    Application Wizard.

Example1.vcxproj.filters
    This is the filters file for VC++ projects generated using an Application Wizard. 
    It contains information about the association between the files in your project 
    and the filters. This association is used in the IDE to show grouping of files with
    similar extensions under a specific node (for e.g. ".cpp" files are associated with the
    "Source Files" filter).

Example1.cpp
    This is the main application source file.

/////////////////////////////////////////////////////////////////////////////
Other standard files:

StdAfx.h, StdAfx.cpp
    These files are used to build a precompiled header (PCH) file
    named Example1.pch and a precompiled types file named StdAfx.obj.

/////////////////////////////////////////////////////////////////////////////
Other notes:

AppWizard uses "TODO:" comments to indicate parts of the source code you
should add to or customize.

/////////////////////////////////////////////////////////////////////////////


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

