{ pkgs ? import <nixpkgs> {} }:

let
  sky130-pdk = import ./support/sky130-pdk.nix { inherit pkgs; };
  librelane  = import ./support/librelane.nix  { inherit pkgs; };
in

pkgs.stdenv.mkDerivation {
  pname = "polito-itc99-sky130";
  version = "2.0";

  src = pkgs.fetchzip {
    url = "https://github.com/cad-polito-it/I99T/archive/refs/tags/v2.tar.gz";
    sha256 = "0x0gal45vj0i17wgdnn27jf3xmhr1kkdwrsi04p5qhjz6hm7c22y";
  };

  nativeBuildInputs = [ librelane ];

  dontConfigure = true;

  buildPhase = ''
    mkdir b01
    cat > b01/config.yaml << EOF
DESIGN_NAME: b01
VHDL_FILES: [ $src/i99t/b01/b01.vhd ]
CLOCK_PORT: clock
CLOCK_PERIOD: 10
EOF
    librelane --flow VHDLClassic --manual-pdk --pdk-root ${sky130-pdk} --run-tag run b01/config.yaml
  '';

  installPhase = ''
    mkdir -p $out/b01
    cp -r b01/runs/run/final/. $out/b01/
  '';
}
