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
# make file support two platforms (the host machine and MSP432)
#
# Use: make [TARGET] [PLATFORM-OVERRIDES]
#
# Build Targets:
#  
#	<FILE>.o - Builds <FILE>.o object file
#	<FILE>.asm - Builds <FILE>.asm assimply file
#	<FILE>.i - Builds <FILE>.i preprocessed file
#	<FILE>.o - Builds <FILE>.o object file
#	Build - Builds and links all source files and produce the excutable
#	compile-all - compile all files without linking
#	clean - removes all generated files
# Platform Overrides:
#	    This makefile supports 2 platforms: the host linux machine, and the MSP432 microcontroller.
#
#------------------------------------------------------------------------------
include sources.mk

# Platform Overrides
PLATFORM ?= DEFAULT 
TARGET = c1m2 

# compiler flags
CFLAGS := -Wall -Werror -g -O0 -std=c99 $(INCLUDES) -MD -MP

ifeq ($(PLATFORM), MSP432)
	# Architectures Specific Flags for MSP432
	LINKER_FILE = ../msp432p401r.lds
	CPU = cortex-m4
	ARCH = armv7e-m
	SPECS = nosys.specs
	CC = arm-none-eabi-gcc
	LD = arm-none-eabi-ld
	LDFLAGS := -Wl,-Map=$(TARGET).map -T $(LINKER_FILE)
	CFLAGS += -mthumb -mfpu=fpv4-sp-d16 -mfloat-abi=soft  
	DEFINEFLAG = -DMSP432
else 
	CC = gcc	
	DEFINEFLAG = -DHOST
endif

# More Declared Variables
OBJS := $(SOURCES:.c=.o)
ASMS := $(SOURCES:.c=.asm)
PPS := $(SOURCES:.c=.i)
MAPS:= $(SOURCES:.c=.map)
OUTS:= $(SOURCES:.c=.out)
DEPS := $(SOURCES:.c=.d)


# Rule to generate .i files
%.i: %.c
	@echo "Generating .i file for $<"
	@$(CC) $(DEFINEFLAG) $(CFLAGS) -E -o $@ $<	

# Rule to generate .asm files
%.asm: %.c
	@echo "Generating .asm file for $<"
	@$(CC) $(DEFINEFLAG) $(CFLAGS) -S -o $@ $<

# @objdump c1m2.out -D

%.o : %.c 
	@echo "Generating .o files for $<"
	@$(CC) $(DEFINEFLAG) $(CFLAGS) -c $< -o $@ 


# Phony target for compiling all .c files into .o files
.PHONY: compile-all
compile-all: $(OBJS)


# Phony target for building the executable
.PHONY: Build
Build: $(OUTS)

$(OUTS): $(SOURCES)
	@echo "Linking object files into executable $(TARGET)"
	@$(CC) $(DEFINEFLAG) $(CFLAGS) $(LDFLAGS) -o c1m2.out $^ 
	@echo "Here is a build report of code size.. \n"
	@size c1m2.out

# Phony target for cleaning up all non-source files
.PHONY: clean
clean:
	@echo "Cleaning up all non-source files ...\n"
	@rm -f -r $(OBJS) $(PPS) $(ASMS) *.map  *.asm *.out.dSYM *.out *.d
