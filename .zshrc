## Zsh history setup
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -e
zstyle :compinstall filename '$HOME/.zshrc'

## Environment variables
export EDITOR='emacs'
export LANG='en_US.UTF-8'
export LC_ALL='en_US.UTF-8'
export MAKE_OPTS="-j4"
export POWERLINE_CONFIG_COMMAND="/usr/local/bin/powerline-config"

## Aliases
alias ll='ls -l'
alias la='ls -ah'

## VCS_INFO
autoload -Uz vcs_info
setopt prompt_subst
zstyle ':vcs_info:*' formats "[%b]"
zstyle ':vcs_info:*' actionformats "[%b %a]"
precmd () {
    psvar=()
    LANG=en_US.UTF-8 vcs_info
    [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
}

## Prompt
export PROMPT="[%n@%m]%# "
export RPROMPT="%1(v|%1v|)[%~]"

## Setup zsh-completions
fpath=(/usr/local/share/zsh-completions $fpath)
autoload -U compinit
compinit -u

## Peco path-find
function peco-path-find() {
    if [[ $LBUFFER =~ \s*cd\s* ]]; then
        local filepath="$(find . -maxdepth 5 -type d -not -path '*/\.*/*' | peco --prompt 'CHANGE DIRECTORY>')"
        BUFFER=$LBUFFER$filepath
    else
        local filepath="$(find . -maxdepth 3 -not -path '*/\.*/*' | peco --prompt 'PATH>')"
        BUFFER=$LBUFFER$filepath
    fi
    CURSOR=$#BUFFER
}
zle -N peco-path-find
bindkey '^h' peco-path-find

## Prevent from PATH overlaps
typeset -U path cdpath fpath manpath


## direnv
eval "$(direnv hook zsh)"

## Setup programming languages
export PATH="$HOME/.cask/bin:$PATH"
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
export NVM_DIR="/Users/kanon_kakuno/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
