SDK_PREFIX ?= arm-none-eabi-
CC = $(SDK_PREFIX)gcc
AS = $(SDK_PREFIX)as
LD = $(SDK_PREFIX)ld
SIZE = $(SDK_PREFIX)size
OBJCOPY = $(SDK_PREFIX)objcopy
QEMU = qemu-system-gnuarmeclipse

BOARD ?= STM32F4-Discovery
MCU = STM32F407VG
TARGET = firmware
CPU_CC = cortex-m4
TCP_ADDR = 1234

SRC = start.S lab2.S
OBJ = start.o lab2.o
LDSCRIPT = lscript.ld

all: $(TARGET).elf

$(TARGET).elf: $(OBJ) $(LDSCRIPT)
	$(CC) $(OBJ) -mcpu=$(CPU_CC) -Wall --specs=nosys.specs -nostdlib -lgcc -T$(LDSCRIPT) -o $@
	$(OBJCOPY) -O binary -F elf32-littlearm $@ $(TARGET).bin
	$(SIZE) $@

%.o: %.S
	$(CC) -x assembler-with-cpp -c -O0 -g3 -mcpu=$(CPU_CC) -Wall $< -o $@

qemu:
	$(QEMU) --verbose --verbose --board $(BOARD) --mcu $(MCU) -d unimp,guest_errors \
	--image $(TARGET).bin --semihosting-config enable=on,target=native -gdb tcp::$(TCP_ADDR) -S

clean:
	rm -f *.o *.elf *.bin

