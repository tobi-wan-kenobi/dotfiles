if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

export PATH=$PATH:~/bin/
export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel -Dswing.crossplatformlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel'
export SVN_EDITOR='vim'

alias ls='ls --color=auto'
alias ll='ls -la --color=auto'

# switch to zsh, if available
zsh=$(which zsh 2> /dev/null)
if [ -x "$zsh" ]; then
	env zsh
fi

if [ -f `which powerline-daemon` ]; then
	powerline-daemon -q
	POWERLINE_BASH_CONTINUATION=1
	POWERLINE_BASH_SELECT=1
	. /usr/share/powerline/bash/powerline.sh
fi
