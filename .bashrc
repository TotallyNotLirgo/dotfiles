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

PATH="$PATH:$HOME/.local/bin:/usr/local/go/bin:$XDG_DATA_HOME/go/bin"
export EDITOR='nvim'

bind '"\e[A":history-search-backward'
bind '"\e[B":history-search-forward'

function cdp() {
    if [[ $# -eq 1 ]]; then
        cd "$1"
    fi
    if [[ -d ./.venv ]]; then
        source .venv/bin/activate
    fi
}

alias ":q"="exit"
alias ":q!"="exit"
alias ":wq"="exit"
alias ":qa"="exit"
alias ":qa!"="exit"
alias ":wqa"="exit"

alias nixos-reload="home-manager switch; sudo nixos-rebuild switch"

CARGO_HOME="$HOME/.cargo"
case ":$PATH:" in
  *":$CARGO_HOME/bin:"*) ;;
  *) export PATH="$CARGO_HOME/bin:$PATH" ;;
esac

eval "$(starship init bash)"

# pnpm
export PNPM_HOME="/home/emily/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
export DOCKER_HOST=unix://$XDG_RUNTIME_DIR/docker.sock
