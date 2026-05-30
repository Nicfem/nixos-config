{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      ll = "ls -l";
      edit = "sudo -e";
      update = "sudo nixos-rebuild switch";
    };

    envExtra = ''
      export NIXPKGS_ALLOW_UNFREE=1
    '';

    history.size = 10000;
    history.path = "$HOME/.zsh_history";

    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "fzf"
      ];
      theme = "robbyrussell";
    };
  };
}
