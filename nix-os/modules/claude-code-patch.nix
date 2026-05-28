{ pkgs, inputs, ... }:

let
  tweakcc = inputs.tweakcc.packages.${pkgs.system}.tweakcc;

in
{
  nixpkgs.overlays = [
    (_final: prev: {
      tweakcc = tweakcc;
      
      claude-code = prev.claude-code.overrideAttrs (old: {
        nativeBuildInputs = (old.nativeBuildInputs or [ ]) ++ [ tweakcc ];

        postInstall = (old.postInstall or "") + ''
          TWEAKCC_CC_INSTALLATION_PATH="$out/bin/claude" tweakcc --apply
        '';
      });
    })
  ];
}
