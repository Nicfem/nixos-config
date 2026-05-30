{ pkgs, config, ... }:

{
  programs.claude-code = {
    enable = true;

    mcpServers = {
      nixos = {
        type = "stdio";
        command = "mcp-nixos";
      };
    };
  };
  
  home.packages = with pkgs; [
    vtsls
    nodePackages.typescript
    pyright
    mcp-nixos
  ];
}
