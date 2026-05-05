{
  config,
  lib,
  pkgs,
  ...
}: {
  options.dev.tmux = {
    enable = lib.mkEnableOption "tmux";
  };

  config = lib.mkIf config.dev.tmux.enable {
    programs.tmux = {
      enable = true;
      baseIndex = 1;
      newSession = false;
      shell = "${pkgs.fish}/bin/fish";
      escapeTime = 0;
      keyMode = "vi";
      historyLimit = 5000;
      terminal = "xterm-256color";

      plugins = with pkgs.tmuxPlugins; [
        {
          plugin = resurrect;
          extraConfig =
            # tmux
            ''
              set -g @resurrect-processes '~ssh ~psql ~pgcli ~bacon ~lazygit ~btop ~tray-tui ~watch "~nvim->nvim"'

              resurrect_dir=~/.local/share/tmux/resurrect
              set -g @resurrect-dir $resurrect_dir
              # set -g @resurrect-hook-post-save-all "sed -i 's| --cmd .*||g; s|/nix/store/.*/bin/||g; s|/etc/profiles/per-user/$USER/bin/||g' $(readlink -f \$resurrect_dir/last)"
            '';
        }
      ];

      extraConfig =
        # tmux
        ''
          set -ga terminal-overrides ",*256col*:Tc"
          set -ga terminal-overrides '*:Ss=\E[%p1%d q:Se=\E[ q'
          set-environment -g COLORTERM "truecolor"

          set -g extended-keys on
          set -g mouse on
          set-option -g renumber-windows on

          # images preview
          set -g allow-passthrough on
          set -ga update-environment TERM
          set -ga update-environment TERM_PROGRAM

          # status line
          set -g status-justify absolute-centre
          set -g status-right ""
          set -g status-left "#{?client_prefix,󰘳 , } #S"

          # reasonable split bindings
          bind h split-window -h -c "#{pane_current_path}"
          bind v split-window -v -c "#{pane_current_path}"
          bind c new-window -c "#{pane_current_path}"

          # vim style pane selection
          bind -n M-H select-pane -L
          bind -n M-J select-pane -D
          bind -n M-K select-pane -U
          bind -n M-L select-pane -R

          # Kill without confirm
          bind & kill-window
          bind x kill-pane

          # sesh
          unbind f
          bind f display-popup -E "sesh"

          # sesh nure
          unbind u
          bind u display-popup -E "sesh semester-6"
        '';
    };

    home.packages = with pkgs; [
      (writeShellApplication {
        name = "sesh";
        runtimeInputs = [skim fd tmux ripgrep coreutils];

        text =
          # bash
          ''
            [[ ''$# -eq 1 ]] && QUERY=''$1 || QUERY=""

            BOOKMARKS=(
              "default"
              "''$HOME/.config/nixos"
              "''$HOME/references"
              "''$HOME/Downloads"
              "''$HOME/Documents/rustcamp"
            )

            DIRS=(
              "''$HOME/Documents/nure"
              "''$HOME/projects"
              "''$HOME/probe"
            )

            found=''$(fd . "''${DIRS[@]}" --type=dir --max-depth=2 --full-path)
            bookmarks=''$(printf "%s\n" "''${BOOKMARKS[@]}")

            selected=''$(echo -e "''$found\n''$bookmarks" \
              | sed "s|^''$HOME/||" \
              | sk -q "$QUERY" --tac --color 16)

            [[ ''$selected ]] && selected="''$HOME/''$selected" || exit 0

            selected_name=''$(basename "''$selected" | tr . _)
            if ! tmux has-session -t "''$selected_name"; then
              tmux new-session -ds "''$selected_name" -c "''$selected"
              tmux select-window -t "''$selected_name:1"
            fi

            tmux switch-client -t "''$selected_name"
          '';
      })
    ];
  };
}
