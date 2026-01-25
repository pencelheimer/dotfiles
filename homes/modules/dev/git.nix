{
  config,
  lib,
  ...
}: {
  imports = [];
  options.dev.git = {
    enable = lib.mkEnableOption "git";
  };
  config = lib.mkIf config.dev.git.enable {
    programs.git = {
      enable = true;
      settings = {
        user = {
          name = "${config.user.userName}";
          email = "${config.user.userEmail}";
          signingkey = "~/.ssh/git-pencelheimer-id.pub";
        };
        log = {
          showSignature = true;
          abbrevCommit = true;
        };
        init.defaultBranch = "main";
        fetch.prune = true;
        pull.rebase = true;
        rerere.enabled = true;
        gpg.ssh.allowedSignersFile = "~/.ssh/allowed_signers";
      };
      signing = {
        format = "ssh";
        signByDefault = true;
      };
    };

    programs.delta = {
      enable = true;
      enableGitIntegration = true;
    };

    programs.gpg.enable = true;
  };
}
