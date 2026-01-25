{
  config,
  lib,
  pkgs,
  ...
}:
let
  allmytoes-plugin = pkgs.fetchFromGitHub {
    owner = "Sonico98";
    repo = "allmytoes.yazi";
    rev = "dd7895d";
    hash = "sha256-T1Zx+K/0qHD5iAOhV2mG7amjNLLFzjLxuAx192FCLEk=";
  };

  exifaudio-plugin = pkgs.fetchFromGitHub {
    owner = "Sonico98";
    repo = "exifaudio.yazi";
    rev = "e766cd2";
    hash = "sha256-aniuY14pXcoaW6YkUwt7hTl9mWjl5HoOPhHkuY4ooAw=";
  };
in
{
  options.dev.yazi = {
    enable = lib.mkEnableOption "yazi";
  };

  config = lib.mkIf config.dev.yazi.enable {
    home.packages = with pkgs; [
      dragon-drop
      wl-clipboard-rs
      sushi

      ouch
      xdg-utils
      exiftool
      mediainfo
      imagemagick
      git
    ];

    programs.yazi = {
      enable = true;
      shellWrapperName = "yy";
      initLua =
        # lua
        ''
          require("git"):setup()
        '';

      plugins = with pkgs; {
        allmytoes = "${allmytoes-plugin}";
        exifaudio = "${exifaudio-plugin}";
        ouch = yaziPlugins.ouch;
        git = yaziPlugins.git;
      };

      keymap = {
        mgr.prepend_keymap = [
          {
            on = [ "<C-n>" ];
            run = ''shell 'dragon-drop -x -i -T "$1"' --confirm'';
            desc = "Drag and drop";
          }
          {
            on = [ "y" ];
            run = [
              "yank"
              ''shell --confirm 'for path in "$@"; do echo "file://$path"; done | wl-copy -t text/uri-list' ''
            ];
            desc = "Copy file paths to clipboard";
          }
          {
            on = [ "<C-space>" ];
            run = [ ''shell -- sushi "$@"'' ];
            desc = "Preview with Sushi";
          }
          {
            on = [ "C" ];
            run = "plugin ouch";
            desc = "Compress with ouch";
          }
        ];
      };

      settings = {
        plugin = {
          prepend_fetchers = [
            {
              id = "git";
              name = "*";
              run = "git";
            }
            {
              id = "git";
              name = "*/";
              run = "git";
            }
          ];
          prepend_preloaders = [
            {
              mime = "image/svg+xml";
              run = "magick";
            }
            {
              mime = "image/heic";
              run = "magick";
            }
            {
              mime = "image/jxl";
              run = "magick";
            }
            {
              mime = "image/*";
              run = "allmytoes";
            }
          ];

          prepend_previewers = [
            {
              mime = "audio/*";
              run = "exifaudio";
            }
            {
              mime = "image/svg+xml";
              run = "magick";
            }
            {
              mime = "image/heic";
              run = "magick";
            }
            {
              mime = "image/jxl";
              run = "magick";
            }
            {
              mime = "image/*";
              run = "allmytoes";
            }
            {
              mime = "application/*zip";
              run = "ouch";
            }
            {
              mime = "application/x-tar";
              run = "ouch";
            }
            {
              mime = "application/x-bzip2";
              run = "ouch";
            }
            {
              mime = "application/x-7z-compressed";
              run = "ouch";
            }
            {
              mime = "application/x-rar";
              run = "ouch";
            }
            {
              mime = "application/xz";
              run = "ouch";
            }
          ];
        };

        opener = {
          edit = [
            {
              run = ''$EDITOR "$@"'';
              desc = "$EDITOR";
              block = true;
              for = "unix";
            }
          ];
          open = [
            {
              run = ''xdg-open "$1" & disown'';
              desc = "Open";
              for = "linux";
            }
          ];
          reveal = [
            {
              run = ''xdg-open "$(dirname "$1")"'';
              desc = "Reveal";
              for = "linux";
            }
            {
              run = ''exiftool "$1"; echo "Press enter to exit"; read _'';
              block = true;
              desc = "Show EXIF";
              for = "unix";
            }
          ];
          extract = [
            {
              run = ''ouch d -y "$@"'';
              desc = "Extract here with ouch";
              for = "unix";
            }
          ];
          play = [
            {
              run = ''mpv --force-window "$@"'';
              orphan = true;
              for = "unix";
            }
            {
              run = ''mediainfo "$1"; echo "Press enter to exit"; read _'';
              block = true;
              desc = "Show media info";
              for = "unix";
            }
          ];
          dragndrop = [
            {
              run = ''dragon-drop --on-top "$@"'';
              desc = "Drag and drop";
            }
          ];
        };

        open = {
          rules = [
            {
              name = "*/";
              use = [
                "edit"
                "open"
                "reveal"
                "dragndrop"
              ];
            }
            {
              mime = "text/*";
              use = [
                "edit"
                "reveal"
                "dragndrop"
              ];
            }
            {
              mime = "image/*";
              use = [
                "open"
                "reveal"
                "dragndrop"
              ];
            }
            {
              mime = "{audio,video}/*";
              use = [
                "play"
                "reveal"
                "dragndrop"
              ];
            }
            {
              mime = "application/{,g}zip";
              use = [
                "extract"
                "reveal"
                "dragndrop"
              ];
            }
            {
              mime = "application/x-{tar,bzip*,7z-compressed,xz,rar}";
              use = [
                "extract"
                "reveal"
                "dragndrop"
              ];
            }
            {
              mime = "application/{json,x-ndjson}";
              use = [
                "edit"
                "reveal"
                "dragndrop"
              ];
            }
            {
              mime = "*/javascript";
              use = [
                "edit"
                "reveal"
                "dragndrop"
              ];
            }
            {
              mime = "inode/x-empty";
              use = [
                "edit"
                "reveal"
                "dragndrop"
              ];
            }
            {
              name = "*";
              use = [
                "open"
                "edit"
                "reveal"
                "dragndrop"
              ];
            }
          ];
        };
      };
    };
  };
}
