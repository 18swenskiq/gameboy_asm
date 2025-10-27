SRC = $(wildcard *.c)
BUILD_DIR = build
OBJ = $(patsubst %.c,$(BUILD_DIR)/%.o,$(SRC))

CC=gcc
CFLAGS=-march=native -O3 -Wextra -Wall -Wno-switch -std=c99 -masm=intel
LDFLAGS=-lSDL2

all: clean gameboy

debug: CFLAGS += -g -DDEBUG=1
debug: clean gameboy

gameboy: $(BUILD_DIR) $(OBJ)
	$(CC) $(OBJ) $(CFLAGS) -o $(BUILD_DIR)/gameboy $(LDFLAGS) -fwhole-program

$(BUILD_DIR)/%.o : %.c
	$(CC) $(CFLAGS) -flto $^ -c -o $@

$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

clean:
	$(RM) -rf $(BUILD_DIR)
