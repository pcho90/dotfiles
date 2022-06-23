{
  programs.git.userEmail = "pcho51990@gmail.com";

  programs.zsh.envExtra =
    ''
      SSH_AUTH_SOCK=$HOME/.ssh/agent
    '';
}
