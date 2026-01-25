{userName, ...}: {
  config = {
    programs.gamemode.enable = true;
    users.users.${userName}.extraGroups = ["gamemode"];
  };
}
