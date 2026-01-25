{
  pkgs,
  config,
  lib,
  ...
}: {
  imports = [];
  options.dev.terminal.kitty = {
    enable = lib.mkEnableOption "kitty";
  };
  config = lib.mkIf config.dev.terminal.kitty.enable {
    programs.kitty = {
      enable = true;

      settings = {
        # bell
        enable_audio_bell = false;
        visual_bell_duration = 0.05;
        visual_bell_color = "#414866";
        bell_on_tab = "󰂟 ";

        hide_window_decorations = true;
        notify_on_cmd_finish = "unfocused 20";

        shell = "fish";
      };

      keybindings = {
        "ctrl+alt+enter" = "new_os_window_with_cwd";
      };
    };

    xdg.terminal-exec = {
      enable = true;
      settings.default = [
        "kitty.desktop"
      ];
    };
  };
}
