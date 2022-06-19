{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "peter.cho";
  home.homeDirectory = "/Users/peter.cho";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.05";

  home.packages = with pkgs; [
    bat
    delta
    fzf
    ripgrep
    tree
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.git = {
    enable = true;
    userName = "peter.cho";
    userEmail = "peter.cho@discordapp.com";
    extraConfig = {
      core = {
        pager = "delta";
      };
      delta = {
        enable = true;
        navigate = true;
        side-by-side = true;
      };
      interactive = {
        diffFilter = "delta --color-only";
      };
    };
  };

  programs.tmux = {
    enable = true;
    keyMode = "vi";
    terminal = "xterm-256color";
    extraConfig = ''
      set-option -g mouse on
    '';
  };

  programs.vim = {
    enable = true;
  };
}
