alias ls='ls --color=auto'
powerline-daemon -q
POWERLINE_BASH_CONTINUATION=1
POWERLINE_BASH_SELECT=1
. /usr/share/powerline/bindings/bash/powerline.sh
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
. "$HOME/.cargo/env"

alias slack='flatpak run com.slack.Slack'
