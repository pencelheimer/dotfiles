{
  config,
  lib,
  ...
}: let
  ext = config.dev.shell.extras;
  tmux = config.dev.tmux.enable;
  condEnable = lib.attrsets.optionalAttrs;
in {
  imports = [];

  options.dev.shell.fish = {
    enable = lib.mkEnableOption "fish";
  };

  config = lib.mkIf config.dev.shell.fish.enable {
    programs.fish = {
      enable = true;
      generateCompletions = true;

      functions = {
        ls = condEnable ext.use-eza "eza $argv";
        tree = condEnable ext.use-eza "eza --tree $argv";
        ta = condEnable tmux "tmux attach || tmux new -s default";
        tf = "tmux new-session -d -s default 2>/dev/null; tmux attach-session -t default \; display-popup -E 'sesh'";
        open = condEnable ext.enable "handlr open $argv";

        __multidot = "echo -ns (string repeat -n (math (string length -- $argv) - 1) ../) %";
      };

      shellAbbrs = {
        multidot = {
          regex = "\\.\\.\\.+$";
          position = "anywhere";
          function = "__multidot";
          setCursor = true;
        };
      };
    };
  };
}
