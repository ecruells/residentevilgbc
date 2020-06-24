import os
from helpers import load_json, to_hex

def main():
    
    root_path = os.path.abspath('.')
    source_bgs_dir = os.path.join(root_path, 'data/rooms/backgrounds')
    target_bgs_dir = os.path.join(root_path, 'gfx/rooms_bg')
    target_bgs_masks_dir = os.path.join(target_bgs_dir, 'masks')
    rooms_json_data_dir = os.path.join(root_path, 'data/json_data/rooms')

    output_dir = os.path.join(root_path, 'data/rooms')

    rooms = load_json(os.path.join(rooms_json_data_dir, 'rooms.json'))
    rooms_cameras = load_json(os.path.join(rooms_json_data_dir, 'cameras.json'))
    rooms_masks = load_json(os.path.join(rooms_json_data_dir, 'bg_masks.json'))

    camera_count_exceptions = {
        5: 6,
        24: 2,
        41: 3,
        72: 5,
        78: 6,
        80: 7,
        86: 7,
        101: 6
    }

    rooms_bgs_pointers = """; rooms backgrounds pointers
; byte 1: bg bank
; byte 2-3: bg pointer

"""

    rooms_bgs_masks_pointers = """; rooms backgrounds masks pointers

"""

    rooms_bgs_lut = """; rooms backgrounds lookup table
; word 1: background data pointer
; word 2: background palette pointer

roomsBgLookupTable: ; 1:71B5
"""

    section_size = 0
    bank_count = 0
    bank_id = 0x10
    rooms_bgs_sections = """
SECTION "roomsBgBank0",ROMX,BANK[${}]

""".format(to_hex(bank_id))
    
    for room_id, room_name in enumerate(rooms):
        room_bgs = len(rooms_cameras[room_id])
        if room_id in camera_count_exceptions:
            room_bgs = camera_count_exceptions[room_id]
        hex_room_id = to_hex(room_id)
        
        rooms_bgs_lut += '\tdw room_{}_bg_pointers, room_{}_palette\r\n'.format(hex_room_id, hex_room_id)
        rooms_bgs_pointers += 'room_{}_bg_pointers:\r\n'.format(hex_room_id)
        hex_room_id
        for bg_id in range(room_bgs):
            hex_bg_id = to_hex(bg_id)
            file_name = 'room{}_{}.2bpp'.format(hex_room_id, hex_bg_id)
            f = open(os.path.join(source_bgs_dir, file_name), "rb")
            file_bin = f.read()
            f.close()
            
            file_size = len(file_bin)
            section_size += file_size
            
            if section_size > 0x4000:
                diff = file_size - (section_size - 0x4000)
                # file part 1
                file_part_1 = file_bin[:diff]
                file_name_1 = 'room{}_{}_p1.2bpp'.format(hex_room_id, hex_bg_id)
                with open(os.path.join(target_bgs_dir, file_name_1), 'wb') as w:
                    w.write(file_part_1)
                # file part 2
                file_part_2 = file_bin[diff:]
                file_name_2 = 'room{}_{}_p2.2bpp'.format(hex_room_id, hex_bg_id)
                with open(os.path.join(target_bgs_dir, file_name_2), 'wb') as w:
                    w.write(file_part_2)
                # set new section size
                section_size = (section_size - 0x4000)
                rooms_bgs_pointers += '\tdbw BANK({}),\t\t{}\r\n'.format(file_name_1[:-5], file_name_1[:-5]) 
                
                bank_count += 1
                bank_id += 1
                rooms_bgs_sections += '{}:\tINCBIN "gfx/rooms_bg/{}"\r\n'.format(file_name_1[:-5], file_name_1)
                rooms_bgs_sections += '\r\nSECTION "roomsBgBank{}",ROMX,BANK[${}]\r\n\r\n'.format(bank_count, to_hex(bank_id))
                rooms_bgs_sections += '{}:\tINCBIN "gfx/rooms_bg/{}"\r\n'.format(file_name_2[:-5], file_name_2)
            else:
                with open(os.path.join(target_bgs_dir, file_name), 'wb') as w:
                    w.write(file_bin)
                rooms_bgs_pointers += '\tdbw BANK({}),\t\t{}\r\n'.format(file_name[:-5], file_name[:-5]) 
                rooms_bgs_sections += '{}:\t\tINCBIN "gfx/rooms_bg/{}"\r\n'.format(file_name[:-5], file_name)

    rooms_bgs_sections += "\r\n\r\n; room background masks\r\n\r\n"
          
    # rooms bgs masks
    for room_masks in rooms_masks:
        hex_room_id = to_hex(room_masks["room_id"])
        rooms_bgs_masks_pointers += "\r\n"
        for mask in room_masks["masks"]:
            hex_bg_id = to_hex(mask["bg_id"])
            mask_label = mask["label"]

            mask_id = 0
            if "bg_mask_id" in mask:
                mask_id = mask["bg_mask_id"]
            
            if not "frames" in mask:
                rooms_bgs_masks_pointers += 'room{}_{}_{}_mask:\r\n'.format(hex_room_id, hex_bg_id, mask_label)
                
                base_filename = 'room{}_{}_mask_{}'.format(hex_room_id, hex_bg_id, str(mask_id).zfill(2))
                file_name = '{}.2bpp'.format(base_filename)
                f = open(os.path.join(source_bgs_dir, 'masks', file_name), "rb")
                file_bin = f.read()
                f.close()
                
                file_size = len(file_bin)
                section_size += file_size

                if section_size > 0x4000:
                    diff = file_size - (section_size - 0x4000)
                    # file part 1
                    file_part_1 = file_bin[:diff]
                    file_name_1 = '{}_p1.2bpp'.format(base_filename)
                    with open(os.path.join(target_bgs_masks_dir, file_name_1), 'wb') as w:
                        w.write(file_part_1)
                    # file part 2
                    file_part_2 = file_bin[diff:]
                    file_name_2 = '{}_p2.2bpp'.format(base_filename)
                    with open(os.path.join(target_bgs_masks_dir, file_name_2), 'wb') as w:
                        w.write(file_part_2)
                    # set new section size
                    section_size = (section_size - 0x4000)
                    rooms_bgs_masks_pointers += '\tdbw BANK({}), {}\r\n'.format(file_name_1[:-5], file_name_1[:-5]) 

                    bank_count += 1
                    bank_id += 1
                    rooms_bgs_sections += '{}:\tINCBIN "gfx/rooms_bg/masks/{}"\r\n'.format(
                        file_name_1[:-5], file_name_1)
                    rooms_bgs_sections += '\r\nSECTION "roomsBgBank{}",ROMX,BANK[${}]\r\n\r\n'.format(
                        bank_count, to_hex(bank_id))
                    rooms_bgs_sections += '{}:\tINCBIN "gfx/rooms_bg/masks/{}"\r\n'.format(
                        file_name_2[:-5], file_name_2)
                else:
                    with open(os.path.join(target_bgs_masks_dir, file_name), 'wb') as w:
                        w.write(file_bin)
                    rooms_bgs_masks_pointers += '\tdbw BANK({}), {}\r\n'.format(file_name[:-5], file_name[:-5]) 
                    rooms_bgs_sections += '{}:\t\tINCBIN "gfx/rooms_bg/masks/{}"\r\n'.format(file_name[:-5], file_name)
            else:
                for mask_subid in range(mask["frames"]):
                    if mask_subid == 0:
                        rooms_bgs_masks_pointers += 'room{}_{}_{}_masks:\r\n'.format(
                            hex_room_id, hex_bg_id, mask_label
                        )
                    
                    base_filename = 'room{}_{}_mask_{}_{}'.format(
                        hex_room_id, hex_bg_id, str(mask_id).zfill(2), str(mask_subid).zfill(2)
                    )
                    file_name = '{}.2bpp'.format(base_filename)
                    f = open(os.path.join(source_bgs_dir, 'masks', file_name), "rb")
                    file_bin = f.read()
                    f.close()
                    
                    file_size = len(file_bin)
                    section_size += file_size

                    if section_size > 0x4000:
                        diff = file_size - (section_size - 0x4000)
                        # file part 1
                        file_part_1 = file_bin[:diff]
                        file_name_1 = '{}_p1.2bpp'.format(base_filename)
                        with open(os.path.join(target_bgs_masks_dir, file_name_1), 'wb') as w:
                            w.write(file_part_1)
                        # file part 2
                        file_part_2 = file_bin[diff:]
                        file_name_2 = '{}_p2.2bpp'.format(base_filename)
                        with open(os.path.join(target_bgs_masks_dir, file_name_2), 'wb') as w:
                            w.write(file_part_2)
                        # set new section size
                        section_size = (section_size - 0x4000)
                        rooms_bgs_masks_pointers += '\tdbw BANK({}), {}\r\n'.format(file_name_1[:-5], file_name_1[:-5]) 

                        bank_count += 1
                        bank_id += 1
                        rooms_bgs_sections += '{}:\tINCBIN "gfx/rooms_bg/masks/{}"\r\n'.format(
                            file_name_1[:-5], file_name_1)
                        rooms_bgs_sections += '\r\nSECTION "roomsBgBank{}",ROMX,BANK[${}]\r\n\r\n'.format(
                            bank_count, to_hex(bank_id))
                        rooms_bgs_sections += '{}:\tINCBIN "gfx/rooms_bg/masks/{}"\r\n'.format(
                            file_name_2[:-5], file_name_2)
                    else:
                        with open(os.path.join(target_bgs_masks_dir, file_name), 'wb') as w:
                            w.write(file_bin)
                        rooms_bgs_masks_pointers += '\tdbw BANK({}), {}\r\n'.format(file_name[:-5], file_name[:-5]) 
                        rooms_bgs_sections += '{}:\t\tINCBIN "gfx/rooms_bg/masks/{}"\r\n'.format(
                            file_name[:-5], file_name)
                

    # rooms bgs lut
    with open(os.path.join(output_dir, 'rooms_bg_lookup_table.asm'), 'w') as txt:
        txt.write(rooms_bgs_lut)

    # room bgs pointers
    with open(os.path.join(output_dir, 'rooms_bg_pointers.asm'), 'w') as txt:
        txt.write(rooms_bgs_pointers)

    # masks pointers
    with open(os.path.join(output_dir, 'rooms_bg_masks_pointers.asm'), 'w') as txt:
        txt.write(rooms_bgs_masks_pointers)

    # rooms bgs sections
    with open(os.path.join(output_dir, 'rooms_bgs_sections.asm'), 'w') as txt:
        txt.write(rooms_bgs_sections)


if __name__ == "__main__":
    main()