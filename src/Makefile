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
#	  <Put a description of the supported targets here>
#
# Platform Overrides:
#	  <Put a description of the supported Overrides here>
#
#------------------------------------------------------------------------------
include sources.mk

# Platform Overrides
PLATFORM ?= DEFAULT 
TARGET = c1m2 

# compiler flags
CFLAGS := -Wall -Werror -g -O0 -std=c99 $(INCLUDES) 
LDFLAGS := -Wl,-Map=$(TARGET).map
# CPPFLAGS

ifeq ($(PLATFORM), MSP432)
	# Architectures Specific Flags for MSP432
	LINKER_FILE = ../msp432p401r.lds
	CPU = cortex-m4
	ARCH = armv7e-m
	SPECS = nosys.specs
	CC = arm-none-eabi-gcc
	LD = arm-none-eabi-ld
	LDFLAGS += -T $(LINKER_FILE)
	CFLAGS += -mthumb -mfloat-abi=hard -mfpu=fpv4-sp-d16
	DEFINEFLAG = -DMSP432
else 
	CC = gcc	
	DEFINEFLAG = -DHOST
endif

# More Declared Variables
OBJS := $(SOURCES:.c=.o)
ASMS := $(SOURCES:.c=.asm)
PPS := $(SOURCES:.c=.i)
MAPS := $(SOURCES:.c=.map)
OUTS := $(TARGET).out

# Rule to generate .i files
%.i: %.c
	@echo "Generating .i file for $<"
	@$(CC) $(DEFINEFLAG) $(CFLAGS) -E -o $@ $<	

# Rule to generate .asm files
%.asm: %.c
	@echo "Generating .asm file for $<"
	@$(CC) $(DEFINEFLAG) $(CFLAGS) -S -o $@ $<


# Rule to generate .asm file for the final executable
$(TARGET).asm: $(TARGET).out
	@echo "Generating .asm file for $(TARGET)"
	@objdump -d $(TARGET).out > $(TARGET).asm

%.o : %.c 
	@echo "genrating .o files withour linking"
	@$(CC) $(DEFINEFLAG) $(CFLAGS) -c $<  -o $@ 

# Phony target for compiling all .c files into .o files
.PHONY: compile-all
compile-all: $(OBJS)
	@echo "Compiling all source files into object files without linking."

# Phony target for building the executable
.PHONY: Build
Build: $(TARGET).out

# Rule to build the executable
$(TARGET).out: $(OBJS)
	@echo "Linking object files into executablet"
	@$(CC) $(DEFINEFLAG) $(CFLAGS) $(LDFLAGS) $(OBJS) -o $(TARGET).out


# Phony target for cleaning up all non-source files
.PHONY: clean
clean:
	@echo "Cleaning up all non-source files ..."
	@rm -f $(OBJS) $(PPS) $(ASMS) $(MAPS) $(OUTS) $(TARGET).asm 








