CC = gcc
CFLAGS = -Wall -Wextra -Werror -ldl
NASM = nasm
NASMFLAGS = -f elf64 -g -O2
LDFLAGS = -shared -o

NAME = libasm.so
SRC = 	include/strlen.asm \
       include/strchr.asm \
       include/strrchr.asm \
       include/memcpy.asm \
       include/memset.asm \
       include/strcmp.asm

OBJ = $(SRC:.asm=.o)

all: $(NAME)
	LD_PRELOAD=./$(NAME)

%.o: %.asm
	$(NASM) $(NASMFLAGS) -o $@ $<

$(NAME): $(OBJ)
	$(CC) $(LDFLAGS) $(NAME) $(OBJ) -fPIC

main: main.c
	$(CC) $(CFLAGS) -o main main.c -ldl

clean:
	rm -f $(OBJ) main

fclean: clean
	rm -f $(NAME)

re: fclean all
