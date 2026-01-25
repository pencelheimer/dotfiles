{...}: {
  config = {
    services.samba = {
      enable = true;
      openFirewall = true;
      # package = pkgs.samba4Full;
      settings = {
        homes = {
          browseable = "no"; # NOTE: each home will be browseable; the "homes" share will not.
          "read only" = "no";
          "guest ok" = "no";
        };
      };
    };

    services.samba-wsdd = {
      enable = true;
      openFirewall = true;
    };
  };
}
