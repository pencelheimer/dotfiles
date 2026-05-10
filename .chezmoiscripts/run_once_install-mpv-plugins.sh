#!/usr/bin/env bash

mkdir -p ~/.config/mpv/scripts

# install uosc
bash -c "$(curl -fsSL https://raw.githubusercontent.com/tomasklaen/uosc/HEAD/installers/unix.sh)"

# install thumbfast
wget https://raw.githubusercontent.com/po5/thumbfast/refs/heads/master/thumbfast.lua \
  -O ~/.config/mpv/scripts/thumbfast.lua

# TODO(pencelheimer): install mpv-mpris
