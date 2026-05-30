{ config, pkgs, lib, ... }:

{
  programs.firefox = {
    enable = true;
    profiles.default = { # Если твой профиль называется иначе (например, dmitry), замени тут
      # ИСПРАВЛЕНО: Современный синтаксис Home Manager без депрекейшн-ворнингов
      path = "h3im5o8f.default";
      isDefault = true;
      settings = {
        "full-screen-api.warning.timeout" = 0;
      };
    };

    policies = {
      # BlockAboutConfig = true;
      ExtensionSettings = {
        "uBlock0@raymondhill.net" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
          installation_mode = "force_installed";
          private_browsing = true;
        };
        "vot-extension@firefox" = {
          install_url = "https://github.com/ilyhalight/voice-over-translation/releases/download/1.11.5/vot-extension-firefox-1.11.5.xpi";
          installation_mode = "force_installed";
          private_browsing = true;

        };
        "firefox@betterttv.net" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/firefox@betterttv.net/latest.xpi";
          installation_mode = "force_installed";
          private_browsing = true;
        };
      };
    };
  };
}
