def check_dupes(file_path):
    with open(file_path, 'r', encoding='utf-8') as f:
        lines = f.readlines()
    
    current_map = None
    keys = {}
    for i, line in enumerate(lines):
        if "'en': {" in line:
            current_map = 'en'
            keys[current_map] = []
        elif "'kn': {" in line:
            current_map = 'kn'
            keys[current_map] = []
        elif "'hi': {" in line:
            current_map = 'hi'
            keys[current_map] = []
        
        if current_map and "':" in line:
            key = line.split("':")[0].strip().strip("'")
            if key in keys[current_map]:
                print(f"Duplicate key '{key}' in {current_map} map at line {i+1}")
            keys[current_map].append(key)

check_dupes('lib/services/localization_service.dart')
