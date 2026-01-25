{
  lib,
  config,
  ...
}: {
  imports = [];
  options.boot = with lib.types; {
    loader-name = lib.mkOption {
      type = str;
      default = "systemd-boot";
    };
  };
  config = {
    boot = {
      tmp.useTmpfs = true; # use tmpfs too speedup rebuild (may cause problems for too large updates)

      plymouth.enable = true;

      loader = {
        # timeout = 0;
        efi.canTouchEfiVariables = true;
        systemd-boot = lib.mkIf (config.boot.loader-name
          == "systemd-boot") {
          enable = true;
          configurationLimit = 5;
        };
      };
    };
  };
}
