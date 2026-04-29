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
          pkgs         = nixpkgs.legacyPackages.${system};
          librelane-pkg = librelane.packages.${system}.default;
        in {
          polito-itc99-bench  = import ./polito-itc99-bench.nix  { inherit pkgs; };
          polito-itc99-sky130 = import ./polito-itc99-sky130.nix { inherit pkgs; librelane = librelane-pkg; };
          default             = self.packages.${system}.polito-itc99-bench;
        }
      );
    };
}
