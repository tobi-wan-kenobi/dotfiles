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
ORANGE="\033[0;33m"
BLUE="\033[0;34m"
MAGENTA="\033[0;35m"
WHITE="\033[0;37m"
NC="\033[0m"
export PS1="${YELLOW}\u${NC}@${CYAN}\h${NC}:${BLUE}\W${NC}${WHITE} \$${NC} "
