{ pkgs ? import <nixpkgs> {} }:

let
  librelane-src = fetchTarball {
    url = "https://github.com/librelane/librelane/archive/refs/tags/3.0.2.tar.gz";
    sha256 = "1v43adkw5c624nd06g11cb609v8pj3prfyyawbq3i4k1w1law597";
  };
in
  (import (
    let
      lock = builtins.fromJSON (builtins.readFile "${librelane-src}/flake.lock");
    in
    fetchTarball {
      url =
        lock.nodes.flake-compat.locked.url
          or "https://github.com/edolstra/flake-compat/archive/${lock.nodes.flake-compat.locked.rev}.tar.gz";
      sha256 = lock.nodes.flake-compat.locked.narHash;
    }
  ) { src = librelane-src; }).defaultNix.default
