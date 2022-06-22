{
  programs.git.userEmail = "pcho51990@gmail.com";

  programs.zsh.envExtra =
    ''
      ${builtins.readFile ../config/zshenv}
      SSH_AUTH_SOCK=$HOME/.ssh/agent
    '';
}
