TARGET            =    libasm.so

NASM            =    nasm
CC                =    gcc

NASMFLAGS        =    -f elf64
LDFLAGS            =    -shared -nostdlib

CFLAGS            =    -Wall -Wextra -Werror -g
TEST_EXEC        =    test_runner


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

TEST_SRC        =    src/main.c
TEST_OBJ        =    $(TEST_SRC:.c=.o)


FLAGS            =    $(CFLAGS) $(LFLAGS) $(IFLAGS) $(DFLAGS)

OBJECTS            =    $(SOURCES:$(EXTENSION)=.o)



all: $(TARGET)

%.o: %.asm
	$(NASM) $(NASMFLAGS) -o $@ $<

$(TARGET): $(ASM_OBJ)
	$(CC) $(LDFLAGS) -o $(TARGET) $(ASM_OBJ)

$(TEST_EXEC): $(TEST_OBJ) $(TARGET)
	$(CC) $(CFLAGS) -o $(TEST_EXEC) $(TEST_OBJ) -L. -lasm

run_test: $(TEST_EXEC)
	LD_LIBRARY_PATH=. ./$(TEST_EXEC)

clean:
	rm -f $(ASM_OBJ) $(TEST_OBJ)

fclean: clean
	rm -f $(TARGET) $(TEST_EXEC)

re: fclean all

.PHONY: all clean fclean re run_test