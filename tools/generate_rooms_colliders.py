import os
from helpers import load_json, to_hex

def main():

    root_path = os.path.abspath('.')
    source_dir = os.path.join(root_path, 'data/json_data/rooms')
    output_dir = os.path.join(root_path, 'data/rooms/')

    boundaries_json = load_json(os.path.join(source_dir, 'boundaries.json'))
    colliders_json = load_json(os.path.join(source_dir, 'colliders.json'))

    boundaries_output = """; rooms boundaries
; 8 bytes per room boundaries rect
; 
; boundary rect words:
;  - word1: rect left border (x2)
;  - word2: rect right border (x1)
;  - word3: rect top border (z1)
;  - word4: rect bottom border (z2)
roomsBoundaries:

"""
    colliders_output = """; Rooms collision boxes
; each collider rect is formed by 4 signed words
; 
; byte header: collision boxes count
; collision box rect words:
;  - word1: rect x
;  - word2: rect z
;  - word3: rect width
;  - word4: rect height

"""

    colliders_table_output = """
roomsCollidersTable:
"""

    print("generating rooms boundaries")

    for room_id, boundaries in enumerate(boundaries_json):
        hex_room_id = to_hex(room_id)
        boundaries_output += "room{}_boundaries:\r\n".format(hex_room_id)
        boundaries_output += "\tdw {}, {}, {}, {}\r\n".format(boundaries[0], boundaries[1], boundaries[2], boundaries[3])
        boundaries_output += "\r\n"

    with open(os.path.join(output_dir, 'rooms_boundaries_.asm'), 'w') as txt:
        txt.write(boundaries_output)


    print("generating rooms colliders")

    for room_id, colliders in enumerate(colliders_json):
        hex_room_id = to_hex(room_id)
        colliders_output += "room_{}_colliders:\r\n".format(hex_room_id)
        colliders_output += "\tdb {}\r\n".format(len(colliders))
        for collider in colliders:
            colliders_output += "\tdw {}, {}, {}, {}\r\n".format(collider[0], collider[1], collider[2], collider[3])
        colliders_output += "\r\n"
        colliders_table_output += "\tdw room_{}_colliders\r\n".format(hex_room_id)

    with open(os.path.join(output_dir, 'rooms_colliders_.asm'), 'w') as txt:
        txt.write(colliders_output)

    with open(os.path.join(output_dir, 'rooms_colliders_table_.asm'), 'w') as txt:
        txt.write(colliders_table_output)


if __name__ == "__main__":
    main()