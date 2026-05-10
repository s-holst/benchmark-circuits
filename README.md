# Gate-Level Benchmark Circuits

[Nix](https://nixos.org) derivations for common digital logic gate-level benchmark circuits used in VLSI research in bench or verilog format.
No need to clone this repo unless you want to make changes.
The flake published here gives access the benchmarks directly by calling:
```
nix build github:s-holst/benchmark-circuits#<package>
```
with `<package>` from the table below.
This will create a `result` link to the data in the current directory.
In Python scripts, use:
```py
import os

benchmark_path = os.popen('nix build github:s-holst/benchmark-circuits#<package> --no-link --print-out-paths').read().strip()
```
to get a path to the benchmark data of `<package>`.

| `<package>` | Circuit(s) | PDK |
|---|---|---|
| `default` | All ITC'99 benchmarks | (.bench) |
| `epfl-arithmetic-all` | EPFL combinational arithmetic benchmarks | (.v) |
| `epfl-control-all` | EPFL combinational random_control benchmarks | (.v) |
| `epfl-mtm-all` | EPFL combinational mtm benchmarks | (.v) |
| `iwls-faraday-all-gsclib` | All IWLS'05 faraday benchmarks | GSCLib |
| `iwls-gaisler-all-gsclib` | All IWLS'05 gaisler benchmarks | GSCLib |
| `iwls-iscas-all-gsclib` | All IWLS'05 iscas benchmarks | GSCLib |
| `iwls-itc99-all-gsclib` | All IWLS'05 itc99 benchmarks | GSCLib |
| `iwls-opencores-all-gsclib` | All IWLS'05 opencores benchmarks | GSCLib |
| `jpeg_core-sky130` | A [JPEG decoder](https://github.com/ultraembedded/core_jpeg) | Skywater 130nm |
| `picorv32-sky130` | A [PicoRV32](https://github.com/YosysHQ/picorv32) core | Skywater 130nm |
| `polito-itc99-all-bench` | All ITC'99 benchmarks | (.bench) |
| `polito-itc99-all-sky130` | All ITC'99 benchmarks | Skywater 130nm |
| `polito-itc99-b01-sky130` | ITC'99 benchmark b01 | Skywater 130nm |
| `polito-itc99-b03-sky130` | ITC'99 benchmark b03 | Skywater 130nm |
| `polito-itc99-b04-sky130` | ITC'99 benchmark b04 | Skywater 130nm |
| `polito-itc99-b05-sky130` | ITC'99 benchmark b05 | Skywater 130nm |
| `polito-itc99-b06-sky130` | ITC'99 benchmark b06 | Skywater 130nm |
| `polito-itc99-b07-sky130` | ITC'99 benchmark b07 | Skywater 130nm |
| `polito-itc99-b09-sky130` | ITC'99 benchmark b09 | Skywater 130nm |
| `polito-itc99-b10-sky130` | ITC'99 benchmark b10 | Skywater 130nm |
| `polito-itc99-b11-sky130` | ITC'99 benchmark b11 | Skywater 130nm |
| `polito-itc99-b12-sky130` | ITC'99 benchmark b12 | Skywater 130nm |
| `polito-itc99-b13-sky130` | ITC'99 benchmark b13 | Skywater 130nm |
| `polito-itc99-b14-sky130` | ITC'99 benchmark b14 | Skywater 130nm |
| `polito-itc99-b15-sky130` | ITC'99 benchmark b15 | Skywater 130nm |
| `polito-itc99-b17-sky130` | ITC'99 benchmark b17 | Skywater 130nm |
| `polito-itc99-b18-sky130` | ITC'99 benchmark b18 | Skywater 130nm |
| `polito-itc99-b19-sky130` | ITC'99 benchmark b19 | Skywater 130nm |
| `polito-itc99-b20-sky130` | ITC'99 benchmark b20 | Skywater 130nm |
| `polito-itc99-b21-sky130` | ITC'99 benchmark b21 | Skywater 130nm |
| `polito-itc99-b22-sky130` | ITC'99 benchmark b22 | Skywater 130nm |

Data sources:
- `polito-itc99-*`: https://github.com/cad-polito-it/I99T
- `iwls-*`: https://iwls.org/iwls2005/benchmarks.html
- `epfl-*`: https://www.epfl.ch/labs/lsi/page-102566-en-html/benchmarks/


Circuits are either in bench format or in Verilog.
Bench and GSCLib benchmarks are copied directly from the original data sources.
[Skywater 130nm PDK](https://skywater-pdk.readthedocs.io/en/main/) versions are synthesized using [LibreLane](https://librelane.readthedocs.io/en/stable/) classic flow and include full design data (mapped netlist, layout (GDS, DEF), timing, parasitics, ...).
These are synthesized on-demand, it may take some time for bigger circuits.
To avoid re-building the whole toolchain from scratch, enable the [nix-eda](https://github.com/fossi-foundation/nix-eda) cache using [these](https://github.com/fossi-foundation/nix-eda/blob/main/docs/installation.md) or [these](https://librelane.readthedocs.io/en/stable/installation/nix_installation/index.html) instructions.


