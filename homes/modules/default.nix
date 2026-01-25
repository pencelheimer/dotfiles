{ lib, ... }:
{
  imports = [
    ./browser
    ./comma.nix
    ./dev
    ./extra-fonts.nix
    ./other.nix
    ./style.nix
    ./user.nix
    ./wm
  ];

  user.enable = lib.mkDefault true;
  extra-fonts.enable = lib.mkDefault true;
  styling.enable = lib.mkDefault true;

  dev.enable = lib.mkDefault true;

  browser.zen.enable = lib.mkDefault true;

  wm = {
    niri.enable = lib.mkDefault true;
    wallpaper.swww.enable = true;
    bar.waybar.enable = lib.mkDefault true;
    notifyd.swaync.enable = lib.mkDefault true;
    dmenu.walker.enable = lib.mkDefault true;
  };
}
