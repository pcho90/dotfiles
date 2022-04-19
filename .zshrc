# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="/Users/pcho/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(
    git
    z
    vi-mode
    zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh


export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && . "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && . "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion


# FZF

export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --no-ignore-vcs'
export FZF_CTRL_T_COMMAND='rg --files --hidden --no-messages'
export ZSH_AUTOSUGGESTION_STRATEGY=(history completion)

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh


export PATH="/Users/pcho/go/bin/:/opt/homebrew/opt/llvm/bin:$PATH"


# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/pcho/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/pcho/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/pcho/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/pcho/google-cloud-sdk/completion.zsh.inc'; fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# for rustup doc on apple sillicon before it becomes tier1 platform
alias rustdoc="rustup doc --toolchain=stable-x86_64-apple-darwin"

alias dotfiles='git --git-dir=/Users/pcho/dotfiles.git --work-tree=$HOME'
