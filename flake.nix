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
        name = "coder";
        system = "x86_64-linux";
        username = "discord";
      };

      discord-mbp = {
        name = "discord-mbp";
        system = "x86_64-darwin";
        username = "peter.cho";
      };

      personal-mbp = {
        name = "personal-mbp";
        system = "x86_64-darwin";
        username = "pcho";
      };
    };
  in {
    homeConfigurations = builtins.mapAttrs (name: host: (
      let
        inherit (host) system username email;
        inherit (pkgs.stdenv.hostPlatform) isDarwin;

        pkgs = import nixpkgs { inherit (host) system; };
        homeDirectory = if isDarwin then "/Users/${username}" else "/home/${username}";
      in home-manager.lib.homeManagerConfiguration {
        inherit pkgs system username homeDirectory;

        configuration = import ./common.nix { inherit pkgs host homeDirectory; };
        stateVersion = "22.05";
      }
    )) hosts;
  };
}
