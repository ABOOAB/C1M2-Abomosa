#******************************************************************************
# Copyright (C) 2024 by Abdelrahman Abomosa
#
# Redistribution, modification or use of this software in source or binary
# forms is permitted as long as the files maintain this copyright. Users are 
# permitted to modify this and use it to learn about the field of embedded
# software. Abdelrahman Abomosa and the University of Colorado are not liable for any
# misuse of this material. 
#
#*****************************************************************************

#------------------------------------------------------------------------------
# <Put a Description Here>
#
# Use: make [TARGET] [PLATFORM-OVERRIDES]
#
# Build Targets:
#      <Put a description of the supported targets here>
#
# Platform Overrides:
#      <Put a description of the supported Overrides here
#
#------------------------------------------------------------------------------
include sources.mk

# Platform Overrides
PLATFORM =  
TARGET = c1m2
COMMON_FLAGS = -Wall -Werror -g -O0 -std=c99 
# Architectures Specific Flags
ifeq ($(PLATFORM), msp432)
        LINKER_FILE = ../msp432p401r.lds
        CPU = cortex-m4 
        ARCH = armv7e-m
        SPECS = nosys.specs

else
        CPU = x86_64
        ARCH := $(shell arch)

endif

# Compiler Flags and Defines
ifeq ($(PLATFORM), MSP432)
        CC = arm-none-eabi-gcc 
        LD = arm-none-eabi-ld
        LDFLAGS = -Wl,-Map=$(TARGET).map,-T $(LINKER_FILE)
        CFLAGS = -mcpu=$(CPU) -march=$(ARCH) --specs=$(SPECS) -mthumb -mfloat-abi=hard -mfpu=fpv4-sp-d16 \
                  $(COMMON_FLAGS)
        CPPFLAGS = -M -MF test.d
        PLATFORM_FLAG = -DMSP432

else
        CC = gcc
        LDFLAGS = -Wl,-Map=$(TARGET).map 
        CFLAGS = $(COMMON_FLAGS)
        CPPFLAGS = -M -MF test2.d
        PLATFORM_FLAG = -DHOST
endif

#declared variables for every kind of files
OBJS := $(SOURCES:.c=.o)
ASMS := $(SOURCES:.c=.s)
PPS := $(SOURCES:.c=.i)
MAPS := $(SOURCES:.c=.map)
OUTS := $(SOURCES:.c=.out)


%.i : %.c
        $(CC) $(CFLAGS) $(PLATFORM_FLAG) -E -o $@ $<


%.asm : %.c
        $(CC) $(PLATFORM_FLAG) $(CFLAGS) -S $<
        objdump $(OBJS) -D


%.o : %.c
        $(CC) $(PLATFORM_FLAG) $(CFLAGS) -c $< -o $@


.PHONY: compile-all
compile-all: $(OBJS)
        $(CC) $(PLATFORM_FLAG) $(CFLAGS) -c $(SOURCES)



.PHONY: build
build: $(OUTS)
$(OUTS) : $(SOURCES)
        $(CC) $(PLATFORM_FLAG) $(CFLAGS) $(LDFLAGS) -o $(TARGET).out $^
        size $(TARGET).out

.PHONY: clean
clean: 
        rm -f *.i *.s *.o *.out *.d *.map
        #rm -f $(OBJS) $(PPS) $(MAPS) $(OUTS) $(ASMS)

