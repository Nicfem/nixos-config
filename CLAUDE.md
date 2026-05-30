# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Applying Configuration

```bash
# Rebuild and switch NixOS + home-manager in one step
sudo nixos-rebuild switch --flake .#nixos

# Build without switching (dry run / check)
sudo nixos-rebuild build --flake .#nixos

# Update flake inputs
nix flake update

# Check flake for evaluation errors (fast, no build)
nix flake check --no-build

# Full check including build validation
nix flake check
```

**Before applying changes always run `nix flake check --no-build` to catch evaluation errors early.**

## Available Tools

An MCP server for NixOS is available — use it to look up NixOS and home-manager options, search packages, and verify option names and types before writing config. Tools:

- `mcp__nixos__nixos_search` — search NixOS packages or options
- `mcp__nixos__home_manager_search` — search home-manager options
- `mcp__nixos__nixos_options_by_prefix` — browse options by prefix (e.g. `nix.settings`)
- `mcp__nixos__home_manager_options_by_prefix` — same for home-manager

Always use these instead of guessing option names.

## Architecture

This is a NixOS system configuration managed as a single flake (`flake.nix`). It targets `x86_64-linux` for a single host (`nixos`) and user (`dmitry`).

**Two configuration trees live side by side:**

- `nix-os/` — system-level NixOS configuration
  - `configuration.nix` — root system config
  - `hardware-configuration.nix` — auto-generated, do not edit manually
  - `modules/` — system modules imported via `modules/default.nix`
    - `nix-settings.nix` — nix daemon settings, trusted-users, registry, allowUnfree
    - `lanzaboot.nix` — secure boot via lanzaboote
    - `drivers.nix`, `audio.nix`, `bluethooth.nix`, `virtualization.nix`
    - `claude-code-patch.nix` — overlays claude-code with tweakcc patch
    - `programs/` — `niri.nix`, `steam.nix`

- `home-manager/` — user-level configuration (runs as a NixOS module, not standalone)
  - `home.nix` — home-manager entry point
  - `modules/` — user modules imported via `modules/default.nix`
    - `packages.nix` — user packages (includes arc-midnight-cursors custom pkg)
    - `zsh.nix` — zsh with oh-my-zsh, sets `NIXPKGS_ALLOW_UNFREE=1`
    - `tmux.nix`, `claude-code.nix`
    - `pkgs/` — custom package expressions (e.g. `arc-midnight-cursors.nix`)
    - `programs/` — `firefox.nix`, `niri.nix`, `kitty.nix`, `git.nix`, `gh.nix`

**Flake inputs:** `nixpkgs` (nixos-25.11), `home-manager` (release-25.11), `lanzaboote`, `niri-flake`, custom `tmux`, `ags`, and `tweakcc` from GitHub.

Home-manager is wired in as a NixOS module (`home-manager.nixosModules.home-manager`) with `useGlobalPkgs = true` and `useUserPackages = true`. The same `homeStateVersion` variable is shared between NixOS `system.stateVersion` and home-manager `home.stateVersion`.

## Conventions

- Add new system-level features in `nix-os/modules/` and register them in `nix-os/modules/default.nix`.
- Add new user-level features in `home-manager/modules/` and register them in `home-manager/modules/default.nix`.
- Use `pkgs.stdenv.hostPlatform.system` instead of `pkgs.system` (deprecated).
- Firefox extensions are managed via `programs.firefox.policies.ExtensionSettings` (force-installed), not user profile settings.
- `specialArgs` / `extraSpecialArgs` pass `inputs`, `homeStateVersion`, `hostname`, and `user` throughout the module tree.
- For ad-hoc unfree packages: `nix shell --impure nixpkgs#pkg` — `NIXPKGS_ALLOW_UNFREE=1` is already set in the environment.
- `nix.registry.nixpkgs` is pinned to the flake input — `nix run nixpkgs#...` uses the locked version.
