import os
    
def main():

    root_path = os.path.abspath('.')

    output = """; lookup table to get the vertical scale values
; 
; verticalScale = ((height - 1) * 2)
verticalScaleLookupTable: ;00:1397
"""

    # buffer = []
    output += "\tdb $FF"

    # the output is an aproximation, I could not find the correct pattern
    for i in range(94):

        if i == 0:
            continue

        x = i
        c = 0
        buffer = []
        a = 94
        while x > 0:
            value = a // x
            a = a - value
            if value % 2 != 0:
                if c % 2 == 0:
                    value = value-1
                else:
                    value = value+1
            buffer.append(value)
            x = x-1
            c = c+1


    # with open(os.path.join(root_path, 'data/luts/_sine_lookup_table.asm'), 'w') as txt:
    #     txt.write(output)


if __name__ == '__main__':
    main()