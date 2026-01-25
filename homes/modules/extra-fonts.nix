{
  config,
  pkgs,
  lib,
  ...
}: let
  cfg = config.extra-fonts;
in {
  imports = [];

  options.extra-fonts = {
    enable = lib.mkEnableOption "extra fonts";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      noto-fonts
      font-awesome_4
      nerd-fonts.iosevka-term
      nerd-fonts.jetbrains-mono
      nerd-fonts.ubuntu

      liberation_ttf
    ];

    fonts.fontconfig.enable = true;
  };
}
