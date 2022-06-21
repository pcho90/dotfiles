{ configs, pkgs, ... }:

{
  imports = [
    ./common.nix
  ];

  home.username = "discord";
  home.homeDirectory = "/home/discord";
  programs.git.userEmail = "peter.cho@discordapp.com";
}
