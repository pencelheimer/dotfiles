{lib, ...}: {
  options.file_shares.localsend = {
    enable = lib.mkEnableOption "localsend";
  };
  # config = lib.mkIf config.file_shares.localsend.enable {
  config = {
    programs.localsend = {
      openFirewall = true;
      enable = true;
    };
  };
}
