import os
from helpers import load_json, to_hex

def main():

    root_path = os.path.abspath('.')
    source_dir = os.path.join(root_path, 'data/json_data/rooms')
    output_dir = os.path.join(root_path, 'data/rooms/')

    olmasks_json = load_json(os.path.join(source_dir, 'overlaps_masks.json'))

    special_masks_count = {
        "36_4_2": 7,
        "44_2_0": 3,
        "44_2_1": 4,
    }

    output = """; rooms backgrounds overlaps masks
; byte1: Y-sort overlap trigger
; byte2: mask x position (unused, submask x-pos is used instead)
; byte3: unused value
; byte4: mask y position
; byte5: mask height
; byte6: submasks count
; bytes7-8-9...: submasks
;
; submask struct:
;   byte1: x position
;   word2: mask data pointer 

"""
    print("generating rooms overlaps masks")

    for room_id, room_bgs in enumerate(olmasks_json):
        output_parts = []
        for room_bg_id, masks in enumerate(room_bgs):
            hex_room_id = to_hex(room_id)
            for mask_id, mask_data in enumerate(masks):
                hex_room_bg_id = to_hex(mask_data['bg_id'])
                suboutput = "Room{}_{}_overlapMask{}:\r\n".format(hex_room_id, hex_room_bg_id, chr(65+mask_id))
                suboutput += "\tdb {}, {}, {}, {}, {}\r\n".format(
                        mask_data['y_sort'],
                        mask_data['unused1'],
                        mask_data['unused2'],
                        mask_data['y'],
                        mask_data['height'],
                    )
                submasks_count = len(mask_data["masks"])
                submask_key = "{}_{}_{}".format(room_id, room_bg_id, mask_id)
                if submask_key in special_masks_count:
                    submasks_count = special_masks_count[submask_key]
                suboutput += "\tdb {}\r\n".format(submasks_count)
                for submask in mask_data["masks"]:
                    suboutput += "\tdbw {}, {}\r\n".format(submask["x"], submask["filename"])
                suboutput += "\r\n"
                output_parts.append(suboutput)
        if room_id == 0x54:
            # irregular bgs order in room 0x54
            output += output_parts[6]
            output += output_parts[2]
            output += output_parts[0]
            output += output_parts[3]
            output += output_parts[1]
            output += output_parts[4]
            output += output_parts[5]
        else:
            output += "".join(output_parts)


    with open(os.path.join(output_dir, 'rooms_bgs_overlap_masks.asm'), 'w') as txt:
        txt.write(output)


if __name__ == "__main__":
    main()