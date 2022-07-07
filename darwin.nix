{
  programs.zsh.initExtra = ''
    VSCODE_SETTINGS=$HOME/Library/Application\ Support/Code/User/settings.json
    VSCODE_KEYBINDINGS=$HOME/Library/Application\ Support/Code/User/keybindings.json
    KARABINER_SETTINGS=$HOME/.config/karabiner
    YABAI_CONFIG=$HOME/.config/yabai

    if [[ ! -L $VSCODE_SETTINGS ]]; then
      [[ -f $VSCODE_SETTINGS ]] && rm $VSCODE_SETTINGS
      ln -s $HOME/dotfiles/config/vscode/settings.json $VSCODE_SETTINGS
    fi

    if [[ ! -L $VSCODE_KEYBINDINGS ]]; then
      [[ -f $VSCODE_KEYBINDINGS ]] && rm $VSCODE_KEYBINDINGS
      ln -s $HOME/dotfiles/config/vscode/keybindings.json $VSCODE_KEYBINDINGS
    fi

    if [[ ! -L $KARABINER_SETTINGS ]]; then
      [[ -d $KARABINER_SETTINGS ]] && rm -r $KARABINER_SETTINGS
      ln -s $HOME/dotfiles/config/karabiner $KARABINER_SETTINGS
    fi

    if [[ ! -L $YABAI_CONFIG ]]; then
      [[ -d $YABAI_CONFIG ]] && rm -r $YABAI_CONFIG
      ln -s $HOME/dotfiles/config/yabai $YABAI_CONFIG
    fi
  '';
}
