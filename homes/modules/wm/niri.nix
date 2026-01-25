{
  config,
  pkgs,
  lib,
  ...
}:
{
  options.wm.niri = {
    enable = lib.mkEnableOption "niri";
  };

  config = lib.mkIf config.wm.niri.enable {
    wm.wallpaper.swww.enable = true;

    home.packages = with pkgs; [ niri ];

    xdg.portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-gnome
        xdg-desktop-portal-gtk
      ];
      config.niri.default = [
        "gnome"
        "gtk"
      ];
    };

    xdg.configFile.niri = {
      recursive = true;
      source = config.lib.file.mkOutOfStoreSymlink "/home/pencelheimer/.config/nixos/raw/niri";
    };
  };
}
