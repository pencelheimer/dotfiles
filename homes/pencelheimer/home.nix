{...}: {
  imports = [
    ../modules
    ./pkgs.nix
  ];

  config = {
    user = {
      userName = "pencelheimer";
      userEmail = "pencelheimer@proton.me";
    };

    nixpkgs.config.allowUnfree = true;

    programs.nh.enable = true;
    programs.nh.flake = "/home/pencelheimer/.config/nixos";

    programs.home-manager.enable = true;
    home.stateVersion = "25.05";

    # TODO: move it
    services.udiskie = {
      enable = true;
      automount = true;
      notify = true;
      tray = "auto";
    };

    xdg.desktopEntries = {
      mirror-screen = {
        name = "Mirror Main Screen";
        genericName = "Mirror";
        icon = "video-joined-displays-symbolic";
        exec = "wl-present mirror eDP-1";
        terminal = false;
        categories = ["Utility"];
      };
      mirror-screen-toggle = {
        name = "Mirror Pause Toggle";
        genericName = "Mirror";
        icon = "media-playback-pause";
        exec = "wl-present toggle-freeze";
        terminal = false;
        categories = ["Utility"];
      };
    };

    xdg.userDirs = let
      homeDir = f: "$HOME/${f}";
    in {
      enable = true;
      setSessionVariables = true;
      createDirectories = true;
      templates = homeDir "Templates";
      publicShare = homeDir "Public";
      desktop = homeDir "Desktop";
      download = homeDir "Downloads";
      documents = homeDir "Documents";
      pictures = homeDir "Pictures";
      videos = homeDir "Videos";
      music = homeDir "Music";
    };
  };
}
