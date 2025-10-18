# eden-flake

A nix flake for [Eden](https://git.eden-emu.dev/eden-emu/eden).

## Installation
Add this flake to the inputs of your `flake.nix`.
  ```nix
  # flake.nix
  {
    inputs = {
      eden = {
        url = "github:grantimatter/eden-flake"
        inputs.nixpkgs.follows = "nixpkgs";
      };
    };
  }
  ```

### NixOS
```nix
# configuration.nix
{
  imports = [
    inputs.eden.nixosModules.default
  ];

  programs.eden.enable = true;
}

```

Rebuild your NixOS configuration
```sh
$ nixos-rebuild switch
```

### home-manager
```nix
# home.nix
{
  imports = [
    inputs.eden.homeModules.default
  ];

  programs.eden.enable = true;
}
```

Rebuild your home-mananger configuration

```sh
$ home-manager switch
```

## Usage
Run `$ eden` or run from the .desktop entry
