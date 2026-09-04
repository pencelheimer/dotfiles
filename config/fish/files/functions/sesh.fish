function sesh --description "Tnux sessionizer"
    set -l query "$argv[1]"

    set -l bookmarks \
        "$HOME/.config/nixos" \
        "$HOME/references" \
        "$HOME/Downloads" \
        "$HOME/Documents/rustcamp_winter_2026"

    set -l search_dirs \
        "$HOME/Documents/nure" \
        "$HOME/projects" \
        "$HOME/probe"

    set -l found (fd . $search_dirs --type=dir --max-depth=2 --full-path 2>/dev/null)

    set -l selected (printf "%s\n" $found $bookmarks "default" \
        | string replace "$HOME/" "" \
        | sk -q "$query" --tac --color 16)

    if test -z "$selected"
        return 0
    end

    set -l full_path "$HOME/$selected"
    if test "$selected" = "default"
        set full_path "$HOME"
    end

    set -l selected_name (basename "$full_path" | tr . _)

    if not tmux has-session -t "$selected_name" 2>/dev/null
        tmux new-session -ds "$selected_name" -c "$full_path"
    end

    if test -n "$TMUX"
        tmux switch-client -t "$selected_name"
    else
        tmux attach-session -t "$selected_name"
    end
end
