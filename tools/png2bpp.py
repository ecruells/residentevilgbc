from PIL import Image


# python 2/3 cross compatibility fixes
try:
    xrange
except NameError:
    xrange = range
try:
    raw_input
except NameError:
    raw_input = input
try:
    next
except NameError:
    next = lambda x: x.next()
def blank_byte_array():
    try:
        return array.array('B')
    except TypeError:
        return array.array(b'B')
    
    
def encode_tile_data(tile_matrix):
    """
    Encode tiles array data to 2bpp format
    """
    encoded_tile = []
    for y in range(8):
        hibits = 0
        lobits = 0
        for x in range(8):
            idx = tile_matrix[y][x]
            hibits = hibits | (((idx & 2) >> 1) << 7-x)
            lobits = lobits | ((idx & 1) << 7-x)
        encoded_tile.append(lobits)
        encoded_tile.append(hibits)
    
    return bytes(encoded_tile)

def decode_tile_data(tile_bytes):
    """
    Decode tiles bytes data to array format
    """
#    tile_rows_bytes = np.array(tile_bytes).reshape(8,2)
    decoded_tile = []
    for row_byte in tile_bytes:
        lobyte = row_byte[0]
        hibyte = row_byte[1]
        for bit in range(8):
            lobit = (lobyte & (128 >> bit)) >> (7-bit)
            hibit = ((hibyte & (128 >> bit)) << 1) >> (7-bit)
            pixel_id = hibit | lobit
            decoded_tile.append(pixel_id)
    return decoded_tile


def png2bpp(im):
    im.load()
    (w, h) = im.size
    data = []
    tile = []
    for x in range(w//8):
        x_offset = x * 8
        for y in range(h):
            row = []
            for i in range(8):
                pixel = im.getpixel((x_offset+i, y))
                row.append(pixel)
            tile.append(row)
            if len(tile) == 8:
                data.append(tile)
                tile = []
    output = []
    for tile in data:
        output.append(encode_tile_data(tile))
    return output


def _2bpp2png(data, height):
    
    tiles_count = len(data) // 16
    
    im_w = (tiles_count * 8) // (height // 8)
    im_h = height
    
    im = Image.new('L', (im_w, im_h))
    
    img_data = []
    
    px = 0
    for ti in range(tiles_count):
        py = (ti+1)*8
        tile_data_list = data[(ti*16):(ti*16)+16]
        
        tile_data = []
        for i in range(0,16,2):
            tile_data.append(tile_data_list[i:i+2])
            
        tile_img_data = decode_tile_data(tile_data)
        img_data += tile_img_data

        if py % height == 0:
            col_im = Image.new('L', (8, im_h))
            col_im.putdata(img_data)
            im.paste(col_im, (px,0))
            px += 8
            img_data = []
    
    palette = [255, 255, 255, 165, 165, 165, 82, 82, 82, 0, 0, 0]
    im.putpalette(palette)
    
    return im

def png2interlacedpairs(im):
    """
    Convert 32x48 by frame spritesheet indexed png into a 2bpp interlaced 16px pair tiles
    used for scaling engine
    """
    im.load()
    (w, h) = im.size
    
    data = []
    odd_x = 0
    even_x = 8
    
    tile = []
    
    for x in range(w//16):
        x_offset = 16 * x
        for y in range(h):
            #odd row
            row = []
            for i in range(8):
                pixel = im.getpixel((odd_x+x_offset+i, y))
                row.append(pixel)
            tile.append(row)
            #even row
            row = []
            for i in range(8):
                pixel = im.getpixel((even_x+x_offset+i, y))
                row.append(pixel)
            tile.append(row)
            if len(tile) == 8:
                data.append(tile)
                tile = []
                
    output = []
    
    for tile in data:
        output.append(encode_tile_data(tile))
    
    return output

def parse_argv(argv):
    from optparse import OptionParser
    parser = OptionParser(usage="usage: %prog [options] [-i] INFILE [-o] OUTFILE")
    parser.add_option("-i", "--image", dest="infilename",
                      help="read image from INFILE", metavar="INFILE")
    parser.add_option("-o", "--output", dest="outfilename",
                      help="write 2bpp data to OUTFILE", metavar="OUTFILE")
    parser.add_option("-m", "--mode", dest="conversion_mode",
                      help="select image conversion mode", metavar="MODE",
                      default="png2bpp")
    parser.add_option("-H", "--height", dest="height",
                      help="set height of metatiles", metavar="HEIGHT",
                      type="int", default=8)
    (options, args) = parser.parse_args(argv[1:])                 
                      
    modes = ['png2bpp','2bpp2png', 'interlacedpairs']
                      
    conversion_mode = options.conversion_mode
    if conversion_mode not in modes:
        raise ValueError("must select a valid conversion mode")
    
    height = int(options.height)
    if height <= 0:
        raise ValueError("tile width '%d' must be positive" % height)

    # Fill unfilled roles with positional arguments
    argsreader = iter(args)
    try:
        infilename = options.infilename
        if infilename is None:
            infilename = next(argsreader)
    except StopIteration:
        raise ValueError("not enough filenames")

    outfilename = options.outfilename
    if outfilename is None:
        try:
            outfilename = next(argsreader)
        except StopIteration:
            outfilename = '-'
    if outfilename == '-':
        import sys
        if sys.stdout.isatty():
            raise ValueError("cannot write output to terminal")

    return (conversion_mode, infilename, outfilename, height)

argvTestingMode = True

def make_stdout_binary():
    """Ensure that sys.stdout is in binary mode, with no newline translation."""

    # Recipe from
    # http://code.activestate.com/recipes/65443-sending-binary-data-to-stdout-under-windows/
    # via http://stackoverflow.com/a/2374507/2738262
    if sys.platform == "win32":
        import os, msvcrt
        msvcrt.setmode(sys.stdout.fileno(), os.O_BINARY)

def main(argv=None):
    import sys
    if argv is None:
        argv = sys.argv
        if (argvTestingMode and len(argv) < 2
            and sys.stdin.isatty() and sys.stdout.isatty()):
            argv.extend(raw_input('args:').split())
    try:
        (conversion_mode, infilename, outfilename, height) = parse_argv(argv)
    except Exception as e:
        sys.stderr.write("%s: %s\n" % (argv[0], str(e)))
        sys.exit(1)

    if conversion_mode == 'png2bpp':
        im = Image.open(infilename)
        outdata = png2bpp(im)
    elif conversion_mode == '2bpp2png':
        f = open(infilename, "rb")
        bytes_data = f.read()
        f.close()
        outdata = _2bpp2png(bytes_data, height)
        outdata.save(outfilename)
        return 0
    elif conversion_mode == 'interlacedpairs':
        im = Image.open(infilename)
        outdata = png2interlacedpairs(im)
    
    outdata = b''.join(outdata)

    # Read input file
    outfp = None
    try:
        if outfilename != '-':
            outfp = open(outfilename, 'wb')
        else:
            outfp = sys.stdout
            make_stdout_binary()
        outfp.write(outdata)
    finally:
        if outfp and outfilename != '-':
            outfp.close()

if __name__=='__main__':
    main()


