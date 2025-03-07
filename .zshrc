setopt correctall
setopt extendedglob
setopt hist_ignore_all_dups
setopt hist_ignore_space

## History
export HISTSIZE=2000
export HISTFILE="$HOME/.history"
export SAVEHIST=$HISTSIZE

## Help command
autoload -Uz run-help
(( ${+aliases[run-help]} )) && unalias run-help
alias help=run-help
autoload -Uz run-help-git run-help-ip run-help-sudo run-help-zoxide run-help-fzf

# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)

eval "$(zoxide init zsh)"

source /usr/share/doc/find-the-command/ftc.zsh askfirst
source /usr/share/zsh/plugins/zsh-sudo/sudo.plugin.zsh
source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
source /usr/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh

## Aliases ##

if [[ -r ~/.aliaszsh ]]; then
    . ~/.aliaszsh
  fi

## Kitty ssh kitten 
[ "$TERM" = "xterm-kitty" ] && alias ssh="kitty +kitten ssh"

## Powerline Shell ##
# https://github.com/b-ryan/powerline-shell

function powerline_precmd() {
    PS1="$(powerline-shell --shell zsh $?)"
}

function install_powerline_precmd() {
  for s in "${precmd_functions[@]}"; do
    if [ "$s" = "powerline_precmd" ]; then
      return
    fi
  done
  precmd_functions+=(powerline_precmd)
}

if [ "$TERM" != "linux" -a -x "$(command -v powerline-shell)" ]; then
    install_powerline_precmd
fi
