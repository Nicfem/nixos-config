{ pkgs, config, ... }:

{
  programs.claude-code = {
    enable = true;

    mcpServers = {
      nixos = {
        type = "stdio";
        command = "${pkgs.mcp-nixos}/bin/mcp-nixos";
      };
    };
  };

  home.sessionVariables = {
    ENABLE_LSP_TOOL = "1";
  };
  
  home.packages = with pkgs; [
    vtsls
    nodePackages.typescript
    pyright
  ];
}
