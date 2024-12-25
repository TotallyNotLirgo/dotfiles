case $- in
    *i*) ;;
      *) return;;
esac

HISTCONTROL=ignoreboth
HISTSIZE=1000
HISTFILESIZE=2000
shopt -s histappend
shopt -s checkwinsize
shopt -s autocd

[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

RESET_COLOR="$(tput sgr0)"
WHITE_COLOR="$(tput setaf 7)"
BOLD_COLOR="$(tput bold)"
BLUE_COLOR="$(tput setaf 12)"
MAGENTAER_COLOR="$(tput setaf 129)"
MAGENTA_COLOR="$(tput setaf 13)"
PS1='\[${BOLD_COLOR}${MAGENTAER_COLOR}\]\u\[${WHITE_COLOR}\]@\[${MAGENTA_COLOR}\]\h\[${WHITE_COLOR}\]:\[${BLUE_COLOR}\]\w\[${WHITE_COLOR}\]\$ \[${RESET_COLOR}\]'

if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi


PATH="$PATH:~/.local/bin"

bind '"\e[A":history-search-backward'
bind '"\e[B":history-search-forward'

function cdp() {
    builtin cd "$@"

    if [[ -z "$VIRTUAL_ENV" ]]; then
        if [[ -d ./.venv ]]; then
            source ./.venv/bin/activate
        fi
    fi
}

function cds() {
    builtin cd "$@"
    if [[ -f ./shell.nix ]]; then
        nix-shell
    fi
}

alias p='python .'
export EDITOR='nvim'
export PATH=$PATH:/usr/local/go/bin

function json-parse() {
    read JSON
    jq <<< $JSON
}

alias ":q"="exit"
alias ":q!"="exit"
alias ":wq"="exit"
alias ":qa"="exit"
alias ":qa!"="exit"
alias ":wqa"="exit"

alias nixos-reload="home-manager switch; sudo nixos-rebuild switch"

if [ -z "$TMUX" ]; then
  tmux
fi

eval "$(starship init bash)"
