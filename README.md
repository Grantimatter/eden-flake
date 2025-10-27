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
{
  imports = [
    inputs.eden.nixosModules.default
  ];

  programs.eden = {
    enable = true;
    enableCache = true; # Optional: Enable cache (see Cachix section)
  };
}
```

### home-manager
```nix
{
  imports = [
    inputs.eden.homeModules.default
  ];

  programs.eden = {
    enable = true;
    enableCache = true; # Optional: Enable cache (see Cachix section)
  };
}
```

### Cachix
In order to download cached builds of this flake from Cachix, you will need to add the eden-flake substituter in your flake or nix config.

This will allow you to download binaries built by CI instead of building them yourself.

> [!IMPORTANT]
> Remove `inputs.nixpkgs.follows = ...` from your eden-flake input, if you have it set. Overriding the nixpkgs input defeats the purpose of the cache.

#### Module-Based Setup (Recommended for NixOS/home-manager)

> [!IMPORTANT]
> You must rebuild your system or home-manager once with just `programs.eden.enableCache = true;` set so the substituter is present when Eden is derived.

**Step 1:** Enable the cache only (without installing Eden yet):
```nix
programs.eden = {
  enable = false;  # Don't install Eden yet
  enableCache = true;  # Configure the cache first
};
```

Rebuild to apply the cache configuration.

**Step 2:** Now enable Eden (it will use the cache):
```nix
programs.eden = {
  enable = true;  # Now install Eden
  enableCache = true;
};
```

Rebuild again. Eden should download from Cachex.

#### Manual Setup

If you know what you're doing, you can configure these two Nix settings your own way.

```
substituters = https://eden-flake.cachix.org
trusted-public-keys = eden-flake.cachix.org-1:9orwA5vFfBgb67pnnpsxBqILQlb2UI2grWt4zHHAxs8=
```

## Usage
Run `$ eden` or run from the .desktop entry
