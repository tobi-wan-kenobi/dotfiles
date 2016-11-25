if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

export PATH=$PATH:~/bin/
export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel -Dswing.crossplatformlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel'
export SVN_EDITOR='vim'

alias ls='ls --color=auto'
alias ll='ls -la --color=auto'

YELLOW="\033[0;32m"
CYAN="\033[0;36m"
CYAN_BOLD="\033[1;36m"
ORANGE="\033[0;33m"
BLUE="\033[0;34m"
MAGENTA="\033[0;35m"
VIOLET_BOLD="\033[1;35m"
WHITE="\033[0;37m"
WHITE_BOLD="\033[1;37m"
GREY_BOLD="\033[1;36m"
CYAN_UL="\033[4;36m"
CYAN_BG="\033[7;36m"
NC="\033[0m"
export PS1="${YELLOW}\u${NC}@${GREY_BOLD}\h${NC}:${BLUE}\W${NC}${WHITE_BOLD} \$${NC} "
