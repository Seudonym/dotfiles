HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt append_history
setopt share_history
setopt hist_ignore_space
setopt hist_ignore_dups
setopt inc_append_history

bindkey '\e[3~' delete-char
bindkey '^R' history-incremental-search-backward # ctrl + r
bindkey -M viins '^[[3;5~' kill-word
bindkey '^H' vi-backward-kill-word # ctr + backspace
bindkey '^[[1;5C' forward-word # ctrl  + right
bindkey '^[[1;5D' backward-word # ctrl  + left
bindkey '^[[H' beginning-of-line # home
bindkey '^[[F' end-of-line # end
#
alias ls="ls --color=auto"
alias cd=z
alias tmux="tmux -u"

autoload -Uz compinit && compinit

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
. "$HOME/.local/bin/env"
export EDITOR="nvim"

# fnm
FNM_PATH="/home/wahid/.local/share/fnm"
if [ -d "$FNM_PATH" ]; then
  export PATH="$FNM_PATH:$PATH"
  eval "`fnm env`"
fi
eval "$(fnm env --use-on-cd --shell zsh)"

# nnn
n ()
{
    # Block nesting of nnn in subshells
    [ "${NNNLVL:-0}" -eq 0 ] || {
        echo "nnn is already running"
        return
    }

    # The behaviour is set to cd on quit (nnn checks if NNN_TMPFILE is set)
    # If NNN_TMPFILE is set to a custom path, it must be exported for nnn to
    # see. To cd on quit only on ^G, remove the "export" and make sure not to
    # use a custom path, i.e. set NNN_TMPFILE *exactly* as follows:
    #      NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"
    export NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"

    # Unmask ^Q (, ^V etc.) (if required, see `stty -a`) to Quit nnn
    # stty start undef
    # stty stop undef
    # stty lwrap undef
    # stty lnext undef

    # The command builtin allows one to alias nnn to n, if desired, without
    # making an infinitely recursive alias
    command nnn "$@"

    [ ! -f "$NNN_TMPFILE" ] || {
        . "$NNN_TMPFILE"
        rm -f -- "$NNN_TMPFILE" > /dev/null
    }
}
export NNN_FIFO='/tmp/nnn.fifo'
export NNN_PLUG='p:preview-tui'

export PATH=/opt/cuda/bin:$PATH
export PATH=/home/wahid/dev/v/:$PATH
export PATH="$PATH:/home/wahid/ngc-cli"
export LD_LIBRARY_PATH=/opt/cuda/lib64:$LD_LIBRARY_PATH
