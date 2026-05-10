#!/usr/bin/env python3
import json, subprocess
from collections import defaultdict
data = json.loads(subprocess.check_output("nix flake show --json".split(), text=True))

merged_outs = defaultdict(dict)
for outs in data.get("packages", {}).values():
    for attr, info in outs.items():
        merged_outs[attr] |= info

rows = sorted(merged_outs.items())

print(f'| `<package>` | Circuit(s) | PDK |')
print(f'|---|---|---|')
for attr, info in rows:
    fields = info['description'].split(' implemented in ')
    circuits = fields[0]
    pdk = fields[1] if len(fields) > 1 else ''
    pdk = pdk.replace(' PDK','').replace('.','')
    if 'in bench format.' in circuits:
        circuits = circuits.replace(' in bench format.','')
        pdk = '(.bench)'
    elif 'in verilog format.' in circuits:
        circuits = circuits.replace(' in verilog format.','')
        pdk = '(.v)'
    print(f"| `{attr}` | {circuits} | {pdk} |")
