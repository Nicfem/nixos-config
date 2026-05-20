{ homeStateVersion, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./modules
  ];

  system.stateVersion = homeStateVersion;
}
