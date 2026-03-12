{
  config,
  lib,
  pkgs,
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

    home.packages = with pkgs; [diffnav];

    programs.delta = {
      enable = true;
      enableGitIntegration = true;
    };

    programs.gh = {
      enable = true;

      hosts = {
        "github.com".user = "${config.user.userName}";
      };

      settings = {
        git_protocol = "ssh";
      };
    };

    programs.gh-dash = {
      enable = true;

      settings = {
        defaults = {
          preview.open = true;
          preview.width = 90;
        };

        keybindings.universl = [
          {
            key = "g";
            name = "lazygit";
            command = "cd {{.RepoPath}}; lazygit";
          }
        ];

        pager.diff = "${lib.getExe pkgs.diffnav}";
      };
    };

    programs.gpg.enable = true;
  };
}
