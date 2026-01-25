{
  config,
  lib,
  ...
}: {
  imports = [];
  options.dev.direnv = {
    enable = lib.mkEnableOption "direnv";
  };
  config = lib.mkIf config.dev.direnv.enable {
    programs.direnv = {
      enable = true;
      config = {
        warn_timeout = 0;
      };
    };
  };
}
