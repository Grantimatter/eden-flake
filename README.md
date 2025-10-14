# eden-flake

A nix flake for [Eden](https://git.eden-emu.dev/eden-emu/eden).

## Installation
1. Add this flake to the inputs of your `flake.nix`.
  ```nix
  # flake.nix
  inputs = {
    eden = {
      url = "github:grantimatter/eden-flake"
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  ```

2. Enable in your nixos or home-manager config
  *nixos*
  ```nix
  # configuration.nix
  imports = [
    inputs.eden.nixosModules.default
  ];

  programs.eden.enable = true;
  ```

  *home-manger*
  ```nix
  # home.nix
  {
    imports = [
      inputs.eden.homeModules.default
    ];

    programs.eden.enable = true;
  }
  ```

3. Rebuild your Home Manager configuration
  ```sh
  $ home-manager switch
  ```

## Usage
Run `$ eden` or run from the .desktop entry
