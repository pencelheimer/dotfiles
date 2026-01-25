{...}: {
  services.gammastep = {
    enable = true;
    provider = "geoclue2";
    tray = true;
    temperature.night = 3700; # day = 6500;
  };
}
