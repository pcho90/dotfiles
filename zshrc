# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export EDITOR=nvim
export VISUAL=nvim
export ZSH="/Users/peter.cho/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"
export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --no-ignore-vcs'
export FZF_CTRL_T_COMMAND='rg --files --hidden --no-messages'
export ZSH_AUTOSUGGESTION_STRATEGY=(history completion)
export FZF_DEFAULT_COMMAND='rg --files --no-ignore-vcs --hidden'
export ITERM_ENABLE_SHELL_INTEGRATION_WITH_TMUX=YES
export NVM_DIR="$HOME/.nvm"

[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && . "/opt/homebrew/opt/nvm/nvm.sh"
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && . "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"
[ -f "~/.fzf.zsh" ] && source "~/.fzf.zsh"
[ -f "/Users/peter.cho/.nix-profile/etc/profile.d/nix.sh" ] && source "/Users/peter.cho/.nix-profile/etc/profile.d/nix.sh"

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
source ~/powerlevel10k/powerlevel10k.zsh-theme

alias rustdoc="rustup doc --toolchain=stable-x86_64-apple-darwin"

#compdef clyde
_clyde() {
  eval $(env COMMANDLINE="${words[1,$CURRENT]}" _CLYDE_COMPLETE=complete-zsh  clyde)
}
if [[ "$(basename -- ${(%):-%x})" != "_clyde" ]]; then
  compdef _clyde clyde
fi
