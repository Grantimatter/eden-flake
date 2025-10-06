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
      edenPkg = pkgs.qt6Packages.callPackage ./package.nix { };
    in
  {
    packages.default = edenPkg;
  }
  ) // {
    homeModules.default = { config, pkgs, lib, ...}: import ./module.nix {inherit config pkgs lib self; };
    
    # overlays.default = final: prev: {
    #   eden = self.packages.${final.system}.default;
    # };
    # nixosModules.default = { pkgs, ...}: import ./default.nix {inherit pkgs; };
    # nixosModules.eden = import ./default.nix;
    # nixosModules.default = self.nixosModules.eden;
    # packages = forAllSystems (pkgs: import ./default.nix {inherit pkgs;});

    # # nixosModules = {
    # #   default = self.packages."x86_64-linux";
    # # };
    # packages.default
  };
}
