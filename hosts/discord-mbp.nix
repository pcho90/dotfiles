{
  programs = {
    git.userEmail = "peter.cho@discordapp.com";

    zsh = {
      initExtra = ''
        [ -f "$HOME/.nix-profile/etc/profile.d/nix.sh" ] && source "$HOME/.nix-profile/etc/profile.d/nix.sh"

        ITERM_SETTINGS=$HOME/.config/iterm2/com.googlecode.iterm2.plist
        if [[ ! -L $ITERM_SETTINGS ]]; then
          [[ -f $ITERM_SETTINGS ]] && rm $ITERM_SETTINGS
          ln -s $HOME/dotfiles/config/iterm2/com.googlecode.iterm2.plist $ITERM_SETTINGS
        fi

        export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
        gpg-connect-agent /bye
      '';
    };
  };

  home.file = {
    ".gnupg/gpg-agent.conf".source = ../config/gpg-agent.conf;

    ".ssh/config".text = ''
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
        UpdateHostKeys no

      Host gh
        HostName github.com
        User git
    '';
  };
}
