
import json

def load_json(path):
    return json.load(open(path))

def to_hex(value):
    return hex(value)[2:].zfill(2).upper()