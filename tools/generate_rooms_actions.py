import os
from helpers import load_json, to_hex

def main():

    root_path = os.path.abspath('.')
    source_dir = os.path.join(root_path, 'data/json_data')
    output_dir = os.path.join(root_path, 'data/rooms/')

    actions_data = load_json(os.path.join(source_dir, 'rooms/rooms_actions_and_entities.json'))
    doors_data = load_json(os.path.join(source_dir, 'rooms/doors_data.json'))
    rooms = load_json(os.path.join(source_dir, 'rooms/rooms.json'))

    doors_types = load_json(os.path.join(source_dir, 'consts/doors_types.json'))
    doors_pals = load_json(os.path.join(source_dir, 'consts/doors_palettes.json'))
    tilemap_doors = load_json(os.path.join(source_dir, 'consts/tilemap_doors_types.json'))
    items = load_json(os.path.join(source_dir, 'consts/items.json'))
    rooms_items = load_json(os.path.join(source_dir, 'consts/rooms_items.json'))
    chars_and_enemies = load_json(os.path.join(source_dir, 'consts/chars_and_enemies.json'))
    objects_entities = load_json(os.path.join(source_dir, 'consts/objects_entities.json'))
    objects_var_ids = load_json(os.path.join(source_dir, 'consts/objects_var_ids.json'))

    actions_output = """; rooms actions and entities data
;

"""

    actions_table_output = """roomsActionsDatatable:
"""

    doors_table_output = """doorsIdsTable:
"""

    facing_const = {
        0x00: 'FACING_NORTH',
        0x04: 'FACING_NORTH_WEST',
        0x08: 'FACING_WEST',
        0x0C: 'FACING_SOUTH_WEST',
        0x10: 'FACING_SOUTH',
        0x14: 'FACING_SOUTH_EAST',
        0x18: 'FACING_EAST',
        0x1C: 'FACING_NORTH_EAST',
        0x80: 128
    }

    print("generating doors table")

    doors_dict = {}
    door_id = -1
    prev_door = ""
    for door in doors_data:
        doors_dict[door["label"]] = door
        if door["target"]["door_label"] == 0:
            continue
        elif door["target"]["door_label"] != prev_door:
            door_id += 1
        # adjacent conected doors, share the same door id
        doors_table_output += "\tdw {}, DOOR_{}\r\n".format(door["label"], to_hex(door_id))
        prev_door = door["label"]
    doors_table_output += "\tdw 0 ; if the search reach here, the game stucks\r\n"


    print("generating rooms items sprites table")

    for room_id, room_actions in enumerate(actions_data):

        actions_output += "room{}_actions:\r\n".format(to_hex(room_id))
        actions_table_output += "\tdw room{}_actions\r\n".format(to_hex(room_id))

        for data in room_actions:
            if data["type"] == "door":
                door_label = data["door_label"]
                door_data = doors_dict[door_label]

                actions_output += "{}:\r\n".format(door_label)
                if door_data["type"] == "sprite_door":
                    actions_output += "\tdoorType {}, {}\r\n".format(
                        doors_types[door_data["type_id"]],
                        doors_pals[door_data["palette_id"]]
                    )
                else:
                    actions_output += "\tdoorType {}\r\n".format(tilemap_doors[door_data["type_id"]])
                target = door_data["target"]
                room_cost = rooms[target["room_id"]]
                actions_output += "\tdoorTarget {}, {}\r\n".format(room_cost, target["door_label"])
                player_pos = door_data["player_position"]
                actions_output += "\tplayerPosition {}, {}, {}\r\n".format(
                    player_pos["x"],
                    player_pos["y"],
                    facing_const[player_pos["facing_id"]]
                )
                actions_output += "\r\n"

            elif data["type"] == "check_action" or data["type"] == "on_floor_action":
                if data["type"] == "check_action":
                    actions_output += "\tcheckAction\r\n"
                elif data["type"] == "on_floor_action":
                    actions_output += "\tcheckOnFloorAction\r\n"
                else:
                    raise Exception("Unknown action")
                if data["check_type"] == "pick_item":
                    actions_output += "\tpickItem {}, {}\r\n".format(
                        rooms_items[data["room_item_id"]],
                        items[data["item_id"]],
                    )
                elif data["check_type"] == "normal_action":
                    actions_output += "\troomInteraction {}\r\n".format(
                        data["action_id"]
                    )
                else:
                    raise Exception("Unknown check action")
                player_pos = data["player_position"]
                actions_output += "\tplayerPosition {}, {}, {}\r\n".format(
                    player_pos["x"],
                    player_pos["y"],
                    facing_const[player_pos["facing_id"]]
                )
                actions_output += "\r\n"

            elif data["type"] in ["typewriter", "itembox"]:
                if data["type"] == "typewriter":
                    actions_output += "\ttypewriterAction\r\n"
                elif data["type"] == "itembox":
                    actions_output += "\titemboxAction\r\n"
                else:
                    raise Exception("Unknown action")
                player_pos = data["player_position"]
                actions_output += "\tplayerPosition {}, {}, {}\r\n".format(
                    player_pos["x"],
                    player_pos["y"],
                    facing_const[player_pos["facing_id"]]
                )
                actions_output += "\r\n"

            elif data["type"] == "entity":
                if data["entity_id"] < 0xE0:
                    entity_name = chars_and_enemies[data["entity_id"] - 0x92]
                    entity_var_id = data["entity_var_id"]
                else:
                    entity_name = objects_entities[data["entity_id"] - 0xE0]
                    entity_var_id = objects_var_ids[data["entity_var_id"] - 0xEC]
                actions_output += "\troomEntity {}, {}\r\n".format(
                    entity_name, entity_var_id
                )
                entity_pos = data["entity_position"]
                actions_output += "\troomEntityPos {}, {}, {}\r\n".format(
                    entity_pos["x"],
                    entity_pos["y"],
                    facing_const[entity_pos["facing_id"]]
                )
                actions_output += "\r\n"
                
        actions_output += "\tendRoomActions\r\n\r\n"



    with open(os.path.join(output_dir, 'rooms_actions_and_entities.asm'), 'w') as txt:
        txt.write(actions_output)

    with open(os.path.join(output_dir, 'rooms_actions_and_entities_table.asm'), 'w') as txt:
        txt.write(actions_table_output)

    with open(os.path.join(output_dir, 'doors_ids_table.asm'), 'w') as txt:
        txt.write(doors_table_output)


if __name__ == "__main__":
    main()