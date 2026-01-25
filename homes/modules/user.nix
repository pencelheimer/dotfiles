{
  config,
  lib,
  ...
}: let
  cfg = config.user;
in {
  imports = [];

  options.user = with lib.types; {
    enable = lib.mkEnableOption "user";
    userName = lib.mkOption {
      type = str;
      default = "user";
    };
    userEmail = lib.mkOption {type = str;};
  };

  config = lib.mkIf cfg.enable {
    home.username = cfg.userName;
    home.homeDirectory = "/home/${cfg.userName}";
  };
}
