
rom := resevil.gbc

.PHONY: all clean resevil

all: $(rom)
resevil: resevil.gbc

rgbasm -o resevil.o main.asm

rgblink -n resevil.sym -o resevil.gbc resevil.o

rgbfix -cjv -k "4Z" -l 0x33 -m 0x1b -p 0 -r 02 -t "RES EVIL" resevil.gbc