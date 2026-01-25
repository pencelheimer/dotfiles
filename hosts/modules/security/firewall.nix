{...}: {
  config = {
    networking.firewall = {
      enable = true;

      allowedTCPPorts = [
        6969
        5520
      ];
      allowedUDPPorts = [
        6969
        5520
      ];

      allowedTCPPortRanges = [
        {
          from = 1714;
          to = 1764;
        } # KDE Connect
      ];
      allowedUDPPortRanges = [
        {
          from = 1714;
          to = 1764;
        } # KDE Connect
      ];
    };
  };
}
