{
  lib,
  config,
  pkgs,
  ...
}: {
  programs.gtklock = {
    enable = true;

    modules = with pkgs; [
      gtklock-playerctl-module
      gtklock-powerbar-module
      gtklock-userinfo-module
    ];

    style =
      lib.attrsets.optionalAttrs
      config.extra-fonts.enable
      # css
      ''
        * {
          font-family: "Ubuntu Nerd Font Propo";
        }
      '';
  };
}
