{
  programs = {
    git.userEmail = "peter.cho@discordapp.com";

    zsh.initExtra = ''
      [ -f "/home/discord/.iterm2_shell_integration.zsh" ] && source "/home/discord/.iterm2_shell_integration.zsh"
    '';
  };

  home.file = {
    "/home/discord/.config/starship.toml".source = ../config/starship.toml;
  };
}
