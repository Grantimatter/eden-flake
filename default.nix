{ pkgs }:
rec {
  eden = pkgs.qt6Packages.callPackage ./package.nix { };
  default = eden;
}
