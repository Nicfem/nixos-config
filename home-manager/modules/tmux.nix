{ inputs, pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    clock24 = false;

    extraConfig = builtins.readFile "${inputs.tmux}/tmux.conf";
    plugins  = with pkgs; [
       tmuxPlugins.vim-tmux-navigator
    ];
  };
}
