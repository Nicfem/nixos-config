{ pkgs, ... }: {

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
    
    # Desktop apps
    telegram-desktop
    discord

    # Development
    nodejs_24
    cargo
    gcc

    # Core
    xwayland-satellite
  ];
}
