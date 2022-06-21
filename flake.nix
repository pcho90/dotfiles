{
  description = "home manager flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.05";
    home-manager.url = "github:nix-community/home-manager/release-22.05";
  };

  outputs = inputs@{ self, nixpkgs, home-manager, ... }:
  let
    hosts = {
      coder = {
        system = "x86_64-linux";
        username = "discord";
        email = "peter.cho@discordapp.com";
      };
      discord-mbp = {
        system = "x86_64-darwin";
        username = "peter.cho";
        email = "peter.cho@discordapp.com";
      };
      personal-mbp = {
        system = "x86_64-darwin";
        username = "pcho";
        email = "pcho51990@gmail.com";
      };
    };
    buildConfig = import ./config.nix;
  in {
    homeConfigurations = builtins.mapAttrs (name: host: (
      buildConfig { inherit nixpkgs home-manager host; }
    )) hosts;
  };
}
