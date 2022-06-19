{
  description = "pcho90's Nix Config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    darwin.url = "github:lnl7/nix-darwin/master";
    darwin.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nixos-vscode-server.url = "github:msteen/nixos-vscode-server";
    nixos-vscode-server.flake = false;

    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    neovim-nightly-overlay.inputs.neovim-flake.url = "github:neovim/neovim/v0.7.0?dir=contrib";
  };

  outputs = inputs@{ self, nixpkgs, darwin, home-manager, ... }:
    let
      hosts = {
        macbook = {
          hostname = "MBP-PCho.local";
          username = "peter.cho";
          system = "x86_64-darwin";
          keys = [ "id_ed25519" ];
        };
        coder = {
          hostname = "coder";
          username = "discord";
          system = "x86_64-linux";
          keys = null;
        };
      };
      overlays = [ inputs.neovim-nightly-overlay.overlay ];
    in
    {
      homeConfigurations = builtins.mapAttrs (name: host: { nixpkgs, home-manager, darwin, overlays, inputs, host }:
        let
          inherit (host) system username;
          pkgs = import nixpkgs {
            inherit (host) system;
          };
          inherit (pkgs.stdenv.hostPlatform) isDarwin;
          homeDirectory = if isDarwin then "/Users/${username}" else "/home/${username}";
        in
          home-manager.lib.homeManagerConfiguration {
            inherit system username homeDirectory;
            configuration = import ./home.nix {
              inherit pkgs host system overlays;
            };
          }
      ) hosts;
    };
}
