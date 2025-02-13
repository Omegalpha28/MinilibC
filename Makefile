TARGET          =    libasm.so
NASM            =    nasm
CC              =    gcc
TEST_OBJ 		= 	 main.c
NASMFLAGS       =    -f elf64
CFLAGS          =    -Wall -Wextra -Werror -g
LDFLAGS         =    -shared -nostdlib
TEST_EXEC       =    test_runner

SRC = include/strlen.asm \
	include/strchr.asm \
	include/strrchr.asm \
	include/memcpy.asm \
	include/memset.asm \
	include/strcmp.asm \
	include/strncmp.asm \
	include/memmove.asm \
	include/strcasecmp.asm

ASM_OBJ = $(SRC:.asm=.o)

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
