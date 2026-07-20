{
  description = "Collection of benchmark circuit packages";

  inputs = {
    nixpkgs.url   = "github:NixOS/nixpkgs/nixos-unstable";
    librelane.url = "github:librelane/librelane/3.0.2";
  };

  outputs = { self, nixpkgs, librelane }:
    let
      systems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
      forAllSystems = nixpkgs.lib.genAttrs systems;
    in {
      packages = forAllSystems (system:
        let
          pkgs          = nixpkgs.legacyPackages.${system};
          librelane-pkg = librelane.packages.${system}.default;

          # Each circuit maps to its clock configuration: the clock period and
          # the name of the clock port on the design.
          circuits = {
            b01 = { clock_period = "5";  clock_port = "clock"; };
            # b02: too small
            b03 = { clock_period = "3";  clock_port = "clock"; };
            b04 = { clock_period = "3";  clock_port = "CLOCK"; };
            b05 = { clock_period = "3";  clock_port = "CLOCK"; };
            b06 = { clock_period = "4";  clock_port = "clock"; };
            b07 = { clock_period = "3";  clock_port = "clock"; };
            # b08.vhd:69:40:error: unhandled dyn operation: IIR_PREDEFINED_TF_ARRAY_NOT
            b09 = { clock_period = "3";  clock_port = "clock"; };
            b10 = { clock_period = "3";  clock_port = "clock"; };
            b11 = { clock_period = "4";  clock_port = "clock"; };
            b12 = { clock_period = "4";  clock_port = "clock"; };
            b13 = { clock_period = "3";  clock_port = "clock"; };
            b14 = { clock_period = "10"; clock_port = "clock"; };
            b15 = { clock_period = "10"; clock_port = "CLOCK"; };
            b17 = { clock_period = "10"; clock_port = "CLOCK"; };
            b18 = { clock_period = "20"; clock_port = "clock"; };
            b19 = { clock_period = "20"; clock_port = "clock"; };
            b20 = { clock_period = "15"; clock_port = "clock"; };
            b21 = { clock_period = "15"; clock_port = "clock"; };
            b22 = { clock_period = "15"; clock_port = "clock"; };
          };

          mkCircuit = circuit: cfg:
            import ./polito-itc99-sky130.nix ({
              inherit pkgs circuit;
              librelane = librelane-pkg;
            } // cfg);

          circuitPkgs = builtins.mapAttrs mkCircuit circuits;

          individualPkgs = builtins.listToAttrs (
            builtins.map (name: {
              name  = "polito-itc99-${name}-sky130";
              value = circuitPkgs.${name};
            }) (builtins.attrNames circuitPkgs)
          );
        in {
          polito-itc99-all-sky130 = pkgs.symlinkJoin {
            name  = "polito-itc99-all-sky130";
            paths = builtins.attrValues circuitPkgs;
            meta.description = "All ITC'99 benchmarks implemented in Skywater 130nm PDK.";
          };
          polito-itc99-all-bench  = import ./polito-itc99-bench.nix { inherit pkgs; };
          default = self.packages.${system}.polito-itc99-all-bench;

          picorv32-sky130 = import ./picorv32-sky130.nix { inherit pkgs; librelane = librelane-pkg; };
          jpeg_core-sky130 = import ./jpeg_core-sky130.nix { inherit pkgs; librelane = librelane-pkg; };

          iwls-faraday-all-gsclib = import ./iwls-gsclib.nix { inherit pkgs; subset = "faraday"; };
          iwls-gaisler-all-gsclib = import ./iwls-gsclib.nix { inherit pkgs; subset = "gaisler"; };
          iwls-iscas-all-gsclib = import ./iwls-gsclib.nix { inherit pkgs; subset = "iscas"; };
          iwls-itc99-all-gsclib = import ./iwls-gsclib.nix { inherit pkgs; subset = "itc99"; };
          iwls-opencores-all-gsclib = import ./iwls-gsclib.nix { inherit pkgs; subset = "opencores"; };
          iwls-gsclib = import ./iwls-gsclib.nix { inherit pkgs; subset = "gsclib"; };
          epfl-arithmetic-all = import ./epfl-verilog.nix { inherit pkgs; subset = "arithmetic"; };
          epfl-control-all = import ./epfl-verilog.nix { inherit pkgs; subset = "random_control"; };
          epfl-mtm-all = import ./epfl-verilog.nix { inherit pkgs; subset = "mtm"; };
          sky130-pdk = import ./support/sky130-pdk.nix { inherit pkgs; };
        } // individualPkgs
      );
    };
}
