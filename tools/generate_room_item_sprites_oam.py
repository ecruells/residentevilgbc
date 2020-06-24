import os
from helpers import load_json, to_hex

def main():

    root_path = os.path.abspath('.')
    source_dir = os.path.join(root_path, 'data/json_data/rooms')
    output_dir = os.path.join(root_path, 'data/rooms/')

    json_data = load_json(os.path.join(source_dir, 'bg_items_sprites.json'))

    output = """; rooms item sprites OAMs
; 
; sprite struct:
; - 0: y-sort
; - 1: palette id
; - 2: x position
; - 3: y position
; - 4: width
; - 5: height
; - 6: sprite bank
; - 7: sprite pointer

"""

    print("generating rooms items sprites table")

    for item_data in json_data:
        label = item_data["label"]
        if item_data["room_id"] is not None:
            room_id = to_hex(item_data["room_id"])
            bg_id = to_hex(item_data["bg_id"])
            label = "room{}_{}_{}".format(room_id, bg_id, label)

        if "frames" in item_data:
            label += "_frame01"

        output += "{}:\r\n".format(label)
        output += "\tdb {}\r\n".format(item_data["y_sort"])
        output += "\tdw {}\r\n".format(item_data["palette_id"])
        output += "\tdb {}, {}\r\n".format(item_data["x"], item_data["y"])
        output += "\tdb {}, {}\r\n".format(item_data["width"], item_data["height"])
        output += "\tdbw BANK({0}), {0}\r\n".format(item_data["sprite_name"])
        output += "\r\n"

        if "frames" in item_data:
            tiles_w = item_data["width"] // 8
            tiles_h = item_data["height"] // 8
            frame_bytes = int((tiles_w * tiles_h) * 16)
            for frame_id in range(item_data["frames"]):
                if frame_id == 0:
                    continue
                output += "{}:\r\n".format(label[:-2] + str(frame_id+1).zfill(2))
                output += "\tdb {}\r\n".format(item_data["y_sort"])
                output += "\tdw {}\r\n".format(item_data["palette_id"])
                output += "\tdb {}, {}\r\n".format(item_data["x"], item_data["y"])
                output += "\tdb {}, {}\r\n".format(item_data["width"], item_data["height"])
                output += "\tdbw BANK({0}), {1}\r\n".format(
                    item_data["sprite_name"],
                    item_data["sprite_name"] + "+{}".format(frame_id*frame_bytes)
                    )
                output += "\r\n"

    with open(os.path.join(output_dir, 'rooms_bgs_items_sprites_table.asm'), 'w') as txt:
        txt.write(output)


if __name__ == "__main__":
    main()