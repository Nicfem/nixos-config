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

# Check flake for errors
nix flake check
```

## Architecture

This is a NixOS system configuration managed as a single flake (`flake.nix`). It targets `x86_64-linux` for a single host (`nixos`) and user (`dmitry`).

**Two configuration trees live side by side:**

- `nix-os/` — system-level NixOS configuration
  - `configuration.nix` — root system config (networking, users, locale, shell)
  - `hardware-configuration.nix` — auto-generated hardware config (do not edit manually)
  - `modules/` — system modules imported via `modules/default.nix`
    - `lanzaboot.nix` — secure boot via lanzaboote
    - `drivers.nix`, `audio.nix`, `bluethooth.nix`, `virtualization.nix`
    - `programs/` — system-level programs (steam, niri)

- `home-manager/` — user-level configuration (runs as a NixOS module, not standalone)
  - `home.nix` — home-manager entry point
  - `modules/` — user modules imported via `modules/default.nix`
    - `packages.nix` — user packages
    - `zsh.nix`, `tmux.nix`, `claude-code.nix`
    - `programs/` — per-program configs: firefox (with extensions via policies), niri, kitty, git, gh

**Flake inputs:** `nixpkgs` (nixos-25.11), `home-manager` (release-25.11), `lanzaboote`, `niri-flake`, and a custom `tmux` flake from GitHub.

Home-manager is wired in as a NixOS module (`home-manager.nixosModules.home-manager`) with `useGlobalPkgs = true` and `useUserPackages = true`. The same `homeStateVersion` variable is shared between NixOS `system.stateVersion` and home-manager `home.stateVersion`.

## Conventions

- Add new system-level features in `nix-os/modules/` and register them in `nix-os/modules/default.nix`.
- Add new user-level features in `home-manager/modules/` and register them in `home-manager/modules/default.nix`.
- Firefox extensions are managed via `programs.firefox.policies.ExtensionSettings` (force-installed), not user profile settings.
- `specialArgs` / `extraSpecialArgs` pass `inputs`, `homeStateVersion`, `hostname`, and `user` throughout the module tree.
