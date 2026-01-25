{
  pkgs,
  config,
  lib,
  ...
}:
{
  options.wm.notifyd.xfce-notifyd = {
    enable = lib.mkEnableOption "xfce-notifyd";
  };

  config = lib.mkIf config.wm.notifyd.xfce-notifyd.enable {
    home.packages = with pkgs; [
      xfce.xfce4-notifyd
      xfce.xfconf
    ];
  };
}
