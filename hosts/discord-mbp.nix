{
  programs = {
    git.userEmail = "peter.cho@discordapp.com";

    zsh = {
      initExtra = ''
        [ -f "$HOME/.nix-profile/etc/profile.d/nix.sh" ] && source "$HOME/.nix-profile/etc/profile.d/nix.sh"

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
