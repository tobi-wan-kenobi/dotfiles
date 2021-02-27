# tobi-wan-kenobi's dotfiles

This collection of dotfiles documents my ongoing efforts to create development environment (C, C++, Python, mostly) with the following attributes:

- support my workflow (terminal, vim, tmux)
- is minimalistic in the sense that sane defaults exist
- is easily portable across various linux distributions
- is not a big hassle to set up

I miserably failed on the last point, since having 24bit color support for alacritty + tmux + vim seems to be surprisingly difficult, given the year we are living in.

Anyhow, apart from that, here's my setup:

- setup is done using dotbot
- i3-gaps with very basic keybindings as window manager
- host-specific extensions of i3 (by just "cat"ing files together)
- alacritty as terminal (sane defaults, nice configuration, flawlessly works with links)
- neovim with a very, very basic configuration
- tmux, again, very basic settings
- rofi as combined launcher and window selector
- everything with gruvbox light as theme (research seems to indicate that light background is easier on the eye, and I find gruvbox extremely appealing. Plus, it plays really nice with redshift, just gets progressively more red as time progresses)

Hope you like it, and I always welcome suggestions for improvements as either tickets or PRs!
