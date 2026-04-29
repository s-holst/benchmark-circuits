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
|------------|---------------------|
| polito-itc99-bench | All synthesized ITC'99 benchmarks in bench format ([copy of non-optimized original](https://github.com/cad-polito-it/I99T)) |
| polito-itc99-sky130.{b01, b03, b04, b05, b06, b07, b09, b10, b11, b12, b13, b14} | Results from SKY130 flow (netlist, layout, parasitics, ...) for specific circuit based on [RTL designs written in VHDL](https://github.com/cad-polito-it/I99T) |
polito-itc99-sky130 | Design data for all above circuits combined |
