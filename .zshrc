# ~/.zshrc

# Fix terminal size (forces full window)
if [[ "$TERM" != "linux" ]]; then
  printf '\e[8;50;160t' >/dev/tty  # Sets initial size (50 lines, 160 cols)
  clear
fi

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# History configuration
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt hist_ignore_all_dups
setopt append_history
setopt extended_history
setopt inc_append_history
setopt share_history

# Directory navigation
setopt autocd
setopt correct
setopt globdots
setopt extendedglob

# Colors for ls and grep
if [[ -x /usr/bin/dircolors ]]; then
    [[ -r ~/.dircolors ]] && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# Aliases
alias ll='ls -alFh'
alias la='ls -A'
alias l='ls -CF'
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Prompt with lilac username
autoload -U colors && colors
PROMPT='%F{147}ere6u5%f $ '

# Window title
case "$TERM" in
    xterm*|rxvt*|alacritty*|kitty*)
        precmd() { print -Pn "\e]0;%n@%m: %~\a" }
        ;;
esac

# Load additional aliases
[[ -f ~/.bash_aliases ]] && source ~/.bash_aliases

# Exports
export PATH="$HOME/go/bin:$PATH"
export PATH=$PATH:$HOME/.bearer/bin

# Autostart
if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
  tmux new-session -s main
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
