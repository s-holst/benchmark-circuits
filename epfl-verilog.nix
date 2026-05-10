{ pkgs ? import <nixpkgs> {},
  subset,
}:

pkgs.stdenv.mkDerivation {
  name = "epfl-${subset}-all";
  meta.description = "EPFL combinational ${subset} benchmarks in verilog format.";
  src = if subset == "mtm" then pkgs.fetchzip {
    url = "https://zenodo.org/records/2572934/files/EPFL_complete.tar.gz?download=1";
    sha256 = "8qZ4HJ+O5S8v7RhTWmymeAcPmJZIBB1JzGdbJqlHuuQ=";
    stripRoot = false;
  } else pkgs.fetchzip {
    url = "https://github.com/lsils/benchmarks/archive/refs/tags/v2025.1.zip";
    sha256 = "+UuoENpq4GL2e7KpBo46JlGMQu+jrLvJKGMHJIIuYN4=";
  };

  dontBuild = true;

  installPhase = ''
    mkdir -p $out
    find $src/${if subset == "mtm" then "EPFLfull/MtM" else subset} -name "*.v" -exec cp {} $out/ \;
  '';
}
