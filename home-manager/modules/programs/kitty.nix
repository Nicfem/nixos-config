{ pkgs, ... }:

{
  programs.kitty = {
    enable = true;
    
    font = {
      name = "JetBrainsMono Nerd Font";
      size = 11;
    };

    settings = {
      scrollback_lines = 10000;
      enable_audio_bell = false;
      update_check_interval = 0;
      copy_on_select = "no";
      
      confirm_os_window_close = 0;
      window_padding_width = 4;
    };

    keybindings = {
      "ctrl+plus" = "change_font_size all +2.0";
      "ctrl+minus" = "change_font_size all -2.0";
      "ctrl+0" = "restore_font_size";
      "ctrl+c" = "copy_and_clear_or_interrupt";
      "ctrl+v" = "paste_from_clipboard";
      
      "ctrl+shift+c" = "no_op";
      "ctrl+shift+v" = "no_up";
      
      # Быстрое открытие ссылок
      "ctrl+shift+o" = "open_url_with_hints";
    };

    # Тема (выбери любую по вкусу)
    themeFile = "Catppuccin-Mocha";
  };
}
