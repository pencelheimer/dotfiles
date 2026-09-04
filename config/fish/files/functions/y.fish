function y --wraps 'yazi' --description 'TUI file manager'
    set -l tmp (mktemp -t 'yazi_cwd.XXX')
    yazi --cwd-file="$tmp" $argv

    set -l cwd (command cat -- "$tmp")
    and test -n "$cwd"
    and test "$cwd" != "$PWD"
    and builtin cd -- "$cwd"

    rm -f -- "$tmp"
end
