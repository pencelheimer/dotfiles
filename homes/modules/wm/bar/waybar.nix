{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [];

  options.wm.bar.waybar = {
    enable = lib.mkEnableOption "waybar";
  };

  config = lib.mkIf config.wm.bar.waybar.enable {
    stylix.targets = {
      waybar.enable = false;
    };

    programs.waybar = {
      enable = true;
      systemd = {
        enable = true;
        target = "graphical-session.target";
      };

      settings.bar-0 = {
        layer = "top";
        position = "top";
        height = 35;
        spacing = 4;
        output = [
          "eDP-1"
          "eDP-2"
          "HDMI-A-2"
          "DP-3"
          "DP-4"
          "DP-5"
        ];
        modules-left = [
          "niri/workspaces"
          "idle_inhibitor"
          "pulseaudio#output"
          "pulseaudio#input"
          "backlight"
          "mpris"
          "custom/uz-traffic"
        ];
        modules-center = [
          "niri/window"
        ];
        modules-right = [
          # "custom/schedule"
          "tray"
          "niri/language"
          "memory"
          "battery"
          "custom/notifications"
          "clock"
        ];
        "niri/workspaces" = {
          format = "{icon}";
          format-icons = {
            default = "";
            terminal = "";
            social = "󰻞";
            other = "";
            browser = "";
            games = "󰺷";
          };
          on-click = "activate";
          disable-scroll = true;
          all-outputs = false;
        };
        "niri/window" = {
          format = "{}";
          separate-outputs = true;
          max-length = 40;
          icon = true;
          icon-size = 30;
          rewrite = {
            "(.*)Mozilla Firefox" = "Mozzarella Firefox";
          };
        };
        "niri/language" = {
          format = "{}";
          format-uk = "Ua";
          format-en = "En";
          max-length = 5;
        };
        tray = {
          spacing = 0;
        };
        clock = {
          format = "{:%b %d - %H:%M:%S}";
          interval = 1;
          tooltip-format = "<tt><big>{calendar}</big></tt>";
          calendar = {
            mode = "month";
            on-click-right = "mode";
            format = {
              months = "<span color='#ffead3'><b>{}</b></span>";
              days = "<span color='#ecc6d9'><b>{}</b></span>";
              weeks = "<span color='#99ffdd'><b>W{}</b></span>";
              weekdays = "<span color='#ffcc66'><b>{}</b></span>";
              today = "<span color='#ff6699'><b><u>{}</u></b></span>";
            };
          };
        };
        memory = {
          format = "{}% ";
        };
        backlight = {
          tooltip = false;
          format = "{percent}% {icon}";
          format-icons = [
            ""
            ""
            ""
            ""
            ""
            ""
            ""
            ""
            ""
          ];
        };
        battery = {
          format = "{capacity}% {icon} {power:.1f} wt";
          format-charging = "{capacity}% 󰂄";
          format-plugged = "{capacity}% ";
          states = {
            good = 100;
            warning = 40;
            critical = 15;
          };
          format-icons = [
            ""
            ""
            ""
            ""
            ""
          ];
          interval = 1;
        };
        idle_inhibitor = {
          tooltip = false;
          format = "{icon}";
          format-icons = {
            activated = "󰅶";
            deactivated = "󰾪";
          };
        };
        mpris = {
          interval = 1;
          format = "{status_icon} 󰽴 {dynamic}";
          status-icons = {
            paused = "⏸ >";
          };
          dynamic-order = [
            "title"
          ];
          max-length = 25;
          dynamic-len = 25;
        };
        "pulseaudio#output" = {
          format = "{icon} {volume}%";
          format-bluetooth = "{icon} 󰂯 {volume}%";
          format-muted = "{icon}";
          format-icons = {
            default = "󰕾";
            default-muted = "󰖁";
            headphone = "󰋋";
            headphone-muted = "󰟎";
            speaker = "󰓃";
            speaker-muted = "󰓄";
            hdmi = "󰡁";
            headset = "󰋎";
            headset-muted = "󰋐";
            hands-free = "";
            hands-free-muted = "";
            phone = "";
            phone-muted = "";
          };
          scroll-step = 5.0;
          on-click = "${pkgs.wireplumber}/bin/wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
          on-click-right = "pavucontrol";
          on-scroll-up = "${pkgs.wireplumber}/bin/wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 1%+";
          on-scroll-down = "${pkgs.wireplumber}/bin/wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%-";
          smooth-scrolling-threshold = 1;
        };
        "pulseaudio#input" = {
          format = "{format_source}";
          format-source = " {volume} %";
          format-source-muted = "";
          on-click = "${pkgs.wireplumber}/bin/wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";
          on-click-right = "pavucontrol";
          on-scroll-up = "${pkgs.wireplumber}/bin/wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SOURCE@ 1%+";
          on-scroll-down = "${pkgs.wireplumber}/bin/wpctl set-volume @DEFAULT_AUDIO_SOURCE@ 1%-";
        };
        "custom/notifications" = {
          tooltip = false;
          format = "{} {icon}";
          format-icons = {
            notification = "";
            none = "";
            dnd-notification = "";
            dnd-none = "";
            inhibited-notification = "";
            inhibited-none = "";
            dnd-inhibited-notification = "";
            dnd-inhibited-none = "";
          };
          return-type = "json";
          exec-if = "which swaync-client";
          exec = "swaync-client -swb";
          on-click = "swaync-client -t -sw";
          on-click-right = "swaync-client -d -sw";
          escape = true;
        };

        "custom/uz-traffic" = {
          tooltip = true;
          format = "{}";
          return-type = "json";
          interval = 60;
          exec = "~/uz-traffic-left.sh";
          on-click = "~/uz-traffic-left.sh";
        };

        "custom/screenrec" = {
          tooltip = false;
          format = "{}{icon}";
          format-icons = {
            in_progres = "";
            none = "";
          };
          return-type = "json";
          exec = "~/.scripts/screenrec.sh status";
          on-click = "~/.scripts/screenrec.sh togglea";
          on-click-right = "~/.scripts/screenrec.sh toggle";
          interval = 1;
        };
        "custom/xdp" = {
          format = "󱄋";
          "on-click" = "~/dotfiles/.config/hypr/execs/xdph.sh";
        };
        "custom/vnc" = {
          format = "󰦉";
          "on-click" = "~/dotfiles/.scripts/vnc.sh toggle";
        };
        "custom/schedule" = {
          return-type = "json";
          exec = "~/.scripts/schedule.sh";
          interval = 30;
          tooltip = true;
          format = "{}";
        };
        "custom/scripts_icon" = {
          format = "󱜧";
        };
        "group/scripts" = {
          modules = [
            "custom/scripts_icon"
            "idle_inhibitor"
            "custom/xdp"
            "custom/screenrec"
            "custom/vnc"
          ];
          orientation = "horizontal";
          drawer = {
            children-class = "script";
            transition-duration = 100;
            click-to-reveal = true;
          };
        };
      };

      style = let
        colors = config.lib.stylix.colors.withHashtag;
      in
        # css
        ''
          @define-color base00 ${colors.base00}; @define-color base08 ${colors.base08};
          @define-color base01 ${colors.base01}; @define-color base09 ${colors.base09};
          @define-color base02 ${colors.base02}; @define-color base0A ${colors.base0A};
          @define-color base03 ${colors.base03}; @define-color base0B ${colors.base0B};
          @define-color base04 ${colors.base04}; @define-color base0C ${colors.base0C};
          @define-color base05 ${colors.base05}; @define-color base0D ${colors.base0D};
          @define-color base06 ${colors.base06}; @define-color base0E ${colors.base0E};
          @define-color base07 ${colors.base07}; @define-color base0F ${colors.base0F};

          * {
              transition: none;
              box-shadow: none;
          }

          #waybar {
              font-family: "Noto Sans", "Font Awesome v4 Compatibility Regular", "Ubuntu Nerd Font Propo";
              font-size: 1.2em;
              font-weight: 400;
              color: @base05;
              background: @base00;
          }

          #workspaces {
              margin: 4px 0px;
              border-radius: 4px;
              background-color: @base01;
          }

          #workspaces button {
              font-weight: 600;
              padding: 0 6px;
              border-right: 1px solid @base00;
              border-left: 1px solid @base00;
              border-radius: 0;
              color: @base0A;
          }

          #workspaces button.active {
              background-color: @base03;
          }

          #workspaces button.urgent {
              color: @base09;
          }

          #workspaces button.empty {
              color: @base05;
              font-weight: 300;
          }

          #workspaces button:first-child {
              border-radius: 4px 0px 0px 4px;
              border-left: none;
          }

          #workspaces button:last-child {
              border-radius: 0px 4px 4px 0px;
              border-right: none;
          }

          #workspaces button:hover {}

          #tray {
              margin: 4px 0px;
              border-radius: 4px;
              background-color: @base01;
          }

          #tray .active,
          #tray .active>* {
              padding: 0 6px;
              border-left: 1px solid @base00;
              border-right: 1px solid @base00;
          }

          #tray .active:first-child,
          #tray .active>*:first-child {
              border-left: none;
          }

          #tray .active:last-child,
          #tray .active>*:last-child {
              border-right: none;
          }


          #idle_inhibitor,
          #mode,
          #battery,
          #cpu,
          #memory,
          #network,
          #pulseaudio,
          #backlight,
          #custom-storage,
          #custom-updates,
          #custom-weather,
          #custom-mail,
          #custom-protonmail,
          #custom-power_icon,
          #custom-shutdown,
          #custom-reboot,
          #custom-suspend,
          #custom-lock,
          #clock,
          #temperature,
          #custom-notifications,
          #language {
              margin: 4px 0px;
              padding: 0 6px;
              background-color: @base01;
              border-radius: 4px;
              min-width: 20px;
          }

          #custom-notifications.notification,
          #custom-notifications.dnd-notification,
          #custom-notifications.inhibited-notification,
          #custom-notifications.dnd-inhibited-notification {
              color: @base0A;
              font-weight: 600;
          }

          #pulseaudio.input.source-muted,
          #pulseaudio.output.muted {
              color: @base09;
          }

          #clock {
              margin-left: 0px;
              margin-right: 4px;
          }

          #window {
              font-size: 0.9em;
              font-weight: 400;
          }

          #language {
              font-size: 0.9em;
              font-weight: 500;
              letter-spacing: -1px;
          }

          #battery.charging,
          #battery.good {
              color: @base0B;
          }

          #battery.warning:not(.charging) {
              color: @base09;
          }

          #battery.critical:not(.charging) {
              animation-name: blink;
              animation-duration: 1.5s;
              animation-timing-function: linear;
              animation-iteration-count: infinite;
              animation-direction: alternate;
          }

          @keyframes blink {
              to {
                  color: @base08;
              }
          }

          #custom-screenrec.in_progres {
              color: @base08;
          }

          #mpris {
              color: @base0E;
          }
        '';
    };
  };
}
