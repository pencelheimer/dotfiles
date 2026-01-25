{userName, ...}: {
  config = {
    networking.networkmanager = {
      enable = true;
      # wifi.backend = "iwd";
    };
    users.users.${userName}.extraGroups = ["networkmanager"];

    # networking.wireless.iwd.enable = true;

    services.avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
      publish.enable = true;
      publish.userServices = true;
    };

    services.cloudflared = {
      enable = false;
      tunnels = {
        "cfb29dc5-e724-4fde-8d82-364dbd86cd20" = {
          # HACK: rewrite with sops or whatever
          credentialsFile = "/home/pencelheimer/.cloudflared/cfb29dc5-e724-4fde-8d82-364dbd86cd20.json";
          default = "http_status:404";
        };
      };
    };

    services.cloudflare-warp.enable = false;
  };
}
