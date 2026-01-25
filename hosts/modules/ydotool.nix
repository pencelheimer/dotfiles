{userName, ...}: {
  programs.ydotool.enable = true;
  users.users.${userName}.extraGroups = ["ydotool"];
}
