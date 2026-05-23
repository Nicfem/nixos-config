{
  programs.niri.settings = {
    cursor = {
      size = 24;
    };

    layout = {
      background-color = "transparent";
    };

    layer-rules = [
      {
        matches = [{ namespace = "my-clock";}];
        place-within-backdrop = true;
      }
    ];

    environment = {
      ELECTRON_OZONE_PLATFORM_HINT = "auto";
      XCURSOR_SIZE = "24";
      WLR_NO_HARDWARE_CURSORS  ="1";
    };
    gestures = {
      hot-corners.enable = false;
    };
    
    input = {
      mouse = {
        scroll-method = "no-scroll";
      };
      
      focus-follows-mouse = {
        enable = true;
      };
      
      warp-mouse-to-focus.enable = false;

      focus-follows-mouse.max-scroll-amount = "20%";
      
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
    
    window-rules = [
      {
        matches = [{ }]; # Пустой список — применяется ко всем окнам
        geometry-corner-radius = {
          top-left = 12.0;
          top-right = 12.0;
          bottom-left = 12.0;
          bottom-right = 12.0;
        };
        clip-to-geometry = true; # Обрезает углы самого окна под радиус
        block-out-from = null;
      }
      {
        matches = [{ app-id = "^firefox$"; }]; # Регулярное выражение
        open-maximized = true;
      }
      {
        matches = [{ app-id = "kitty"; }]; # Находим Kitty по app-id
        
        # Устанавливаем прозрачность (0.0 - невидимый, 1.0 - плотный)
        # Попробуйте 0.9 для легкого эффекта
        opacity = 0.8; 
        
        # Отключаем сплошной фон под обводкой, чтобы видеть обои сквозь прозрачность
        draw-border-with-background = false;
      }
    ];

    spawn-at-startup = [
      { argv = [ "firefox" ]; }
      { argv = [ "discord" ]; }
      { argv = [ "Telegram" ]; }
    ];

    screenshot-path = "~/Pictures/Screenshots/Screen_%Y-%m-%d_%H-%M-%S.png";

    binds = {
      # Твои биндинги
      "Mod+T".action.spawn = "kitty";
      "Mod+O".action.toggle-overview = [];
      "Mod+E".action.expand-column-to-available-width = [];

      # Приложения (дефолтные)
      "Mod+Return".action.spawn = "kitty";
      "Mod+Shift+Slash".action.show-hotkey-overlay = [ ];

      # Закрытие
      "Mod+Alt+C".action.close-window = [ ];

      # Фокус мониторов
      "Mod+Alt+H".action.focus-monitor-left = [ ];
      "Mod+Alt+L".action.focus-monitor-right = [ ];

      # Фокус окон
      "Mod+H".action.focus-column-or-monitor-left = [ ];
      "Mod+J".action.focus-window-or-workspace-down = [ ];
      "Mod+K".action.focus-window-or-workspace-up = [ ];
      "Mod+L".action.focus-column-or-monitor-right = [ ];

      # Перемещение окон (исправлено below/above -> down/up)
      "Mod+Shift+H".action.move-column-left-or-to-monitor-left = [ ];
      "Mod+Shift+J".action.move-window-down-or-to-workspace-down = [ ];
      "Mod+Shift+K".action.move-window-up-or-to-workspace-up = [ ];
      "Mod+Shift+L".action.move-column-right-or-to-monitor-right = [ ];
      "Mod+Shift+Left".action.move-column-left = [ ];
      "Mod+Shift+Down".action.move-window-down-or-to-workspace-down = [ ];
      "Mod+Shift+Up".action.move-window-up-or-to-workspace-up = [ ];
      "Mod+Shift+Right".action.move-column-right = [ ];
      "Mod+Alt+V".action.switch-focus-between-floating-and-tiling = [ ];
      "Mod+V".action.toggle-window-floating = [ ];

      # Начало / конец ряда
      "Mod+Home".action.focus-column-first = [ ];
      "Mod+End".action.focus-column-last = [ ];
      "Mod+Shift+Home".action.move-column-to-first = [ ];
      "Mod+Shift+End".action.move-column-to-last = [ ];

      # Мониторы
      "Mod+Shift+Ctrl+H".action.move-column-to-monitor-left = [ ];
      "Mod+Shift+Ctrl+J".action.move-column-to-monitor-down = [ ];
      "Mod+Shift+Ctrl+K".action.move-column-to-monitor-up = [ ];
      "Mod+Shift+Ctrl+L".action.move-column-to-monitor-right = [ ];

      "Mod+U".action.focus-workspace-down = [ ];
      "Mod+I".action.focus-workspace-up = [ ];
      
      # Исправлено: move-column-to-workspace-down/up
      "Mod+Shift+U".action.move-column-to-workspace-down = [ ];
      "Mod+Shift+I".action.move-column-to-workspace-up = [ ];
      
      "Mod+Ctrl+Page_Down".action.move-workspace-down = [ ];
      "Mod+Ctrl+Page_Up".action.move-workspace-up = [ ];

      # Воркспейсы по номеру
      "Mod+1".action.focus-workspace = 1;
      "Mod+2".action.focus-workspace = 2;
      "Mod+3".action.focus-workspace = 3;
      "Mod+4".action.focus-workspace = 4;
      "Mod+5".action.focus-workspace = 5;
      "Mod+6".action.focus-workspace = 6;
      "Mod+7".action.focus-workspace = 7;
      "Mod+8".action.focus-workspace = 8;
      "Mod+9".action.focus-workspace = 9;
      "Mod+Shift+1".action.move-column-to-workspace = 1;
      "Mod+Shift+2".action.move-column-to-workspace = 2;
      "Mod+Shift+3".action.move-column-to-workspace = 3;
      "Mod+Shift+4".action.move-column-to-workspace = 4;
      "Mod+Shift+5".action.move-column-to-workspace = 5;
      "Mod+Shift+6".action.move-column-to-workspace = 6;
      "Mod+Shift+7".action.move-column-to-workspace = 7;
      "Mod+Shift+8".action.move-column-to-workspace = 8;
      "Mod+Shift+9".action.move-column-to-workspace = 9;

      # Размер колонок
      "Mod+BracketLeft".action.consume-or-expel-window-left = [ ];
      "Mod+BracketRight".action.consume-or-expel-window-right = [ ];
      "Mod+Comma".action.consume-window-into-column = [ ];
      "Mod+Period".action.expel-window-from-column = [ ];

      "Mod+R".action.switch-preset-column-width = [ ];
      "Mod+Shift+R".action.switch-preset-window-height = [ ];
      "Mod+Ctrl+R".action.reset-window-height = [ ];
      "Mod+F".action.maximize-column = [ ];
      "Mod+Shift+F".action.fullscreen-window = [ ];
      "Mod+Ctrl+F".action.expand-column-to-available-width = [ ];

      "Mod+Minus".action.set-column-width = "-10%";
      "Mod+Equal".action.set-column-width = "+10%";
      "Mod+Shift+Minus".action.set-window-height = "-10%";
      "Mod+Shift+Equal".action.set-window-height = "+10%";

      # Скриншоты
      "Mod+S".action.screenshot = [ ];
      "Mod+Alt+J".action.screenshot-screen = [ ];
      "Mod+Alt+K".action.screenshot-window = [ ];

      # Громкость
      "XF86AudioRaiseVolume" = {
        action.spawn = [ "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1+" ];
        allow-when-locked = true;
      };
      "XF86AudioLowerVolume" = {
        action.spawn = [ "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1-" ];
        allow-when-locked = true;
      };
      "XF86AudioMute" = {
        action.spawn = [ "wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle" ];
        allow-when-locked = true;
      };
      "XF86AudioMicMute" = {
        action.spawn = [ "wpctl" "set-mute" "@DEFAULT_AUDIO_SOURCE@" "toggle" ];
        allow-when-locked = true;
      };

      # Яркость
      "XF86MonBrightnessUp".action.spawn = [ "brightnessctl" "set" "+10%" ];
      "XF86MonBrightnessDown".action.spawn = [ "brightnessctl" "set" "10%-" ];

      # Выход
      "Mod+Shift+E".action.quit = [ ];
      "Mod+Shift+P".action.power-off-monitors = [ ];
    };
  };
}
