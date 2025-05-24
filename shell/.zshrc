HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt append_history
setopt share_history
setopt hist_ignore_space
setopt inc_append_history

bindkey '\e[3~' delete-char
bindkey '^R' history-incremental-search-backward # ctrl + r
bindkey -M viins '^[[3;5~' kill-word
bindkey '^H' vi-backward-kill-word # ctr + backspace
bindkey '^[[1;5C' forward-word # ctrl  + right
bindkey '^[[1;5D' backward-word # ctrl  + left
bindkey '^[[H' beginning-of-line # home
bindkey '^[[F' end-of-line # end

alias ls="ls --color=auto"

autoload -Uz compinit && compinit

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fastfetch -c examples/9.jsonc

eval "$(starship init zsh)"

export EDITOR="nvim"
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

eval "$(zoxide init zsh)"
