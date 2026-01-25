{
  lib,
  config,
  ...
}: {
  stylix.targets.hyprlock.enable = false;

  programs.hyprlock = {
    enable = true;

    settings = with config.lib.stylix.colors; {
      general = {
        grace = 0;
        ignore_empty_input = true;
      };

      background = [
        {
          monitor = "";
          path = "screenshot";
          blur_passes = 3;
          blur_size = 10;
        }
      ];

      label = [
        {
          # Battery Status
          monitor = "";
          text = "cmd[update:10000] upower -i $(upower -e | grep BAT) | awk '/percentage:/ {gsub(\"%\",\"\"); charge=$2} /state:/ {state=$2} END { if (state == \"charging\") print \"\", charge\"%\"; else if (charge < 20) print \"\", charge\"%\"; else if (charge < 40) print \"\", charge\"%\"; else if (charge < 60) print \"\", charge\"%\"; else if (charge < 80) print \"\", charge\"%\"; else print \"\", charge\"%\"; }'";
          color = "rgb(${base09})";
          font_size = 16;
          font_family = "JetBrains Mono Nerd Font";
          halign = "right";
          valign = "top";
        }
        {
          # Fails
          monitor = "";
          text = "$ATTEMPTS[]";
          color = "rgb(${base08})";
          font_size = 16;
          font_family = "JetBrains Mono Nerd Font";
          position = "-100, 0";
          halign = "right";
          valign = "top";
        }
        {
          # Keyboard Layout
          monitor = "";
          text = "$LAYOUT";
          color = "rgb(${base04})";
          font_size = 16;
          font_family = "JetBrains Mono Nerd Font";
          halign = "right";
          valign = "top";
          position = "-150, 0";
        }
        {
          # Time
          monitor = "";
          text = "$TIME";
          color = "rgb(${base05})";
          font_size = 120;
          font_family = "JetBrains Mono Nerd Font ExtraBold";
          halign = "right";
          valign = "top";
        }
      ];

      input-field = [
        {
          monitor = "";
          size = "400, 50";
          halign = "center";
          valign = "center";
          outline_thickness = 2;
          dots_size = 0.2;
          dots_spacing = 0.2;
          dots_center = true;
          fade_on_empty = false;
          hide_input = false;
          font_family = "JetBrains Mono Nerd Font";
          placeholder_text = "Input Password...";
          capslock_color = "rgb(${base04})";
          outer_color = "rgb(${base03})";
          inner_color = "rgb(${base00})";
          font_color = "rgb(${base05})";
          fail_color = "rgb(${base08})";
          check_color = "rgb(${base0A})";
        }
      ];
    };
  };
}
