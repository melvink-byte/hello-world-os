all: os-image

bootloader.bin: bootloader.asm
	nasm -f bin bootloader.asm -o bootloader.bin

kernel.o: kernel.c
	gcc -m32 -ffreestanding -c kernel.c -o kernel.o

kernel.bin: kernel.o linker.ld
	ld -m elf_i386 -T linker.ld -o kernel.bin kernel.o

os-image: bootloader.bin kernel.bin
	cat bootloader.bin kernel.bin > os-image.bin

run: os-image
	qemu-system-i386 -fda os-image.bin
