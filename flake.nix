{
  description = "Eden Emulator";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
  flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = nixpkgs.legacyPackages.${system};
      edenPkg = pkgs.callPackage ./package.nix { };
    in
  {
    packages.default = edenPkg;
  }
  ) // {
    # overlays.default = final: prev: {
    #   eden = self.packages.${final.system}.default;
    # };
    nixosModules.default = { config, pkgs, ...}: import ./package.nix {inherit config pkgs self; };
    # nixosModules.eden = import ./default.nix;
    # nixosModules.default = self.nixosModules.eden;
    # packages = forAllSystems (pkgs: import ./default.nix {inherit pkgs;});

    # # nixosModules = {
    # #   default = self.packages."x86_64-linux";
    # # };
    # packages.default
  };
}
