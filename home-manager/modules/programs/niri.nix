{
  programs.niri.settings = {
    input = {
      keyboard = {
        xkb = {
          layout = "us,ru";
          options = "grp:alt_shift_toggle";
        };
      };
    };

    outputs = {
      "DP-1" = {
        position = { x = 0; y = 0; };
        mode = {
          width = 1920;
          height = 1080;
          refresh = 165.004;
        };
      };
      "HDMI-A-1" = {
        position = { x = 1920; y = 0; };
        mode = {
          width = 1920;
          height = 1080;
          refresh = 120.000;
        };
      };
    };
    spawn-at-startup = [
      { argv = ["kitty"]; }
      { argv = ["alacritty"]; }
      { argv = ["firefox"]; }
    ];

    binds = {
      "Mod+T".action.spawn = "kitty";
    };
  };
}

