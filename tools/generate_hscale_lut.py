import os

routine_comment = """; Horizontal shrinking lookup table
;
; Entities sprites are horizontally shrank by skipping pixels.
; Each sprite is 32px wide, separated by two 16px sections, each section are shrank
; with skip patterns ranging from 0 (32px max) to 12 (5px min) steps.
;
; This method is the same the NeoGeo use to shrink their sprites, but by hardware.
;
; Left     Right    Width ID
; 12345678 12345678
;
; 11111111 11111111 0
; 11111111 11111110 1
; 11011111 11110111 2
; 11101111 11101110 3
; 10110111 11011011 4
; 11011011 10110110 5
; 01101101 10101101 6
; 10101101 10101010 7
; 01010101 01010101 8
; 10101010 10010010 9
; 10101010 01001001 10
; 10010010 00100100 11
; 10010010 00100100 12
;
;
"""


def identity(x):
    # 11111111
    return x

def scale_11011111(x):
    # 11011111
    return ((x & 0xC0) >> 1) | ((x & 0x1F) >> 0)

def scale_11101111(x):
    # 11101111
    return ((x & 0xE0) >> 1) | ((x & 0x0F) >> 0)

def scale_11110111(x):
    # 11110111
    return ((x & 0xF0) >> 1) | ((x & 0x07) >> 0)

def scale_11101110(x):
    # 11101110
    return ((x & 0xE0) >> 2) | ((x & 0x0E) >> 1)

def scale_10110111(x):
    # 10110111
    return ((x & 0x80) >> 2) | ((x & 0x30) >> 1) | ((x & 0x07) >> 0)

def scale_10110110(x):
    # 10110110
    return ((x & 0x80) >> 3) | ((x & 0x30) >> 2) | ((x & 0x06) >> 1)

def scale_11011011(x):
    # 11011011
    return ((x & 0xC0) >> 2) | ((x & 0x18) >> 1) | ((x & 0x03) >> 0)

def scale_01101101(x):
    # 01101101
    return ((x & 0x60) >> 2) | ((x & 0x0C) >> 1) | ((x & 0x01) >> 0)

def scale_10101101(x):
    # 10101101
    return (((x & 0x80) >> 3) | ((x & 0x20) >> 2)
            | ((x & 0x0C) >> 1) | ((x & 0x01) >> 0))
            
def scale_01010101(x):
    # 01010101
    return (((x & 0x40) >> 3) | ((x & 0x10) >> 2)
            | ((x & 0x04) >> 1) | ((x & 0x01) >> 0))
            
def scale_10101010(x):
    # 10101010
    return (((x & 0x80) >> 4) | ((x & 0x20) >> 3)
            | ((x & 0x08) >> 2) | ((x & 0x02) >> 1))

def scale_10010010(x):
    # 10010010
    return (((x & 0x80) >> 5) | ((x & 0x10) >> 3) | ((x & 0x02) >> 1))

def scale_01001001(x):
    # 01001001
    return (((x & 0x40) >> 4) | ((x & 0x08) >> 2) | ((x & 0x01) >> 0))

def scale_00100100(x):
    # 00100100
    return ((x & 0x20) >> 4) | ((x & 0x04) >> 2)

def scale_01111111(x):
    # 01111111
    return (x & 0x7F)

def scale_11111110(x):
    # 11111110
    return ((x & 0xFE) >> 1)


h_scale_left = [
    ("identity (full width)", identity),
    ("identity (full width)", identity),
    ("scale 8 to 7 (11011111)", scale_11011111),
    ("scale 8 to 7 (11101111)", scale_11101111),
    ("scale 8 to 6 (10110111)", scale_10110111),
    ("scale 8 to 6 (11011011)", scale_11011011),
    ("scale 8 to 5 (01101101)", scale_01101101),
    ("scale 8 to 5 (10101101)", scale_10101101),
    ("scale 8 to 4 (01010101)", scale_01010101),
    ("scale 8 to 4 (10101010)", scale_10101010),
    ("scale 8 to 4 (10101010)", scale_10101010),
    ("scale 8 to 3 (10010010)", scale_10010010),
    ("scale 8 to 3 (10010010)", scale_10010010)
]

h_scale_right = [
    ("identity (full width)", identity),
    ("scale 8 to 7 (11111110)", scale_11111110),
    ("scale 8 to 7 (11110111)", scale_11110111),
    ("scale 8 to 6 (11101110)", scale_11101110),
    ("scale 8 to 6 (11011011)", scale_11011011),
    ("scale 8 to 5 (10110110)", scale_10110110),
    ("scale 8 to 5 (10101101)", scale_10101101),
    ("scale 8 to 4 (10101010)", scale_10101010),
    ("scale 8 to 4 (01010101)", scale_01010101),
    ("scale 8 to 3 (10010010)", scale_10010010),
    ("scale 8 to 3 (01001001)", scale_01001001),
    ("scale 8 to 2 (00100100)", scale_00100100),
    ("scale 8 to 2 (00100100)", scale_00100100)
]



def to_hex_str(value, zeropad=2):
    return '$%s' % (hex(value)[2:].zfill(zeropad).upper())

def main():
    
    root_path = os.path.abspath('.')
    data_dir = os.path.join(root_path, 'data/luts')
    
    output = """{}
horizontalShinkingLookupTable:
""".format(routine_comment)
    
    row = []
    for desc, lf in h_scale_left:
        output += '\r\n;%s' % desc
        for i in range(256):
            row.append(to_hex_str(lf(i)))
            if i % 16 == 0:
                output += '\r\n\tdb '
            if len(row) == 16:
                output += ', '.join(row)
                row = []
        output += '\r\n' 
    row = []
    for desc, rf in h_scale_right:
        output += '\r\n;%s' % desc
        for i in range(256):
            row.append(to_hex_str(rf(i)))
            if i % 16 == 0:
                output += '\r\n\tdb '
            if len(row) == 16:
                output += ', '.join(row)
                row = []
        output += '\r\n' 
       
    with open(os.path.join(data_dir, 'horizontal_shrinking_lut.asm'), 'w') as txt:
        txt.write(output)

    
if __name__ == '__main__':
    main()
