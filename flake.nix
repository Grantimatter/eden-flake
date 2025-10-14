{
  description = "Eden Emulator";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
  flake-utils.lib.eachDefaultSystem (system:
    let pkgs = nixpkgs.legacyPackages.${system}; in
    {
      packages = rec {
        eden = pkgs.qt6Packages.callPackage ./package.nix { };
        default = eden;
      };
    }
  ) // {
    homeModules.default = { config, pkgs, lib, ...}: import ./homeModule.nix { inherit config pkgs lib self; };
    nixosModules.default = { config, pkgs, lib, ...}: import ./nixosModule.nix { inherit config pkgs lib self; };
  };
}
