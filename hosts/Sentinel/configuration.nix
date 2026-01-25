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

  services.tailscale.enable = true;

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

    wineWowPackages.stableFull

    (lib.hiPrio pkgs.uutils-coreutils-noprefix)
    (lib.hiPrio pkgs.uutils-findutils)
    (lib.hiPrio pkgs.uutils-diffutils)

    bitwarden-desktop
  ];

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
