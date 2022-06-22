{
  programs.git.userEmail = "peter.cho@discordapp.com";

  programs.zsh.initExtra =
    ''
      [ -f "$HOME/.nix-profile/etc/profile.d/nix.sh" ] && source "$HOME/.nix-profile/etc/profile.d/nix.sh"
    '';
  programs.zsh.envExtra =
    ''
      ${builtins.readFile ../config/zshenv}
      export SSH_AUTH_SOCK=$HOME/.ssh/agent
    '';
  home.file."Library/LaunchAgents/com.zerowidth.launched.ssh_agent.plist".source = ../config/ssh/agent.plist;
  home.file.".ssh/config".text =
    ''
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
}
