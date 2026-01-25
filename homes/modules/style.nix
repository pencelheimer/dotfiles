{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [];

  options.styling = {
    enable = lib.mkEnableOption "styling";
  };

  config = lib.mkIf config.styling.enable {
    stylix = {
      enable = true;
      base16Scheme = "${pkgs.base16-schemes}/share/themes/gruber.yaml";
      polarity = "dark";

      fonts = {
        sizes = {
          #   applications = 13;
          terminal = 15;
          #   popups = 14;
          #   desktop = 13;
        };

        serif = {
          package = pkgs.nerd-fonts.noto;
          name = "Noto Nerd Font Serif";
        };
        sansSerif = {
          package = pkgs.nerd-fonts.noto;
          name = "Noto Nerd Font Serif";
        };
        monospace = {
          package = pkgs.nerd-fonts.iosevka-term;
          name = "IosevkaTerm Nerd Font";
        };
        emoji = {
          package = pkgs.nerd-fonts.noto;
          name = "Noto Nerd Font Serif";
        };
      };

      opacity = {
        # applications = 1;
        # terminal = 0.65;
        # popups = 1;
        # desktop = 1;
      };

      cursor = {
        package = pkgs.bibata-cursors;
        name = "Bibata-Modern-Classic";
        size = 24;
      };
    };

    dconf.settings = {
      "org/gnome/desktop/wm/preferences" = {
        button-layout = "icon:close";
      };
      "org/gnome/desktop/interface" = {
        icon-theme = config.gtk.iconTheme.name;
        color-scheme = lib.mkForce "dark";
      };
      "org/gnome/TextEditor" = {
        highlight-current-line = true;
        show-line-numbers = true;
        style-scheme = lib.mkForce "builder-dark";
        style-variant = lib.mkForce "dark";
        tab-width = lib.hm.gvariant.mkUint32 4;
      };
    };

    stylix.targets.gtksourceview.enable = false; # FUCK YOU STYLIX
    gtk = {
      enable = true;
      iconTheme = {
        name = "Tela-dark";
        package = pkgs.tela-icon-theme;
      };
    };

    stylix.targets.qt.enable = false;
    qt = {
      enable = true;
      style.name = "kvantum";
      platformTheme.name = "gtk";
    };
  };
}
