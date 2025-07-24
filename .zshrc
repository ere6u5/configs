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
HISTSIZE=100000
SAVEHIST=100000
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
PROMPT='%F{147}%n@%m:%f%~%f$ '

# Window title
case "$TERM" in
    xterm*|rxvt*|alacritty*|kitty*)
        precmd() { print -Pn "\e]0;%n@%m: %~\a" }
        ;;
esac

# Load additional aliases
[[ -f ~/.bash_aliases ]] && source ~/.bash_aliases

# Auto-start tmux (only in interactive shells, no nested tmux)
if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
  exec tmux new-session -A -s main  # Attach to 'main' or create it
fi
