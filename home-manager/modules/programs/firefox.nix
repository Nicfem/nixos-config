{ config, pkgs, lib, ... }:

let
  vot-firefox-addon = pkgs.stdenv.mkDerivation {
    pname = "vot-extension-firefox";
    version = "1.11.5";

    src = pkgs.fetchurl {
      url = "https://github.com/ilyhalight/voice-over-translation/releases/download/1.11.5/vot-extension-firefox-1.11.5.xpi";
      hash = "sha256-LwRQb8u+CJ1w9ovRD7ZLb718v/o9Ulk8Panu4ciB+gg=";
    };

    dontUnpack = true;

    installPhase = ''
      mkdir -p $out/share/mozilla/extensions/\{ec8030f7-c20a-464f-9b0e-13a3a9e97384\}
      cp $src $out/share/mozilla/extensions/\{ec8030f7-c20a-464f-9b0e-13a3a9e97384\}/vot-extension@firefox.xpi
    '';
    # installPhase = ''
    #   mkdir -p $out
    #   cp $src $out/vot-extension@firefox.xpi
    # '';
  };
in
{
  programs.firefox = {
    enable = true;
    
    profiles.default = { # Если твой профиль называется иначе (например, dmitry), замени тут
      # ИСПРАВЛЕНО: Современный синтаксис Home Manager без депрекейшн-ворнингов
      path = "h3im5o8f.default";
      isDefault = true;

      extensions.force = true;
      
      extensions.packages = [
        vot-firefox-addon
      ];

      # Настройки Firefox, чтобы он разрешил запуск локально собранного расширения
      settings = {
        "xpinstall.signatures.required" = false;
        "extensions.autoDisableScopes" = 0;
      };
    };
  };
}
