{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.nix-flatpak.homeManagerModules.nix-flatpak
  ];

  config = {
    home.packages = with pkgs; [
      image-roll # image viewer and editor
      gnome-disk-utility # disk/partition manager
      # mission-center # task manager
      nautilus # file manager
      overskride # bluetooth gui
      networkmanagerapplet # network manager gui
      # newelle # ai companion
      # pulsemeeter # audio hatchbay
      pavucontrol # audio mixer
      qbittorrent # torrent client
      # fragments # torrent client
      papers # pdf viewer
      (
        pkgs.zathura.override {
          plugins = with pkgs.zathuraPkgs; [zathura_pdf_mupdf];
        }
      ) # pdf viewer

      # xournalpp # hand written notes
      gnome-text-editor # text editor

      # office
      libreoffice-fresh
      hunspell
      hunspellDicts.uk_UA
      hunspellDicts.en_US

      # misc
      playerctl
      brightnessctl
      dconf
      libnotify
      dragon-drop
      trash-cli
      cliphist
      upower
      nushell
      udiskie
    ];

    # screen capture
    programs.obs-studio = {
      enable = true;
      plugins = with pkgs.obs-studio-plugins; [
        obs-backgroundremoval
        obs-pipewire-audio-capture
        obs-vaapi
        obs-gstreamer
        obs-vkcapture
      ];
    };
    xdg.configFile.obs-studio-profiles = {
      target = "obs-studio/basic/profiles";
      recursive = true;
      force = true;
      source = ../../raw/obs-studio/basic/profiles;
    };
    xdg.configFile.obs-studio-scenes = {
      target = "obs-studio/basic/scenes";
      recursive = true;
      force = true;
      source = ../../raw/obs-studio/basic/scenes;
    };

    # video player
    programs.mpv = {
      enable = true;

      scripts = with pkgs.mpvScripts; [
        uosc
        sponsorblock
        mpris
      ];

      config = {
        title = "\${filename} - mpv";
        keep-open = true;
        ytdl-format = "bestvideo+bestaudio";

        hwdec = "auto-safe";
        vo = "gpu";
        profile = "gpu-hq";
        gpu-context = "wayland";
      };
    };

    services.kdeconnect = {
      enable = true;
      indicator = true;
    };

    programs.distrobox = {
      enable = true;
      containers = {
        esp-arch = {
          image = "archlinux";
          home = "/home/pencelheimer/distrobox-homes/esp-arch";
        };
      };
    };

    # image annotator
    programs.satty = {
      enable = true;
      settings = {
        general = {
          fullscreen = false;
          corner-roundness = 0;
          early-exit = true;
          initial-tool = "brush";
          save-after-copy = false;
          default-hide-toolbars = false;
          primary-highlighter = "freehand";
          disable-notifications = true;
          no-window-decoration = true;
          brush-smooth-history-size = 3;
          copy-command = "${pkgs.wl-clipboard}/bin/wl-copy";
          output-filename = "/home/pencelheimer/Pictures/Annotated/%B %d - %H:%M:%S.png";
          actions-on-right-click = [];
          actions-on-enter = ["save-to-clipboard"];
          actions-on-escape = ["exit"];
        };
        font = {
          family = "Roboto";
          style = "Bold";
        };
        color-palette = {
          palette = ["#00ffff" "#a52a2a" "#dc143c" "#ff1493" "#ffd700" "#008000"];
        };
      };
    };

    # flatpak
    services.flatpak = {
      enable = true;
      uninstallUnmanaged = false;
      update.auto = {
        enable = true;
        onCalendar = "weekly";
      };
      remotes = [
        {
          name = "flathub";
          location = "https://dl.flathub.org/repo/flathub.flatpakrepo";
        }

        {
          name = "GFNLinux";
          location = "https://international.download.nvidia.com/GFNLinux/flatpak/geforcenow.flatpakrepo";
        }
      ];
      packages = [
        "com.github.tchx84.Flatseal"
        # "org.pgadmin.pgadmin4"
        # "it.mijorus.gearlever"
        "com.collaboraoffice.Office"
        "io.github.limo_app.limo"
        "io.anytype.anytype"
        # {
        #   appId = "com.nvidia.geforcenow";
        #   origin = "GFNLinux";
        # }
      ];
      overrides = {
        global = {
          Context = {
            sockets = ["wayland" "!x11" "!fallback-x11"];
            filesystems = [
              "!home"
              "!host"
              "!~/.ssh"
              "/nix/store:ro"
              "xdg-config/gtk-3.0:ro"
              "xdg-config/gtk-4.0:ro"
              "~/.themes:ro"
              "~/.icons:ro"
              "~/.local/share/icons:ro"
              "xdg-run/pipewire-0"
            ];
          };

          Environment = {
            ELECTRON_OZONE_PLATFORM_HINT = "wayland";
          };
        };

        "org.pgadmin.pgadmin4".Context.filesystems = ["/run/postgresql"];

        "it.mijorus.gearlever".Context.filesystems = [
          "~/Appimages"
          "~/.local/share/applications"
          "/tmp"
        ];

        "com.valvesoftware.Steam" = {
          Context = {
            sockets = ["x11" "wayland"];
          };
        };

        "com.bitwarden.desktop" = {
          Context = {
            sockets = ["ssh-auth"];
            filesystems = ["~/.var/app/com.bitwarden.desktop/.bitwarden-ssh-agent.sock"];
          };
          Environment.SSH_AUTH_SOCK = "~/.var/app/com.bitwarden.desktop/.bitwarden-ssh-agent.sock";
        };

        "io.github.kolunmi.Bazaar" = {
          Context.filesystems = ["xdg-data/flatpak"];
        };

        "com.nvidia.geforcenow" = {
          Context = {
            sockets = ["wayland" "x11" "pulseaudio"];
            devices = ["all"]; # gpu dri?
            shared = ["ipc" "network"];
          };
        };

        "io.github.limo_app.limo" = {
          Context = {
            filesystems = [
              "~/.steam/steam/appcache/librarycache:ro"

              "~/.local/share/Steam"
              "~/Games"
              "~/.local/share/Steam/steamapps/compatdata"

              "/mnt/endeavouros/home/dumbnerd/.local/share/Steam"
              "/mnt/endeavouros/home/dumbnerd/Games"
              "/mnt/endeavouros/home/dumbnerd/.local/share/Steam/steamapps/compatdata"

              "/mnt/endeavouros/home/dumbnerd"
            ];

            sockets = ["wayland" "x11" "fallback-x11"];
            shared = ["network" "ipc"];
          };
        };
      };
    };

    # default apps
    xdg.configFile."mimeapps.list".force = true;
    xdg.mimeApps = {
      enable = true;
      defaultApplications = let
        file_manager = ["org.gnome.Nautilus.desktop"];
        image_viewer = ["org.gnome.Loupe.desktop"];
        pdf_reader = ["org.gnome.Papers.desktop"];
        video_player = ["mpv"];
        web_browser = ["zen-twilight"];
        # web_browser = ["helium"];
      in {
        "application/pdf" = pdf_reader;
        "image/jpeg" = image_viewer;
        "image/png" = image_viewer;
        "inode/directory" = file_manager;
        "text/html" = web_browser;
        "video/mp4" = video_player;
        "video/mpeg" = video_player;
        "video/x-matroska" = video_player;
        "video/x-mpeg" = video_player;
        "x-scheme-handler/about" = web_browser;
        "x-scheme-handler/http" = web_browser;
        "x-scheme-handler/https" = web_browser;
        "x-scheme-handler/unknown" = web_browser;
      };
    };
  };
}
