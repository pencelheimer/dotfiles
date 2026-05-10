#!/usr/bin/env bash
set -euo pipefail

. "${XDG_CONFIG_HOME:-$HOME/.config}/user-dirs.dirs"

mkdir -p -- "${XDG_DESKTOP_DIR:-$HOME/Desktop}"
mkdir -p -- "${XDG_DOWNLOAD_DIR:-$HOME/Downloads}"
mkdir -p -- "${XDG_TEMPLATES_DIR:-$HOME/Templates}"
mkdir -p -- "${XDG_PUBLICSHARE_DIR:-$HOME/Public}"
mkdir -p -- "${XDG_DOCUMENTS_DIR:-$HOME/Documents}"
mkdir -p -- "${XDG_MUSIC_DIR:-$HOME/Music}"
mkdir -p -- "${XDG_PICTURES_DIR:-$HOME/Pictures}"
mkdir -p -- "${XDG_VIDEOS_DIR:-$HOME/Videos}"
