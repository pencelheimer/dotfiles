{...}: {
  imports = [
    ./sudo.nix
    ./firewall.nix
    ./polkit.nix
  ];
  config = {};
}
