{ pkgs, host, system, overlays, ... }:

let
  inherit (pkgs.stdenv.hostPlatform) isLinux isDarwin;
  inherit (host) username;
  inherit overlays;

  homeDirectory = if isDarwin then "/Users/${username}" else "/home/${username}";
  packages = with pkgs; [
    bat
    delta
    fzf
    ripgrep
    tmux
    tree
  ];
in
{
  home = {
    # Home Manager needs a bit of information about you and the
    # paths it should manage.
    inherit (host) username;
    inherit homeDirectory packages;

    file.".vimrc".source = ./vimrc;

    # This value determines the Home Manager release that your
    # configuration is compatible with. This helps avoid breakage
    # when a new Home Manager release introduces backwards
    # incompatible changes.
    #
    # You can update Home Manager without changing this value. See
    # the Home Manager release notes for a list of state version
    # changes in each release.
    stateVersion = "22.05";
  };

  programs = {
    # Let Home Manager install and manage itself.
    home-manager.enable = true;
    git = {
      enable = true;
      userName = "Peter Cho";
      userEmail = "peter.cho@discordapp.com";
      core.editor = "nvim";
      core.pager = "delta";
      interactive.diffFilter = "delta --color-only";
      delta.navigate = true;
      delta.light = false;
      delta.side-by-side = true;
      merge.conflictstyle = "diff3";
      diff.colorMoved = "default";
    };
    fzf = {
      enable = true;
      enableZshIntegration = true;
    };
    zsh = {
      enable = true;
      enableCompletion = true;
      enableAutosuggestions = true;
      enableSyntaxHighlighting = true;
      oh-my-zsh = {
        enable = true;
        plugins = [ "git" "z" "vi-mode" "zsh-autosuggestions" ];
        theme = "robbyrussell";
      };
      initExtra = (builtins.readFile ./zshrc);
    };
  };

  services = { };

  nixpkgs.overlays = overlays;
};
