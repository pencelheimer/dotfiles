{pkgs, ...}: let
  session-cmd = "niri-session"; # HACK: generalize
in {
  config = {
    services.greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${pkgs.tuigreet}/bin/tuigreet --greeting 'Welcome To NixOS' --asterisks --remember --remember-user-session --time --cmd ${session-cmd}";
          user = "greeter";
        };
      };
    };
  };
}
