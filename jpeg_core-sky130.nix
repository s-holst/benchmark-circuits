{ pkgs      ? import <nixpkgs> {}
, librelane ? import ./support/librelane.nix { inherit pkgs; }
}:

let
  sky130-pdk = import ./support/sky130-pdk.nix { inherit pkgs; };
  circuit = "jpeg_core";
  clock_period = "30";
in

pkgs.stdenv.mkDerivation {
  pname = "jpeg_core-sky130";
  version = "1.0";

  src = pkgs.fetchzip {
    url = "https://github.com/ultraembedded/core_jpeg/archive/bb03cce45d0b7459d395486e9e1db3de1b416bd2.zip";
    sha256 = "US2V/5gE8Mz6zUn3zaxIoVanMrs2OY05GFmm/APiiMs=";
  };

  nativeBuildInputs = [ librelane ];

  dontConfigure = true;

  buildPhase = ''
    mkdir ${circuit}
    cat > ${circuit}/config.yaml << EOF
DESIGN_NAME: ${circuit}
VERILOG_FILES: [ $src/src_v/jpeg_core.v
,$src/src_v/jpeg_bitbuffer.v
,$src/src_v/jpeg_dht_std_cx_ac.v
,$src/src_v/jpeg_dht_std_cx_dc.v
,$src/src_v/jpeg_dht_std_y_ac.v
,$src/src_v/jpeg_dht_std_y_dc.v
,$src/src_v/jpeg_dht.v
,$src/src_v/jpeg_dqt.v
,$src/src_v/jpeg_idct_fifo.v
,$src/src_v/jpeg_idct_ram_dp.v
,$src/src_v/jpeg_idct_ram.v
,$src/src_v/jpeg_idct_transpose_ram.v
,$src/src_v/jpeg_idct_transpose.v
,$src/src_v/jpeg_idct_x.v
,$src/src_v/jpeg_idct_y.v
,$src/src_v/jpeg_idct.v
,$src/src_v/jpeg_input.v
,$src/src_v/jpeg_mcu_id.v
,$src/src_v/jpeg_mcu_proc.v
,$src/src_v/jpeg_output_cx_ram.v
,$src/src_v/jpeg_output_fifo.v
,$src/src_v/jpeg_output_y_ram.v
,$src/src_v/jpeg_output.v
]
CLOCK_PORT: clk_i
CLOCK_PERIOD: ${clock_period}
EOF
    librelane --manual-pdk --pdk-root ${sky130-pdk} --run-tag run ${circuit}/config.yaml
  '';

  installPhase = ''
    mkdir -p $out/${circuit}
    cp -r ${circuit}/runs/run/final/. $out/${circuit}/
  '';
}
