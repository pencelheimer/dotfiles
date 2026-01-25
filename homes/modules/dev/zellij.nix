{
  config,
  lib,
  pkgs,
  ...
}: {
  options.dev.zellij = {
    enable = lib.mkEnableOption "zellij";
  };

  config = lib.mkIf config.dev.zellij.enable {
    programs.zellij.enable = true;
    stylix.targets.zellij.enable = true;

    xdg.configFile.zellij-config = {
      target = "zellij/config.kdl";
      source = lib.file.mkOutOfStoreSymlink "/home/pencelheimer/.config/nixos/raw/zellij/config.kdl";
    };

    xdg.configFile.zellij-layouts = {
      target = "zellij/layouts";
      recursive = true;
      source = lib.file.mkOutOfStoreSymlink "/home/pencelheimer/.config/nixos/raw/zellij/layouts";
    };

    home.packages = with pkgs; [
      (writeShellApplication {
        name = "sessionizer";
        runtimeInputs = [fzf fd zellij ripgrep coreutils];

        text =
          # bash
          ''
            bookmarks=(
              "$HOME/dotfiles/.scripts"
              "$HOME/krsnktska"
              "$HOME/dotfiles"
            )

            search_paths=(
              "$HOME/stuff/projects"
              "$HOME/dotfiles/.config"
              "$HOME/Documents/nure/semester-4"
            )

            ignored_names=(
              ".git"
              "target"
              "build"
              "__pycache__"
              "venv"
            )

            valid_search_paths=()
            for path in "''${search_paths[@]}"; do
              if [[ -d "''${path}" ]]; then
                valid_search_paths+=("$path")
              fi
            done

            bookmarks_list=$(printf "%s\n" "''${bookmarks[@]}")
            all_subdirs=$(fd --type d --max-depth 1 . "''${valid_search_paths[@]}")$'\n'
            exclude_pattern=$(printf "/%s$\n" "''${ignored_names[@]}" | paste -sd '|')

            selected_path=$(echo -e "$all_subdirs$bookmarks_list" | \
              sed 's|/$||' | \
              rg --invert-match -e "(^$|''${exclude_pattern})" | \
              sed "s|^$HOME|~|" | \
              fzf --height 100% --tac)

            if [[ -z $selected_path ]]; then
              exit 0
            fi

            selected_path_expanded=$(readlink -f "''${selected_path/#\~/$HOME}")
            session_name=$(basename "$selected_path_expanded" | tr '.' '_')

            if [[ -z "''${ZELLIJ-}" ]]; then
              cd "$selected_path_expanded" || exit
              zellij attach "$session_name" -c
            else
              zellij pipe --plugin switch -- "--session $session_name --cwd $selected_path --layout default"
            fi
          '';
      })
    ];
  };
}
