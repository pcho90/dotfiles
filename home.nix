{ pkgs, system, host, homeDirectory, ... }:

{
  imports = [
    ./common.nix
  ];

  home.username = host.username;
  home.homeDirectory = homeDirectory;
  programs.git.userEmail = host.email;
}
