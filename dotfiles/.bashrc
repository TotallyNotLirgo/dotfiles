case $- in
    *i*) ;;
      *) return;;
esac

HISTCONTROL=ignoreboth
HISTSIZE=1000
HISTFILESIZE=2000

shopt -s histappend
shopt -s checkwinsize
shopt -s dotglob
shopt -s globstar
shopt -s autocd

case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

PATH="$PATH:~/.local/bin:/usr/local/go/bin"
export EDITOR='nvim'

bind '"\e[A":history-search-backward'
bind '"\e[B":history-search-forward'

function cds() {
    if [[ $# -eq 1 ]]; then
        cd "$1"
    fi
    if [[ -d ./shell ]]; then
        cd ./shell
        nix develop
        cd ..
    elif [[ -f ./flake.nix ]]; then
        nix develop
    fi
}

alias ":q"="exit"
alias ":q!"="exit"
alias ":wq"="exit"
alias ":qa"="exit"
alias ":qa!"="exit"
alias ":wqa"="exit"

alias nixos-reload="home-manager switch; sudo nixos-rebuild switch"

eval "$(starship init bash)"
