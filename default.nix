{
  pkgs ? import <nixpkgs> {},
  # system ? pkgs.stdenv.hostPlatform.system,
}:
pkgs.qt6Packages.callPackage ./package.nix { }
  

