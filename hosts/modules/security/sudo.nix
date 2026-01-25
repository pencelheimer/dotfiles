{userName, ...}: {
  config = {
    security = {
      # sudo-rs = {
      #   enable = false;
      #   execWheelOnly = true;
      # };

      sudo.enable = true;
    };

    users.users.${userName}.extraGroups = ["wheel"];
  };
}
