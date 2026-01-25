{
  lib,
  config,
  inputs,
  ...
}: {
  imports = [
    inputs.walker.homeManagerModules.default
  ];

  options.wm.dmenu.walker = {
    enable = lib.mkEnableOption "walker";
  };

  config = lib.mkIf config.wm.dmenu.walker.enable {
    systemd.user.services.elephant.Unit.After = lib.mkForce ["graphical-session.target"];

    programs.walker = {
      enable = true;
      runAsService = true;

      config = {
        force_keyboard_focus = true;
        keybinds = {
          close = ["Escape"];
          next = ["Down"];
          previous = ["Up"];
          resume_last_query = ["ctrl r"];
          quick_activate = ["ctrl h" "ctrl j" "ctrl g" "ctrl f"];
        };
        providers = {
          default = ["desktopapplications"];
          empty = ["desktopapplications"];
          prefixes = [
            {
              prefix = ";";
              provider = "providerlist";
            }
            {
              prefix = "/";
              provider = "files";
            }
            {
              prefix = ".";
              provider = "symbols";
            }
            {
              prefix = "!";
              provider = "todo";
            }
            {
              prefix = "=";
              provider = "calc";
            }
            {
              prefix = "@";
              provider = "websearch";
            }
            {
              prefix = ":";
              provider = "clipboard";
            }
          ];
        };
      };

      themes."default".style = let
        inherit (config.lib.stylix) colors;
      in
        # css
        ''
          @define-color base00 #${colors.base00};  @define-color base08 #${colors.base08};
          @define-color base01 #${colors.base01};  @define-color base09 #${colors.base09};
          @define-color base02 #${colors.base02};  @define-color base0A #${colors.base0A};
          @define-color base03 #${colors.base03};  @define-color base0B #${colors.base0B};
          @define-color base04 #${colors.base04};  @define-color base0C #${colors.base0C};
          @define-color base05 #${colors.base05};  @define-color base0D #${colors.base0D};
          @define-color base06 #${colors.base06};  @define-color base0E #${colors.base0E};
          @define-color base07 #${colors.base07};  @define-color base0F #${colors.base0F};

          * {
            all: unset;
          }

          .normal-icons {
            -gtk-icon-size: 16px;
          }

          .large-icons {
            -gtk-icon-size: 32px;
          }

          scrollbar {
            opacity: 0;
          }

          .box-wrapper {
            box-shadow:
              0 19px 38px rgba(0, 0, 0, 0.3),
              0 15px 12px rgba(0, 0, 0, 0.22);
            background: @base00;
            padding: 20px;
            border-radius: 20px;
            border: 1px solid @base02;
          }

          .preview-box,
          .elephant-hint,
          .placeholder {
            color: @base04;
          }

          .box {
          }

          .search-container {
            border-radius: 10px;
          }

          .input placeholder {
            opacity: 0.5;
          }

          .input {
            caret-color: @base04;
            background: @base01;
            padding: 10px;
            color: @base05;
          }

          .input:focus,
          .input:active {
          }

          .content-container {
          }

          .placeholder {
          }

          .scroll {
          }

          .list {
            color: @base05;
          }

          child {
          }

          .item-box {
            border-radius: 10px;
            padding: 10px;
          }

          .item-quick-activation {
            margin-left: 10px;
            background: darker(@base03);
            border-radius: 5px;
            padding: 10px;
          }

          child:hover .item-box,
          child:selected .item-box {
            background: @base02;
          }

          .item-text-box {
          }

          .item-text {
          }

          .item-subtext {
            font-size: 12px;
            opacity: 0.5;
          }

          .item-image {
            margin-right: 10px;
          }

          .keybind-hints {
            font-size: 12px;
            opacity: 0.8;
            color: @base04;
          }

          .preview {
            border: 1px solid @base02;
            padding: 10px;
            border-radius: 10px;
            color: @base05;
          }

          .calc .item-text {
            font-size: 24px;
          }

          .calc .item-subtext {
          }

          .symbols .item-image {
            font-size: 24px;
          }

          .todo.done .item-text-box {
            opacity: 0.25;
          }

          .todo.urgent {
            font-size: 24px;
          }

          .todo.active {
            font-weight: bold;
          }

          .preview .large-icons {
            -gtk-icon-size: 64px;
          }
        '';
    };
  };
}
