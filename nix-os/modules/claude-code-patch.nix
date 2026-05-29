{ pkgs, inputs, ... }:

let
  tweakcc = inputs.tweakcc.packages.${pkgs.system}.default;
in
{
  nixpkgs.overlays = [
    (_final: prev: {
      claude-code = prev.claude-code.overrideAttrs (old: {
        nativeBuildInputs = (old.nativeBuildInputs or [ ]) ++ [ tweakcc ];

        postInstall = (old.postInstall or "") + ''
          export HOME=$(mktemp -d)
          export TWEAKCC_CONFIG_DIR=$(mktemp -d)
          cp --no-preserve=mode ${inputs.tweakcc}/config.json "$TWEAKCC_CONFIG_DIR/config.json"

          TWEAKCC_CC_INSTALLATION_PATH="$out/bin/claude" tweakcc --apply
        '';
      });
    })
  ];
}
