# remove the garbage from ~/
set -gx GOPATH $XDG_DATA_HOME/go
set -gx CARGO_HOME $XDG_DATA_HOME/cargo
set -gx CLIPPY_CONF_DIR $XDG_DATA_HOME/cargo/
set -gx NPM_CONFIG_PREFIX ~/.local

# update the PATH
fish_add_path -g ~/.local/bin
fish_add_path -g $CARGO_HOME/bin
fish_add_path -g $GOPATH/bin

# find and set preferred editor
type -q nano; set -gx EDITOR nano
type -q vim; set -gx EDITOR vim
type -q nvim; set -gx EDITOR nvim

type -q nvim; and set -gx MANPAGER nvim +Man!
type -q bat; and set -gx PAGER bat

test -S ~/.bitwarden-ssh-agent.sock
and set -gx SSH_AUTH_SOCK ~/.bitwarden-ssh-agent.sock

type -q tmux; set -gx TMUX_TMPDIR "$XDG_RUNTIME_DIR"
