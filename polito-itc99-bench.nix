{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation {
  pname = "polito-itc99-bench";
  version = "2.0";
  src = pkgs.fetchzip {
    url = "https://github.com/cad-polito-it/I99T/archive/refs/tags/v2.tar.gz";
    sha256 = "0x0gal45vj0i17wgdnn27jf3xmhr1kkdwrsi04p5qhjz6hm7c22y";
  };

  dontBuild = true;

  installPhase = ''
    mkdir -p $out
    find $src -name "*.bench" ! -name "*_C*" ! -name "*_opt*" -exec cp {} $out/ \;
  '';
}
