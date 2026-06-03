if status is-interactive
# Commands to run in interactive sessions can go here
end

set fish_greeting
set -gx EDITOR nvim
set -gx MANPAGER 'nvim +Man!'


starship init fish | source
zoxide init fish | source

alias cd=z
alias gst="git status"
alias gcommit="git commit"
alias ga="git add"
alias glog="git log --oneline"
alias gd="git diff" 
alias grhh="git reset --hard" 
alias gp="git push" 

