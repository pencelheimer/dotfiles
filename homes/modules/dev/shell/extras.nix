{
  pkgs,
  config,
  lib,
  ...
}: let
  ext = config.dev.shell.extras;
  condEnable = lib.attrsets.optionalAttrs;
in {
  imports = [];

  options.dev.shell.extras = {
    enable = lib.mkEnableOption "extras";

    use-eza = lib.mkEnableOption "eza";
  };

  config = lib.mkIf config.dev.shell.extras.enable {
    home.packages = with pkgs; [
      devenv
      handlr-regex # xdg-open but cool
    ];

    programs.ripgrep.enable = true;
    programs.ripgrep-all.enable = true;
    programs.fd.enable = true;
    programs.jq.enable = true;
    programs.bat.enable = true;
    programs.bacon.enable = true;

    programs.delta.enable = true;
    programs.lazygit = {
      enable = true;
      settings = {
        gui = {
          nerdFontsVersion = 3;
        };
        git = {
          pagers = [
            {
              pager = "delta --paging=never --line-numbers";
              colorArg = "always";
            }
          ];
        };
      };
    };

    stylix.targets.btop.enable = false;
    programs.btop = {
      enable = true;
      settings = {
        color_theme = "TTY";
        vim_keys = true;
      };
    };

    programs.tealdeer = {
      enable = true;
      settings = {
        display.compact = true;
        updates.auto_update = true;
      };
    };

    programs.skim = {
      enable = true;
      defaultOptions = ["--color 16"];
    };

    programs.eza = condEnable ext.use-eza {
      enable = true;
      colors = "auto";
      icons = "auto";
      git = true;
    };
  };
}
