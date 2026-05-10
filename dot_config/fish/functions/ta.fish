function ta --description "Attach to the active tmux session or create new"
    tmux attach || tmux new -s default
end
