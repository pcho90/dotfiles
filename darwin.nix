{
  programs.zsh.initExtra = ''
    VSCODE_SETTINGS=$HOME/Library/Application\ Support/Code/User/settings.json
    VSCODE_KEYBINDINGS=$HOME/Library/Application\ Support/Code/User/keybindings.json
    ITERM_SETTINGS=$HOME/Library/Preferences/com.googlecode.iterm2.plist
    KARABINER_SETTINGS=$HOME/.config/karabiner

    if [[ ! -L $VSCODE_SETTINGS ]]; then
      [[ -f $VSCODE_SETTINGS ]] && rm $VSCODE_SETTINGS
      ln -s $HOME/dotfiles/config/vscode/settings.json $VSCODE_SETTINGS
    fi

    if [[ ! -L $VSCODE_KEYBINDINGS ]]; then
      [[ -f $VSCODE_KEYBINDINGS ]] && rm $VSCODE_KEYBINDINGS
      ln -s $HOME/dotfiles/config/vscode/keybindings.json $VSCODE_KEYBINDINGS
    fi

    if [[ ! -L $ITERM_SETTINGS ]]; then
      [[ -f $ITERM_SETTINGS ]] && rm $ITERM_SETTINGS
      ln -s $HOME/dotfiles/config/iterm2/com.googlecode.iterm2.plist $ITERM_SETTINGS
    fi

    if [[ ! -L $KARABINER_SETTINGS ]]; then
      [[ -d $KARABINER_SETTINGS ]] && rm -r $KARABINER_SETTINGS
      ln -s $HOME/dotfiles/config/karabiner $KARABINER_SETTINGS
    fi
  '';
}
