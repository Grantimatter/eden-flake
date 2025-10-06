# eden-flake

## About
This is a nix flake for [Eden](https://git.eden-emu.dev/eden-emu/eden).

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

2. Enable in your home-manager config
```nix
{
  # home.nix
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

4. Run `$ eden` or run from the .desktop entry
