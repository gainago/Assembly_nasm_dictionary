#set variables
COMPILER = nasm #nasm by default generates position independent code
LINKER = ld
LINKER_FLAGS = -shared 
COMPILER_FLAGS = -f elf64 -g
TARGET = mylib.so
SOURCES = exit.asm parse_uint.asm parse_int.asm print_char.asm print_int.asm print_newline.asm read_char.asm print_string.asm print_uint.asm read_word.asm string_length.asm string_equals.asm
OBJECTS = $(SOURCES:.asm=.o)
#code
all : $(TARGET)	

$(TARGET): $(OBJECTS)
	$(LINKER) $(LINKER_FLAGS) $^ -o $@
%.o : %.asm
	$(COMPILER) $(COMPILER_FLAGS) $<  -o $@
.PHONY: clean
clean:
	rm -rf *.o
