{ pkgs, user, ... }:
{
  programs.zsh.enable = true;
  programs.xwayland.enable = true;
  services.libinput.enable = true;

  users = {
    defaultUserShell = pkgs.zsh;
    users.${user} = {
      shell = pkgs.zsh;
      isNormalUser = true;
      extraGroups = [ "wheel" "input" "networkmanager" "docker" ];
    };
  };
}
