import os
import math


def validate(value):
    if value < -63:
        return -63
    elif value > 63:
        return 63
    else:
        return value
    
def main():

    root_path = os.path.abspath('.')

    output = """; precomputed sine lookup table, it has 4096 points/degrees full sine wave cycle.
;
; the formula to calculate a single point to fixed point sine:
;
; fsine = ( sin( x * PI / 2048 ) * 64 )
;
sineLookUpTable: ; 4000
"""

    buffer = []
    output += "\tdb "

    for i in range(4096):

        value = validate(int(math.sin( i * math.pi / 2048 ) * 64))

        buffer.append(value)
        if i % 15 == 0 and i > 0:
            output += "{}\r\n".format(", ".join([str(b) for b in buffer]))
            buffer = []
            if i != 4095:
               output += "\tdb " 


    with open(os.path.join(root_path, 'data/luts/sine_lookup_table.asm'), 'w') as txt:
        txt.write(output)



if __name__ == '__main__':
    main()