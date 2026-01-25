{
  config,
  lib,
  ...
}:
{
  options.wm.notifyd.swaync = {
    enable = lib.mkEnableOption "swaync";
  };

  config = lib.mkIf config.wm.notifyd.swaync.enable {
    services.swaync = {
      enable = true;
      settings = {
        positionX = "right";
        positionY = "top";
        layer = "overlay";
        control-center-margin-top = 0;
        control-center-margin-bottom = 0;
        control-center-margin-right = 0;
        control-center-margin-left = 0;
        notification-icon-size = 64;
        notification-body-image-height = 100;
        notification-body-image-width = 200;
        timeout = 8;
        timeout-low = 6;
        timeout-critical = 0;
        fit-to-screen = false;
        control-center-width = 500;
        control-center-height = 1043;
        notification-window-width = 440;
        keyboard-shortcuts = true;
        image-visibility = "when-available";
        transition-time = 200;
        hide-on-clear = false;
        hide-on-action = false;
        script-fail-notify = true;
        widgets = [
          "title"
          "dnd"
          "notifications"
        ];
        widget-config = {
          title = {
            text = "Notification Center";
            clear-all-button = true;
            button-text = "󰆴 Clear All";
          };
          dnd.text = "Do Not Disturb";
          label = {
            max-lines = 1;
            text = "Notification Center";
          };
        };
      };
    };
  };
}
