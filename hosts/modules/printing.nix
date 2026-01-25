{pkgs, ...}: {
  environment.systemPackages = with pkgs; [cups-filters];

  services.printing.enable = true;
  services.printing.drivers = with pkgs; [
    samsung-unified-linux-driver
    splix
  ];

  #TODO add permanent printer config
}
