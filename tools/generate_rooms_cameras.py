import os
from helpers import load_json, to_hex

def main():

    root_path = os.path.abspath('.')
    source_dir = os.path.join(root_path, 'data/json_data/rooms')
    output_dir = os.path.join(root_path, 'data/rooms/')

    cameras_json = load_json(os.path.join(source_dir, 'cameras.json'))

    cameras_output = """; rooms background cameras
;
; 18 bytes for each camera
;
; byte header: room cameras count
; camera struct:
;  - 0: camera x position
;  - 1: camera y position
;  - 2: camera z position
;  - 3: camera yaw angle
;  - 4: camera pitch angle
;  - 5: camera tx position
;  - 6: camera ty position
;  - 7: camera tz position
;  - 8: camera facing
;  - 9: camera type
; terminator byte ($FF) unused

"""

    cameras_lut_output = """
roomsBgCamerasLookupTable:
"""

    camera_facings = {
        0: "CAM_FACE_SOUTH",
        4: "CAM_FACE_SOUTH_WEST",
        8: "CAM_FACE_WEST",
        12: "CAM_FACE_NORTH_WEST",
        16: "CAM_FACE_NORTH",
        20: "CAM_FACE_NORTH_EAST",
        24: "CAM_FACE_EAST",
        28: "CAM_FACE_SOUTH_EAST"
    }

    camera_types = {
        0: "NORMAL_CAM",
        1: "OVERHEAD_CAM"
    }

    print("generating rooms cameras")

    for room_id, cameras in enumerate(cameras_json):
        hex_room_id = to_hex(room_id)
        cameras_output += "room{}_cameras:\r\n".format(hex_room_id)
        cameras_count = len(cameras)
        if room_id == 5:
            cameras_count = 6
        cameras_output += "db {}\r\n".format(cameras_count)
        for cam in cameras:
            cam_type = camera_types[cam["type"]]
            cam_facing = camera_facings[cam["facing"]]
            cameras_output += "\tcam {}, {}, {}, {}, {}, {}, {}, {}, {}, {}\r\n".format(
                    cam["x"],
                    cam["y"],
                    cam["z"],
                    cam["yaw"],
                    cam["pitch"],
                    cam["tx"],
                    cam["ty"],
                    cam["tz"],
                    cam_facing,
                    cam_type
                )
        cameras_output += "db $FF\r\n\r\n"
        cameras_lut_output += "\tdw room{}_cameras\r\n".format(hex_room_id)

    with open(os.path.join(output_dir, 'rooms_bgs_cameras.asm'), 'w') as txt:
        txt.write(cameras_output)

    with open(os.path.join(output_dir, 'rooms_bgs_cameras_lookup_table.asm'), 'w') as txt:
        txt.write(cameras_lut_output)


if __name__ == "__main__":
    main()