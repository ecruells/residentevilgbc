import os
from helpers import load_json, to_hex

def main():

    root_path = os.path.abspath('.')
    source_dir = os.path.join(root_path, 'data/json_data/rooms')
    output_dir = os.path.join(root_path, 'data/rooms/')

    json_data = load_json(os.path.join(source_dir, 'maps_rects.json'))

    output = """; mansion 1F map rooms map rects
; 
; map rect struct:
; - 0: x position
; - 1: y position
; - 2: width
; - 3: height
; - 4: roomId
;
roomsMapRects:

"""

    print("generating rooms map rects")

    for map_rects in json_data:
        hex_room_id = to_hex(map_rects["room_id"])
        label = "room{}_map_rect".format(hex_room_id)
        for i, rect in enumerate(map_rects["map_rects"]):
            output += label + "{}:\r\n".format(str(i).zfill(2))
            output += "\tdb {}, {}\r\n".format(rect["x"], rect["y"])
            output += "\tdb {}, {}\r\n".format(rect["width"], rect["height"])
            output += "\tdw {}\r\n".format(map_rects["room_id"])
            output += "\r\n"

    with open(os.path.join(output_dir, 'rooms_map_rects_data_.asm'), 'w') as txt:
        txt.write(output)


if __name__ == "__main__":
    main()