{
  pkgs,
  config,
  lib,
  ...
}: let
  git-pencelheimer-id = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKHSBrsPt7wvTsSGAOzBodo5kViKa4XmdIsh+GzFAMX+";
  linerds-id = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINiV9gowjxHkbdRtwBSljGK0/Y55X3/xZbYQWrRVo1P8";
in {
  imports = [];
  options.dev.ssh = {
    enable = lib.mkEnableOption "ssh";
  };
  config = lib.mkIf config.dev.ssh.enable {
    programs.ssh = {
      enable = true;
      enableDefaultConfig = false;

      matchBlocks."linerds" = {
        hostname = "linerds.us";
        user = "pencelheimer";
      };

      matchBlocks."keeper" = {
        hostname = "ssh.pencel.dev";
        user = "pencelheimer";
        proxyCommand = "${pkgs.cloudflared}/bin/cloudflared access ssh --hostname %h";
      };
    };

    home.file.".ssh/git-pencelheimer-id.pub".text = ''${git-pencelheimer-id}'';
    home.file.".ssh/linerds-id.pub".text = ''${linerds-id}'';
    home.file.".ssh/allowed_signers".text = ''
      # me
      * ${git-pencelheimer-id}
      # me old
      * ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPk07NI4WUJ+teJ02OF5t4FFLdfg4E1PmaZb76MA+LtY

      unexplrd@linerds.us ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILD1xhF6SYtgb/UacOR2HYcrPJhWgxRlwiXnp3EgYZGs
      oxidate@tuta.io     ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDQD3dR4p5K4gChrSEK+TktPae6i4lmg5vhtqPNGAvgD
    '';
  };
}
