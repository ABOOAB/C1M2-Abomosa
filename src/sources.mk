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

# Add your Source files to this variable
ifeq ($(PLATFORM), MSP432)
        SOURCES = *.c 

        # specify the includes directory
        INCLUDES_DIR = $(home)/week2/includes

        # Add your include paths to this variable
        INCLUDES = $(shell find $(INCLUDES-DIR) -type f)
else
        SOURCES = main.c \
                  memory.c

        INCLUDES = ../includes/common/memorey.h \
                   ../includes/common/platform.h

endif



