# TODO: autoinstall `sk`
# NOTE: needs `/usr/share/fish/vendor_functions.d/skim_key_bindings.fish`
# which is installed by the package manager
if status is-interactive; and type -q zoxide
    zoxide init fish | source
end
