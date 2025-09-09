#set flags
ASM = nasm
LINKER = ld
PATH_TO_LIBRARY = ../Lib
MY_LIB = mylib.so
DYNAMIC_LINKER = /lib64/ld-linux-x86-64.so.2
LINKER_FLAGS = -rpath '$$ORIGIN/$(PATH_TO_LIBRARY)' 
COMPILER_FLAGS = -f elf64
SOURCES = main.asm dict.asm
OBJECTS = $(SOURCES:.asm=.o)
TARGET = main
#code

all:$(TARGET)

$(TARGET): $(OBJECTS) $(PATH_TO_LIBRARY)/$(MY_LIB)
	$(LINKER) $(LINKER_FLAGS) --dynamic-linker $(DYNAMIC_LINKER) $(OBJECTS) $(PATH_TO_LIBRARY)/$(MY_LIB) -o $@


%.o : %.asm
	$(ASM) $(COMPILER_FLAGS) $< -o $@

$(PATH_TO_LIBRARY)/$(MY_LIB):
	@ if [ ! -f "$(PATH_TO_LIBRARY)/$(MY_LIB)" ]; \
		then \
	echo "$(ORIGIN)/$(PATH_TO_LIBRARY)/$(MY_LIB) not found, make it first"; \
	exit 1; \
	fi
.PHONY: clean

clean:
	rm -rf $(OBJECTS)
