{...}: {
  config = {
    security = {
      # TODO: move soteria from here?
      soteria.enable = true; # gtk polkit agent in rust

      pam.sshAgentAuth.enable = true;

      polkit = {
        enable = true;
        extraConfig =
          # javascript
          ''
            polkit.addRule(function(action, subject) {
              if (
                subject.isInGroup("users")
                  && (
                    action.id == "org.freedesktop.login1.reboot" ||
                    action.id == "org.freedesktop.login1.reboot-multiple-sessions" ||
                    action.id == "org.freedesktop.login1.power-off" ||
                    action.id == "org.freedesktop.login1.power-off-multiple-sessions"
                  )
                )
              {
                return polkit.Result.YES;
              }
            });
          '';
      };
    };
  };
}
