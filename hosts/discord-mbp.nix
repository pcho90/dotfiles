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
    ".ssh/config".source = ../config/ssh/config;
  };
}
