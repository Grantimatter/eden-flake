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
    enable = lib.mkEnableOption "Eden emulator" // {
      default = true;
    };

    package = lib.mkOption {
      type = lib.types.package;
      default = edenPkg;
      defaultText = lib.literalExpression "eden";
      description = "The Eden package to use";
    };
  };
  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ cfg.package ];
  };
}
