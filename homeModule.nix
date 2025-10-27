{
  config,
  pkgs,
  lib,
  self,
  ...
}:
let
  cfg = config.programs.eden;
  edenPkg = self.outputs.packages.${pkgs.system}.default;
in
{
  options.programs.eden = {
    enable = lib.mkEnableOption "Eden emulator";

    package = lib.mkOption {
      type = lib.types.package;
      default = edenPkg;
      defaultText = lib.literalExpression "eden";
      description = "The Eden package to use";
    };

    enableCache = lib.mkEnableOption ''
      Enable the Cachex substituter for Eden packages.
      Only enable this if your ~/.config/nix/nix.conf is managed by home-manager.
    '';
  };

  config = lib.mkMerge [
    (lib.mkIf cfg.enableCache {
      nix.settings = {
        extra-substituters = [ "https://eden-flake.cachix.org" ];
        extra-trusted-public-keys = [ "eden-flake.cachix.org-1:9orwA5vFfBgb67pnnpsxBqILQlb2UI2grWt4zHHAxs8=" ];
      };
    })

    (lib.mkIf cfg.enable {
      home.packages = [ cfg.package ];
    })
  ];
}
