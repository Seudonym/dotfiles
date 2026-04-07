autoload -Uz compinit
compinit
export PATH=$HOME/.cargo/bin:$PATH

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
  export MANPAGER="vim -M +MANPAGER -"
else
  export EDITOR='nvim'
  export MANPAGER="nvim +Man!"
fi

alias ls="exa"
alias cd="z"
alias ssh="kitty +kitten ssh"


eval "$(zoxide init zsh)"
eval "$(starship init zsh)"
# eval "$(fnm env --use-on-cd --shell zsh)"
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
