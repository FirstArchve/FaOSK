#!Makefile
# 编译器：GCC，汇编器：nasm，虚拟机：qemu，链接器：ld
# patsubst 处理所有在 C_SOURCES 字列中的字（一列文件名），如果它的 结尾是 '.c'，就用 '.o' 把 '.c' 取代
C_SOURCES = $(shell find . -name "*.c")
C_OBJECTS = $(patsubst %.c, %.o, $(C_SOURCES))
S_SOURCES = $(shell find . -name "*.s")
S_OBJECTS = $(patsubst %.s, %.o, $(S_SOURCES))

CC = gcc
LD = ld
ASM = nasm

C_FLAGS = -c -Wall -m32 -ggdb -gstabs+ -nostdinc -fno-builtin -fno-stack-protector\
	    -I faclibs/*/ -I faclibs/*/*/ -I faclibs/*/*/*/\
		-I kernel/include/device/ -I kernel/include/init/
LD_FLAGS = -T scripts/kernel.ld -m elf_i386 -nostdlib
ASM_FLAGS = -f elf -g -F stabs

all: $(S_OBJECTS) $(C_OBJECTS) link upimg

.c.o:
	@echo 编译代码文件 $< ...
	$(CC) $(C_FLAGS) $< -o $@

.s.o:
	@echo 编译汇编文件 $< ...
	$(ASM) $(ASM_FLAGS) $<

link:
	@echo 链接内核文件...
	$(LD) $(LD_FLAGS) $(S_OBJECTS) $(C_OBJECTS) -o rom/FaOSkernel


.PHONY:run
run:
	qemu-system-i386 -fda floppy.img -boot a
#end

.PHONY:clean
clean:
	$(RM) $(S_OBJECTS) $(C_OBJECTS) rom/FaOSkernel
#end

.PHONY:upimg
upimg:
	mount floppy.img ./mnt/
	cp -r rom/* ./mnt/
	sleep 1
	umount ./mnt/
#end

.PHONY:mntimg
mntimg:
	mount floppy.img ./mnt/
#end

.PHONY:umntimg
umntimg:
	umount ./mnt/
#end

.PHONY:bochs
bochs:
	bochs -f scripts/bochsrc.txt -q
#end

.PHONY:debug
debug:
	qemu -S -s -fda floppy.img -boot a &
	sleep 1
	cgdb -x scripts/gdbinit
#end