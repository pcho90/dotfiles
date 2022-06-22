{ nixpkgs, home-manager, host, ... }:

let
  inherit (host) system username email;
  inherit (pkgs.stdenv.hostPlatform) isDarwin;

  pkgs = import nixpkgs { inherit (host) system; };
  homeDirectory = if isDarwin then "/Users/${username}" else "/home/${username}";
in home-manager.lib.homeManagerConfiguration {
  inherit pkgs system username homeDirectory;

  configuration = import ./home.nix { inherit pkgs host homeDirectory; };

  stateVersion = "22.05";
}
