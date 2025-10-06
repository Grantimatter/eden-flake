{
  pkgs ? import <nixpkgs> {},
  system ? pkgs.stdenv.hostPlatform.system,
}:
rec {
  eden = pkgs.qt6Packages.callPackage ./package.nix { };
  default = eden;
}
