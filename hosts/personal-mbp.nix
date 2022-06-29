{
  programs = {
    git.userEmail = "pcho51990@gmail.com";

    zsh.envExtra = ''
      export SSH_AUTH_SOCK=$HOME/.ssh/agent
    '';
  };

  home.file = {
    "Library/LaunchAgents/com.zerowidth.launched.ssh_agent.plist".source = ../config/ssh/agent.plist;

    ".ssh/config".text = ''
      Host gh
        HostName github.com
        User git
    '';
  };
}
