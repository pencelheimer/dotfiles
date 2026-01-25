{...}: {
  config = {
    time.timeZone = "Europe/Kyiv";

    i18n.defaultLocale = "en_US.UTF-8";

    i18n.extraLocaleSettings = {
      LC_ADDRESS = "C.UTF-8";
      LC_IDENTIFICATION = "C.UTF-8";
      LC_MEASUREMENT = "C.UTF-8";
      LC_MONETARY = "C.UTF-8";
      LC_NAME = "C.UTF-8";
      LC_NUMERIC = "C.UTF-8";
      LC_PAPER = "C.UTF-8";
      LC_TELEPHONE = "C.UTF-8";
      LC_TIME = "C.UTF-8";
    };
  };
}
