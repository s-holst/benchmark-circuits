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
  meta.description = "A tiny RV32 core (https://github.com/YosysHQ/picorv32) implemented in Skywater 130nm PDK.";
  src = pkgs.fetchzip {
    url = "https://github.com/YosysHQ/picorv32/archive/refs/tags/v1.0.tar.gz";
    sha256 = "22rJ2IxtRL7wcA38u5WdMeEbc5s4aSw6Do/9tNYAu8g=";
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
