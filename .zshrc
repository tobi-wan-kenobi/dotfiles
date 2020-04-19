bindkey "^[Od" backward-word
bindkey "^[Oc" forward-word
bindkey "^[[1;5D" backward-word
bindkey "^[[1;5C" forward-word
bindkey "\033[1~" beginning-of-line
bindkey "\033[4~" end-of-line

# Path to your oh-my-zsh installation.
ZSH=$HOME/.oh-my-zsh/

ZSH_THEME="shadow-light"

DISABLE_AUTO_UPDATE="true"
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"
ZSH_CUSTOM=$HOME/.oh-my-zsh/

plugins=(
  git
  pass
#  zsh-dircolors-gruvbox
)

# User configuration
zstyle :omz:plugins:ssh-agent agent-forwarding on


if [ -n "$DESKTOP_SESSION" ]; then
	eval $(gnome-keyring-daemon --start)
	export SSH_AUTH_SOCK
fi

ZSH_CACHE_DIR=$HOME/.cache/oh-my-zsh
if [[ ! -d $ZSH_CACHE_DIR ]]; then
  mkdir $ZSH_CACHE_DIR
fi

source $ZSH/oh-my-zsh.sh
[[ -r "/usr/share/z/z.sh" ]] && source /usr/share/z/z.sh
[[ -r "$HOME/.local/z.sh" ]] && source $HOME/.local/z.sh

export EDITOR=nvim

alias vim='nvim'

export PATH=~/bin:$PATH:~/.local/bin:~/node_modules/.bin/

