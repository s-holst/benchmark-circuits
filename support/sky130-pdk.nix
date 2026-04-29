{ pkgs ? import <nixpkgs> {} }:

let
  version = "8afc8346a57fe1ab7934ba5a6056ea8b43078e71";

  fetchAsset = name: sha256: pkgs.fetchurl {
    url = "https://github.com/fossi-foundation/ciel-releases/releases/download/sky130-${version}/${name}.tar.zst";
    inherit sha256;
  };

  common          = fetchAsset "common"          "1gw67zf1ycjms51dqs5s7phgp6nqznsdf6j6ksppg4gx861m92my";
  sky130_fd_sc_hd = fetchAsset "sky130_fd_sc_hd" "07nfwi0v8ki5pg0bwbmv7cm9piz7z75vhq1ryldq8c7zrw2pa10p";
in

pkgs.stdenv.mkDerivation {
  name = "sky130-pdk-${version}";

  dontUnpack = true;
  dontConfigure = true;
  dontBuild = true;

  nativeBuildInputs = [ pkgs.zstd ];

  installPhase = ''
    mkdir -p $out
    zstd -d -c ${common}          | tar -x -C $out
    zstd -d -c ${sky130_fd_sc_hd} | tar -x -C $out
  '';
}
