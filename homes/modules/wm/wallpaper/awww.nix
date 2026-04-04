{
  config,
  lib,
  ...
}:
{
  imports = [ ];

  options.wm.wallpaper.awww = {
    enable = lib.mkEnableOption "awww";
  };

  config = lib.mkIf config.wm.wallpaper.awww.enable {
    services.awww.enable = true;
  };
}
