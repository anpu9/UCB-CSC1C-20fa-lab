# Determine the current operating system
UNAME_S := $(shell uname -s)

# Compiler and Linker Definitions
CC = gcc          # C Compiler
LD = gcc          # Linker
CFLAGS = -ggdb -Wall -std=c99  # Compilation options: for debugging (-ggdb), enabling warnings (-Wall), and specifying the C standard as C99
LDFLAGS =         # Linker options (currently empty)

# Conditionals Based on the Operating System
ifeq ($(UNAME_S), Darwin)
    # On macOS (Darwin), use these options for memory checking
    MEMCHECK = valgrind --tool=memcheck --leak-check=full --track-origins=yes --dsymutil=yes
endif
ifeq ($(UNAME_S), Linux)
    # On Linux, use these options for memory checking
    MEMCHECK = valgrind --tool=memcheck --leak-check=full --track-origins=yes
endif

# Definitions for Object Files and Executables
BIT_OPS_OBJS = bit_ops.o test_bit_ops.o
# store the name of the executable program that will be generated when you build the bit_ops program.
BIT_OPS_PROG = bit_ops

LFSR_OBJS = lfsr.o test_lfsr.o
LFSR_PROG = lfsr

VECTOR_OBJS = vector.o vector-test.o
VECTOR_PROG = vector-test

# Create a list of all the programs to be built
BINARIES = $(VECTOR_PROG) $(BIT_OPS_PROG) $(LFSR_PROG)

# Default target to build all programs
all: $(BINARIES)

# Build the bit_ops program
# the $(BIT_OPS_PROG) variable is used as the name for the output executable, and the $(BIT_OPS_OBJS) variable represents the object files. The Makefile appends the necessary file suffixes and performs the compilation and linking accordingly
$(BIT_OPS_PROG): $(BIT_OPS_OBJS)
	$(CC) $(CFLAGS) -o $(BIT_OPS_PROG) $(BIT_OPS_OBJS) $(LDFLAGS)

# Build the lfsr program
$(LFSR_PROG): $(LFSR_OBJS)
	$(CC) $(CFLAGS) -o $(LFSR_PROG) $(LFSR_OBJS) $(LDFLAGS) $(LDFLAGS)

# Build the vector program
$(VECTOR_PROG) : $(VECTOR_OBJS)
	$(CC) $(CFLAGS) -o $(VECTOR_PROG) $(VECTOR_OBJS)

# Dependency rules to create object files from source files
.c.o:
	$(CC) -c $(CFLAGS) $<

# Target for running memory checks on the vector-test program
vector-memcheck: $(VECTOR_PROG)
	$(MEMCHECK) ./$(VECTOR_PROG)

# Clean up temporary and generated files
clean:
	-rm -rf core *.o *~ "#"*"#" Makefile.bak $(BINARIES) *.dSYM

# Dependency rules for header files
vector.c: vector.h
vector-test.c: vector.h
lfsr.c: lfsr.h
test_lfsr.c: lfsr.h
bit_ops.c: bit_ops.h
test_bit_ops.c: bit_ops.h
