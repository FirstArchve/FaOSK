// Filename:  string.h
// Description:  字符串处理函数
// Compiler:  gcc

#ifndef STRING_H
#define STRING_H

#include "types.h"

//内存拷贝函数
void memcpy(uint8 *dest, const uint8 *src, uint32 len);

//内存赋值函数
void memset(void *dest, uint8 val, uint32 len);

//内存清空（全部为0）函数
void bzero(void *dest, uint32 len);

int strcmp(const char *str1, const char *str2);

//字符串拷贝函数
char *strcpy(char *dest, const char *src);

//字符串截取函数
char *strcat(char *dest, const char *src);

//获取字符串长度函数
int strlen(const char *src);

#endif
