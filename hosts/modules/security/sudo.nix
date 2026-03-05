{userName, ...}: {
  config = {
    security = {
      sudo-rs = {
        enable = true;
        execWheelOnly = true;
      };

      # sudo.enable = true;
    };

    users.users.${userName}.extraGroups = ["wheel"];
  };
}
