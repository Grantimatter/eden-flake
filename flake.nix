{
  description = "Eden Emulator";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }:
  let
    forAllSystems = f:
      nixpkgs.lib.genAttrs ["x86_64-linux"] (
        system: f nixpkgs.legacyPackages.${system}
    );
  in
  {
    nixosModules.eden = import ./default.nix;
    nixosModules.default = self.nixosModules.eden;
    packages = forAllSystems (pkgs: import ./default.nix {inherit pkgs;});
  };
}
