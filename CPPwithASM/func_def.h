#pragma once

#include<thread>
#include<stdint.h>

extern "C" int CalcResult1_(int a, int b, int c);
extern "C" void Test1_(void);
extern "C" int AttemptMtx_(int argc, char* argv[]);
extern "C" void IntPoint_(uint32_t entrPoint);
extern "C" void OutB_(uint16_t port, uint8_t value);/**/

extern "C" void OxO1(int var);
extern "C" void OxO2(int var);