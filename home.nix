{ pkgs, host, homeDirectory, ... }:

{
  imports = [
    ./common.nix
    ./hosts/${host.name}.nix
  ];

  home.username = host.username;
  home.homeDirectory = homeDirectory;
}
