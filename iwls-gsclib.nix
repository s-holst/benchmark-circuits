{ pkgs ? import <nixpkgs> {},
  subset,
}:

pkgs.stdenv.mkDerivation {
  name = "iwls-${subset}-all-gsclib";
  meta.description = "All IWLS'05 ${subset} benchmarks implemented in GSCLib.";
  src = pkgs.fetchzip {
    url = "http://iwls.org/iwls2005/IWLS_2005_benchmarks_V_1.0.tgz";
    sha256 = "Bh0gOx/1N4NryYnpBIfikK8bteX5msWiQ7kB4acepMw=";
  };

  dontBuild = true;

  installPhase = if subset == "gsclib" then ''
    mkdir -p $out
    cp $src/library/* $out/
  '' else ''
    mkdir -p $out
    find $src/${subset}/netlist -name "*.v" -exec cp {} $out/ \;
  '';
}
