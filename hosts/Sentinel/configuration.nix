{
  pkgs,
  lib,
  hostName,
  userName,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ../modules
  ];

  networking.hostName = hostName;

  # NOTE: set a password with `passwd`
  users.users.${userName} = {
    isNormalUser = true;
    description = "${userName}";
    extraGroups = ["networkmanager" "dialout" "plugdev"];
  };

  # HACK: probably should move it somwhere else and add option for enabling bitwarden
  # environment.sessionVariables.SSH_AUTH_SOCK = "$HOME/.var/app/com.bitwarden.desktop/data/.bitwarden-ssh-agent.sock";
  environment.sessionVariables.SSH_AUTH_SOCK = "$HOME/.bitwarden-ssh-agent.sock";

  # nix search nixpkgs ...
  environment.systemPackages = with pkgs; [
    wget
    curl
    unzip
    wl-clipboard-rs
    killall
    file
    usbutils
    pciutils

    xwayland-satellite

    wineWowPackages.stable

    (lib.hiPrio pkgs.uutils-coreutils-noprefix)
    (lib.hiPrio pkgs.uutils-findutils)
    (lib.hiPrio pkgs.uutils-diffutils)

    bitwarden-desktop
  ];

  services.throttled = {
    enable = true;

    # NOTE (pencelheimer): throttled support in nixos is insufficient; the
    # extraConig option actually rewrites the configuration entirely. I have
    # changed only the [UNDERVOLT] section.
    # extraConfig = let
    #   core = "0";
    #   cache = "0";
    #   gpu = "0";
    #   uncore = "0";
    #   analogio = "0";
    # in
    #   # ini
    #   ''
    #     [GENERAL]
    #     Enabled: True
    #     Sysfs_Power_Path: /sys/class/power_supply/AC*/online
    #     Autoreload: True
    #
    #     [BATTERY]
    #     Update_Rate_s: 30
    #     PL1_Tdp_W: 29
    #     PL1_Duration_s: 28
    #     PL2_Tdp_W: 44
    #     PL2_Duration_S: 0.002
    #     Trip_Temp_C: 85
    #     cTDP: 0
    #     Disable_BDPROCHOT: False
    #
    #     [AC]
    #     Update_Rate_s: 5
    #     PL1_Tdp_W: 44
    #     PL1_Duration_s: 28
    #     PL2_Tdp_W: 44
    #     PL2_Duration_S: 0.002
    #     Trip_Temp_C: 95
    #     cTDP: 0
    #     Disable_BDPROCHOT: False
    #
    #     [UNDERVOLT]
    #     CORE: ${core}
    #     CACHE: ${cache}
    #     GPU: ${gpu}
    #     UNCORE: ${uncore}
    #     ANALOGIO: ${analogio}
    #   '';
  };

  services.upower.enable = true;
  services.geoclue2.enable = true;
  services.gnome.sushi.enable = true;

  programs.niri.enable = true;
  programs.appimage = {
    enable = true;
    binfmt = true;
  };

  programs.steam = {
    localNetworkGameTransfers.openFirewall = true;
  };

  system.stateVersion = "25.05";
}
