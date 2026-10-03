# update the PATH
fish_add_path -g ~/.local/bin

set -gx EDITOR nvim
set -gx MANPAGER nvim +Man!
set -gx PAGER bat

test -S ~/.bitwarden-ssh-agent.sock
and set -gx SSH_AUTH_SOCK ~/.bitwarden-ssh-agent.sock

set -gx TMUX_TMPDIR "$XDG_RUNTIME_DIR"

# persistent podman registry credentials (survives reboots, unlike the default XDG_RUNTIME_DIR path)
set -gx REGISTRY_AUTH_FILE ~/.config/containers/auth.json

set -gx PI_CODING_AGENT_DIR "$HOME/.pi/agent"
