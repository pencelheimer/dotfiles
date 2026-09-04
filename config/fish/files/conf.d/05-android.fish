set -gx ANDROID_HOME $XDG_DATA_HOME/android-sdk
set -e ANDROID_SDK_ROOT

fish_add_path -g $ANDROID_HOME/cmdline-tools/latest/bin
