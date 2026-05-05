# benchmark-circuits

Nix derivations for obtaining common benchmarks used in VLSI research.

Includes plain synthesized gate-level netlists (bench format) as well as full design data (mapped netlist, layout, timing, parasitics, ...) results from the [LibreLane](https://librelane.readthedocs.io/en/stable/) classic flow using the [SkyWater SKY130 PDK](https://skywater-pdk.readthedocs.io/en/main/).

The sky130 versions use LibreLane.
To avoid rebuilding the whole toolchain from scratch, enable the [nix-eda](https://github.com/fossi-foundation/nix-eda) cache using [these instructions from LibreLane](https://librelane.readthedocs.io/en/stable/installation/nix_installation/index.html).

## Usage

No need to clone this repo if you don't want to make changes. Call:

``nix build github:s-holst/benchmark-circuits#<package>``

to generate a `result` directory with the requested benchmark data.

## Packages

| `<package>` | Description |
|---|---|
| default                 | All ITC'99 benchmarks in bench format.                                                         |
| jpeg_core-sky130        | A JPEG decoder (https://github.com/ultraembedded/core_jpeg) implemented in Skywater 130nm PDK. |
| picorv32-sky130         | A tiny RV32 core (https://github.com/YosysHQ/picorv32) implemented in Skywater 130nm PDK.      |
| polito-itc99-all-bench  | All ITC'99 benchmarks in bench format.                                                         |
| polito-itc99-all-sky130 | All ITC'99 benchmarks implemented in Skywater 130nm PDK.                                       |
| polito-itc99-b01-sky130 | ITC'99 benchmark b01 implemented in Skywater 130nm PDK.                                        |
| polito-itc99-b03-sky130 | ITC'99 benchmark b03 implemented in Skywater 130nm PDK.                                        |
| polito-itc99-b04-sky130 | ITC'99 benchmark b04 implemented in Skywater 130nm PDK.                                        |
| polito-itc99-b05-sky130 | ITC'99 benchmark b05 implemented in Skywater 130nm PDK.                                        |
| polito-itc99-b06-sky130 | ITC'99 benchmark b06 implemented in Skywater 130nm PDK.                                        |
| polito-itc99-b07-sky130 | ITC'99 benchmark b07 implemented in Skywater 130nm PDK.                                        |
| polito-itc99-b09-sky130 | ITC'99 benchmark b09 implemented in Skywater 130nm PDK.                                        |
| polito-itc99-b10-sky130 | ITC'99 benchmark b10 implemented in Skywater 130nm PDK.                                        |
| polito-itc99-b11-sky130 | ITC'99 benchmark b11 implemented in Skywater 130nm PDK.                                        |
| polito-itc99-b12-sky130 | ITC'99 benchmark b12 implemented in Skywater 130nm PDK.                                        |
| polito-itc99-b13-sky130 | ITC'99 benchmark b13 implemented in Skywater 130nm PDK.                                        |
| polito-itc99-b14-sky130 | ITC'99 benchmark b14 implemented in Skywater 130nm PDK.                                        |
| polito-itc99-b15-sky130 | ITC'99 benchmark b15 implemented in Skywater 130nm PDK.                                        |
| polito-itc99-b17-sky130 | ITC'99 benchmark b17 implemented in Skywater 130nm PDK.                                        |
| polito-itc99-b18-sky130 | ITC'99 benchmark b18 implemented in Skywater 130nm PDK.                                        |
| polito-itc99-b19-sky130 | ITC'99 benchmark b19 implemented in Skywater 130nm PDK.                                        |
| polito-itc99-b20-sky130 | ITC'99 benchmark b20 implemented in Skywater 130nm PDK.                                        |
| polito-itc99-b21-sky130 | ITC'99 benchmark b21 implemented in Skywater 130nm PDK.                                        |
| polito-itc99-b22-sky130 | ITC'99 benchmark b22 implemented in Skywater 130nm PDK.                                        |


ITC'99 benchmarks are based on [data published by PoliTo](https://github.com/cad-polito-it/I99T).
