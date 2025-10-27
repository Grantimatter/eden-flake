# eden-flake

A nix flake for [Eden](https://git.eden-emu.dev/eden-emu/eden).

## Installation
Add this flake to the inputs of your `flake.nix`.

> [!TIP]
> If you want to use Cachix to avoid having to manually build the package, see [this section](#cachix).

### Flake
  ```nix
  # flake.nix
  {
    inputs = {
      eden = {
        url = "github:grantimatter/eden-flake"
        inputs.nixpkgs.follows = "nixpkgs"; # Do not override if using Cachix
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

### Cachix
In order to download cached builds of this flake from Cachix, you will need to add the eden-flake Cachix as a substituter in your flake or nix config.

This will allow you to download a cached, already-built version of eden without having to manually build it each time the flake updates.

> [!IMPORTANT]
> Remove `inputs.nixpkgs.follows = ...` from your eden-flake input, if you have it set. Overriding the nixpkgs input defeats the purpose of the cache.

#### Flake Setup
```nix
# flake.nix
nixConfig = {
    extra-substituters = ["https://eden-flake.cachix.org"];
    extra-trusted-public-keys = ["eden-flake.cachix.org-1:9orwA5vFfBgb67pnnpsxBqILQlb2UI2grWt4zHHAxs8="];
};
```

#### Non-Flake Setup
```nix
# configuration.nix
nix.settings = {
    trusted-substituters = ["https://eden-flake.cachix.org"]; # Use substituters instead of trusted-substituters if desired
    trusted-public-keys = ["eden-flake.cachix.org-1:9orwA5vFfBgb67pnnpsxBqILQlb2UI2grWt4zHHAxs8="];
};
```

## Usage
Run `$ eden` or run from the .desktop entry
