{ pkgs, inputs, ... }: {

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
    inputs.ags.packages.${pkgs.system}.default
    
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
