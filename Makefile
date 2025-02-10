NAME = libasm.so
SRC = 	include/strlen.asm \
		include/strchr.asm

OBJ = $(SRC:.asm=.o)
LD = ld
LDFLAGS = -shared -o
NASM = nasm
NASMFLAGS = -f elf64

all: $(NAME)

$(NAME): $(OBJ)
	$(LD) $(LDFLAGS) $(NAME) $(OBJ)

%.o: %.asm
	$(NASM) $(NASMFLAGS) -o $@ $<

clean:
	rm -f $(OBJ)

fclean: clean
	rm -f $(NAME)

re: fclean all
