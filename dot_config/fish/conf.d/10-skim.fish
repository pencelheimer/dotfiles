# TODO: autoinstall `sk`
# NOTE: needs `/usr/share/fish/vendor_functions.d/skim_key_bindings.fish`
# which is installed by the package manager
if status is-interactive; and type -q sk; and functions -q skim_key_bindings
    set -gx SKIM_DEFAULT_OPTIONS '--color 16'
    skim_key_bindings
end
