import re

def find_duplicates(file_path):
    with open(file_path, 'r', encoding='utf-8') as f:
        content = f.read()
    
    # Find maps (en: { ... }, kn: { ... })
    maps = re.findall(r"'(\w+)':\s*\{", content)
    for lang in maps:
        start_idx = content.find(f"'{lang}':")
        # Find the closing brace for this map (simple brace counting)
        brace_count = 0
        found_start = False
        map_content = ""
        for i in range(start_idx, len(content)):
            if content[i] == '{':
                brace_count += 1
                found_start = True
            elif content[i] == '}':
                brace_count -= 1
            
            if found_start:
                map_content += content[i]
                if brace_count == 0:
                    break
        
        # Find all keys in this map_content
        keys = re.findall(r"'(\w+)':", map_content)
        seen = set()
        dupes = []
        for k in keys:
            if k in seen:
                dupes.append(k)
            seen.add(k)
        if dupes:
            print(f"Duplicates in {lang}: {dupes}")

find_duplicates('lib/services/localization_service.dart')
