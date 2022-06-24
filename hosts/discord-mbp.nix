{
  programs = {
    git.userEmail = "peter.cho@discordapp.com";

    zsh = {
      initExtra = ''
        [ -f "$HOME/.nix-profile/etc/profile.d/nix.sh" ] && source "$HOME/.nix-profile/etc/profile.d/nix.sh"
        launchctl disable user/$UID/com.openssh.ssh-agent
        launchctl load -w ~/Library/LaunchAgents/com.zerowidth.launched.ssh_agent.plist > /dev/null 2>&1
      '';
      envExtra = ''
        export SSH_AUTH_SOCK=$HOME/.ssh/agent
      '';
    };
  };

  home.file = {
    "Library/LaunchAgents/com.zerowidth.launched.ssh_agent.plist".source = ../config/ssh/agent.plist;
    "/Users/peter.cho/.config/starship.toml".source = ../config/starship.toml;
    ".ssh/config".text = ''
      Host *
          AddKeysToAgent yes
          IgnoreUnknown UseKeychain
          UseKeychain yes
          IdentityFile ~/.ssh/id_ed25519_sk


      Host coder.pcho90-dev
          HostName coder.pcho90-dev
          ProxyCommand /Users/peter.cho/.ssh/.coder-proxy-script-us-east-pcho90-dev.sh
          StrictHostKeyChecking no
          ConnectTimeout 0
          IdentitiesOnly yes
          IdentityFile /Users/peter.cho/.ssh/coder_enterprise
          ServerAliveInterval 60
          ServerAliveCountMax 3
          ControlMaster auto
          ControlPersist 600
          ControlPath /Users/peter.cho/.ssh/.connection-coder-US_EAST-pcho90-dev
          ForwardAgent no
    '';
  };
}
