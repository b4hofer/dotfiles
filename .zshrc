# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=5000
SAVEHIST=5000
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/bvor/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

PROMPT='%(?..%B%F{red}%? )%B%F{240}%2~%f%b %F{109}%#%f '

autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
RPROMPT=\$vcs_info_msg_0_
zstyle ':vcs_info:git:*' formats '%F{240}%b%f'
zstyle ':vcs_info:*' enable git

alias vim='nvim'
alias ls='ls --color'
alias grep='grep --color'
alias config='/usr/bin/git --git-dir=$HOME/.cfg --work-tree=$HOME'
alias sway='sway --unsupported-gpu'

export EDITOR='vim'

#eval "$(starship init zsh)"
