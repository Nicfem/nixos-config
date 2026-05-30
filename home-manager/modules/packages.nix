{ pkgs, inputs, ... }:

let
  arc-midnight-cursors = pkgs.callPackage ./pkgs/arc-midnight-cursors.nix { };
in {

  home.pointerCursor = {
    package = arc-midnight-cursors;
    name = "ArcMidnight-Cursors";
    size = 24;
    gtk.enable = true;
    x11.enable = true;
  };

  home.packages = with pkgs; [
    # CLI utils
    wl-clipboard
    ripgrep
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    neovim
    unzip
    wget
    zip
    fzf
    udisks

    # my packages
    inputs.ags.packages.${pkgs.stdenv.hostPlatform.system}.default
    
    # Desktop apps
    telegram-desktop
    discord

    # Development
    nodejs_24
    cargo
    gcc

    # niri deps
    xwayland-satellite
    xdg-desktop-portal-gnome
  ];
}
