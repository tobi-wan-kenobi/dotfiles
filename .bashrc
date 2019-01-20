if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

export PATH=$PATH:~/bin/:~/.cargo/bin/
export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel -Dswing.crossplatformlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel'
export SVN_EDITOR='vim'

alias ls='ls --color=auto'
alias ll='ls -la --color=auto'

source <(gopass completion bash)

YELLOW="\[\e[0;32m\]"
CYAN="\[\e[0;36m\]"
CYAN_BOLD="\[\e[1;36m\]"
ORANGE="\[\e[0;33m\]"
BLUE="\[\e[0;34m\]"
MAGENTA="\[\e[0;35m\]"
VIOLET_BOLD="\[\e[1;35m\]"
WHITE="\[\e[0;37m\]"
WHITE_BOLD="\[\e[1;37m\]"
GREY_BOLD="\[\e[1;36m\]"
CYAN_UL="\[\e[4;36m\]"
CYAN_BG="\[\e[7;36m\]"
NC="\[\e[0m\]"
export PS1="${YELLOW}\u${NC}@${ORANGE}\h${NC}:${BLUE}\W${NC}${BLUE} \$${NC} "
source ~/.fzf.bash
