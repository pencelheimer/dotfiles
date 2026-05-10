function ls --wraps eza
    command eza -w 80 --icons auto --color auto \
        --color-scale -g -M --git $argv
end
