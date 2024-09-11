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
#      <Put a description of the supported Overrides here>
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
    CC = arm-none-eabi-gcc 
    LD = arm-none-eabi-ld
    CFLAGS = -mcpu=$(CPU) -march=$(ARCH) --specs=$(SPECS) -mthumb -mfloat-abi=hard -mfpu=fpv4-sp-d16 \
              $(COMMON_FLAGS)
    CPPFLAGS = -M -MF test.d
    PLATFORM_FLAG = -DMSP432
else
    CC = gcc
    LD = ld
    CFLAGS = $(COMMON_FLAGS)
    CPPFLAGS = -M -MF test2.d
    PLATFORM_FLAG = -DHOST
endif

# Compiler and Linker Flags
LDFLAGS = -Wl,-Map=$(TARGET).map 

# File Extensions and Variables
OBJS := $(SOURCES:.c=.o)
ASMS := $(SOURCES:.c=.s)
PPS := $(SOURCES:.c=.i)
MAPS := $(SOURCES:.c=.map)
OUTS := $(TARGET).out

# Rules
%.i : %.c
	$(CC) $(CFLAGS) $(PLATFORM_FLAG) -E -o $@ $<

%.s : %.c
	$(CC) $(CFLAGS) $(PLATFORM_FLAG) -S $< -o $@

%.o : %.c
	$(CC) $(CFLAGS) $(PLATFORM_FLAG) -c $< -o $@

.PHONY: compile-all
compile-all: $(OBJS)
	@echo "Compiling all source files..."
	$(CC) $(CFLAGS) $(PLATFORM_FLAG) -c $(SOURCES)

.PHONY: build
build: $(OUTS)

$(OUTS): $(OBJS)
	$(CC) $(CFLAGS) $(PLATFORM_FLAG) $(LDFLAGS) -o $(OUTS) $(OBJS)
	size $(OUTS)

.PHONY: clean
clean: 
	rm -f *.i *.s *.o *.out *.d *.map
