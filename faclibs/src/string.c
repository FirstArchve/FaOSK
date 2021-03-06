// Filename:  string.c
// Description:  字符串处理函数
// Compiler:  gcc

#include "types.h"
#include "string.h"

//内存拷贝函数
void memcpy(uint8 *dest, const uint8 *src, uint32 len)
{
	for (; len != 0; len--) 
	{
		*dest++ = *src++;
	}
}

//内存赋值函数
void memset(void *dest, uint8 val, uint32 len)
{
	uint8 *dst = (uint8 *)dest;

	for ( ; len != 0; len--) 
	{
		*dst++ = val;
	}
}

//内存清空（全部为0）函数
void bzero(void *dest, uint32 len)
{
	memset(dest, 0, len);
}

int strcmp(const char *str1, const char *str2)
{
    while (*str1 && *str2 && *str1 == *str2) 
	{
        str1++;
        str2++;
    }
    return *str1 - *str2;
}

//字符串拷贝函数
char *strcpy(char *dest, const char *src)
{
	char *tmp = dest;
	while (*src) 
	{
	      *dest++ = *src++;
	}
	*dest = '\0';
	return tmp;
}

//字符串截取函数
char *strcat(char *dest, const char *src)
{
	char *cp = dest;
	while (*cp) 
	{
	      cp++;
	}
	while ((*cp++ = *src++));
	return dest;
}

//获取字符串长度函数
int strlen(const char *src)
{
	int i=0;
    while(src[i]!=0)   i++;
	return i;
}
