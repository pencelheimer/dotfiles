set -gx CARGO_HOME $XDG_DATA_HOME/cargo
set -gx CLIPPY_CONF_DIR $XDG_DATA_HOME/cargo/

fish_add_path -g $CARGO_HOME/bin
