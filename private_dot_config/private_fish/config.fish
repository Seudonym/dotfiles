if status is-interactive
# Commands to run in interactive sessions can go here
end

set fish_greeting
set -gx EDITOR nvim
set -gx MANPAGER 'nvim +Man!'


starship init fish | source
zoxide init fish | source

alias cd=z
