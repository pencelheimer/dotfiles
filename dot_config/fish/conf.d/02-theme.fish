status is-interactive; and begin
    # See https://github.com/tomyun/base16-fish/issues/7 for why this condition exists
    if status --is-interactive && test -z "$TMUX"
        base16-theme
    end
end
