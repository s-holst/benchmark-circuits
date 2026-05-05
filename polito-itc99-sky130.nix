{ pkgs      ? import <nixpkgs> {}
, librelane ? import ./support/librelane.nix { inherit pkgs; }
, circuit   ? "b01"
, clock_period ? "3"
}:

let
  sky130-pdk = import ./support/sky130-pdk.nix { inherit pkgs; };
in

pkgs.stdenv.mkDerivation {
  name = "polito-itc99-${circuit}-sky130";
  meta.description = "ITC'99 benchmark ${circuit} implemented in Skywater 130nm PDK.";
  src = pkgs.fetchzip {
    url = "https://github.com/cad-polito-it/I99T/archive/refs/tags/v2.tar.gz";
    sha256 = "0x0gal45vj0i17wgdnn27jf3xmhr1kkdwrsi04p5qhjz6hm7c22y";
  };

  nativeBuildInputs = [ librelane ];

  dontConfigure = true;

  buildPhase = ''
    mkdir ${circuit}
    cat > ${circuit}/config.yaml << EOF
DESIGN_NAME: ${circuit}
VHDL_FILES: [ $src/i99t/${circuit}/${circuit}.vhd ]
CLOCK_PORT: clock
CLOCK_PERIOD: ${clock_period}
GHDL_ARGUMENTS: [ -fsynopsys ]
EOF
    librelane --flow VHDLClassic --manual-pdk --pdk-root ${sky130-pdk} --run-tag run ${circuit}/config.yaml
  '';

  installPhase = ''
    mkdir -p $out/${circuit}
    cp -r ${circuit}/runs/run/final/. $out/${circuit}/
  '';
}
