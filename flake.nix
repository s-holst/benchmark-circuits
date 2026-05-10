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

          circuits = {
            b01 = "5";
            # b02: too small
            b03 = "3";
            b04 = "3";
            b05 = "3";
            b06 = "4";
            b07 = "3";
            # b08.vhd:69:40:error: unhandled dyn operation: IIR_PREDEFINED_TF_ARRAY_NOT
            b09 = "3";
            b10 = "3";
            b11 = "4";
            b12 = "4";
            b13 = "3";
            b14 = "10";
            b15 = "10";
            b17 = "10";
            b18 = "20";
            b19 = "20";
            b20 = "15";
            b21 = "15";
            b22 = "15";
          };

          mkCircuit = circuit: clock_period:
            import ./polito-itc99-sky130.nix {
              inherit pkgs circuit clock_period;
              librelane = librelane-pkg;
            };

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
          epfl-arithmetic-all = import ./epfl-verilog.nix { inherit pkgs; subset = "arithmetic"; };
          epfl-control-all = import ./epfl-verilog.nix { inherit pkgs; subset = "random_control"; };
          epfl-mtm-all = import ./epfl-verilog.nix { inherit pkgs; subset = "mtm"; };
        } // individualPkgs
      );
    };
}
