set -gx XDG_CONFIG_HOME ~/.config
set -gx XDG_CACHE_HOME ~/.cache
set -gx XDG_STATE_HOME ~/.local/state
set -gx XDG_DATA_HOME ~/.local/share

set -x XDG_DESKTOP_DIR ~/desktop
set -x XDG_DOWNLOAD_DIR ~/downloads
set -x XDG_TEMPLATES_DIR ~/templates
set -x XDG_PUBLICSHARE_DIR ~/public
set -x XDG_DOCUMENTS_DIR ~/documents
set -x XDG_MUSIC_DIR ~/music
set -x XDG_PICTURES_DIR ~/pictures
set -x XDG_VIDEOS_DIR ~/videos
set -x XDG_PROJECTS_DIR ~/projects

mkdir -p $XDG_DESKTOP_DIR
mkdir -p $XDG_DOWNLOAD_DIR
mkdir -p $XDG_TEMPLATES_DIR
mkdir -p $XDG_PUBLICSHARE_DIR
mkdir -p $XDG_DOCUMENTS_DIR
mkdir -p $XDG_MUSIC_DIR
mkdir -p $XDG_PICTURES_DIR
mkdir -p $XDG_VIDEOS_DIR
mkdir -p $XDG_PROJECTS_DIR
