{
  config,
  lib,
  ...
}:
{
  imports = [ ];

  options.wm.wallpaper.swww = {
    enable = lib.mkEnableOption "swww";
  };

  config = lib.mkIf config.wm.wallpaper.swww.enable {
    services.swww.enable = true;
  };
}
