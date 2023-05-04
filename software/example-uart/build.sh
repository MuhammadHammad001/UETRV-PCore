# !bin/bash

riscv64-unknown-elf-as -c -o build/isr.o src/isr.s -march=rv32im -mabi=ilp32
riscv64-unknown-elf-as -c -o build/startup.o src/startup.s -march=rv32ima -mabi=ilp32

riscv64-unknown-elf-gcc -c -O -o build/uart.o Interfaces/uart.c -march=rv32im -mabi=ilp32
riscv64-unknown-elf-gcc -c -O -o build/plic.o Interfaces/plic.c -march=rv32im -mabi=ilp32
riscv64-unknown-elf-gcc -c -O -o build/main.o src/main.c -march=rv32im -mabi=ilp32

riscv64-unknown-elf-gcc -O -o build/program.elf build/startup.o build/isr.o build/uart.o build/plic.o build/main.o -T linker.ld -nostdlib -march=rv32i -mabi=ilp32

riscv64-unknown-elf-objcopy -O binary --only-section=.data* --only-section=.text* build/program.elf build/main.bin

hexdump build/main.bin > build/main.hex

python3 maketxt.py build/main.bin > build/imem.txt

riscv64-unknown-elf-objdump -S -s build/program.elf > build/program.dump