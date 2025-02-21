TARGET            =    libasm.so

CC                =    gcc
NASM            =    nasm

NASMFLAGS        =    -f elf64
LDFLAGS            =    -shared -nostdlib

CFLAGS            =    -Wall -Wextra -Werror -g

ASM_SRC            =    src/strlen.asm \
                    src/strchr.asm \
                    src/strrchr.asm \
                    src/memset.asm \
                    src/memcpy.asm \
                    src/strcmp.asm \
                    src/strncmp.asm \
                    src/memmove.asm \
                    src/strcasecmp.asm \
                    src/strstr.asm \
                    src/strpbrk.asm \
                    src/strcspn.asm

ASM_OBJ            =    $(ASM_SRC:.asm=.o)


FLAGS            =    $(CFLAGS) $(LFLAGS) $(IFLAGS) $(DFLAGS)

OBJECTS            =    $(SOURCES:$(EXTENSION)=.o)



all: $(TARGET)

%.o: %.asm
	$(NASM) $(NASMFLAGS) -o $@ $<

$(TARGET): $(ASM_OBJ)
	$(CC) $(LDFLAGS) -o $(TARGET) $(ASM_OBJ)

clean:
	rm -f $(ASM_OBJ) $(TEST_OBJ)

fclean: clean
	rm -f $(TARGET)

re: fclean all

.PHONY: all clean fclean re run_test