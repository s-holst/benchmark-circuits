{ pkgs      ? import <nixpkgs> {}
, librelane ? import ./support/librelane.nix { inherit pkgs; }
}:

let
  sky130-pdk = import ./support/sky130-pdk.nix { inherit pkgs; };
  circuit = "picorv32";
  clock_period = "20";
in

pkgs.stdenv.mkDerivation {
  name = "picorv32-sky130";
  meta.description = "A [PicoRV32](https://github.com/YosysHQ/picorv32) core implemented in Skywater 130nm PDK.";
  src = pkgs.fetchzip {
    url = "https://github.com/s-holst/picorv32/archive/ea66cd27f1c84f26bdcf75ea6f9de442a3fd78e8.zip";
    sha256 = "GvKa6o8O8rE1qsbsjky3ZT6I4blUIMZNb0UWyv/gqyw=";
  };

  nativeBuildInputs = [ librelane ];

  dontConfigure = true;

  buildPhase = ''
    mkdir ${circuit}
    cat > ${circuit}/config.yaml << EOF
DESIGN_NAME: ${circuit}
VERILOG_FILES: [ $src/${circuit}.v ]
CLOCK_PORT: clk
CLOCK_PERIOD: ${clock_period}
EOF
    librelane --manual-pdk --pdk-root ${sky130-pdk} --run-tag run ${circuit}/config.yaml
  '';

  installPhase = ''
    mkdir -p $out/${circuit}
    cp -r ${circuit}/runs/run/final/. $out/${circuit}/
  '';
}
