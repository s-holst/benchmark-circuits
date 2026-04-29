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
            # b18 = "10";
            # b19 = "10";
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
        in {
          polito-itc99-bench  = import ./polito-itc99-bench.nix { inherit pkgs; };
          polito-itc99-sky130 = pkgs.symlinkJoin {
            name  = "polito-itc99-sky130";
            paths = builtins.attrValues circuitPkgs;
          } // circuitPkgs;
          default = self.packages.${system}.polito-itc99-bench;
        }
      );
    };
}
