rom = resevil
fix_flags = -cj -k "4Z" -l 0x33 -m 0x1b -p 0 -r 02 -t "RES EVIL"
sources = main.asm
objects = $(sources:%.asm=%.o)
	
sprites_png = $(wildcard gfx/*.png) $(wildcard gfx/room_items_sprites/*.png)
sprites_2bpp = $(patsubst %.png,%.2bpp,$(sprites_png))

sprt_sheets_png = $(wildcard gfx/sprite_sheets/*/*.png)
sprt_sheets_2bpp = $(patsubst %.png,%.2bpp,$(sprt_sheets_png))

.PHONY: all clean resevil

all: $(sprites_2bpp) $(sprt_sheets_2bpp) $(rom)

$(rom): $(objects)
	rgblink -o $@.gbc -n $@.sym $(objects)
	rgbfix $(fix_flags) $@.gbc
	md5sum $@.gbc

%.o: %.asm
	rgbasm -o $@ $<
	
$(sprites_2bpp):
	python tools/png2bpp.py -m png2bpp -i $(patsubst %.2bpp,%.png,$@) -o $@

$(sprt_sheets_2bpp):
	python tools/png2bpp.py -m interlacedpairs -i $(patsubst %.2bpp,%.png,$@) -o $@

clean:
	rm -f $(rom).gbc $(rom).sym $(objects)

