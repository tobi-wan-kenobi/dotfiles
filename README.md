# tobi-wan-kenobi's  dotfiles

This collection of dotfiles documents my ongoing efforts to create a development environment (C, C++, Python, mostly) that:

- supports my workflow (terminal, vim, tmux)
- is minimalistic in the sense that sane defaults exist
- is easily portable across various linux distributions
- is not a big hassle to set up

Here's the current state of things:

- setup: [dotbot](https://github.com/anishathalye/dotbot) (basically, just `git clone` followed by `./install`)
- window manager: [i3-gaps](https://github.com/Airblader/i3)
- terminal emulator: [alacritty](https://github.com/alacritty/alacritty)
- compositor: [picom](https://github.com/yshui/picom)
- editor: [neovim](https://neovim.io/) with a couple of plugins, most notably [CoC](https://github.com/neoclide/coc.nvim)
- terminal multiplexer: [tmux](https://github.com/tmux/tmux)
- theme: [gruvbox-light](https://github.com/morhetz/gruvbox)
- other tools:
  - file explorer: [ranger](https://github.com/ranger/ranger) (with [dev-icons](https://github.com/alexanderjeurissen/ranger_devicons))
  - ls replacement: [lsd](https://github.com/Peltoche/lsd)
  - grep replacement: [ripgrep](https://github.com/BurntSushi/ripgrep)
  - find replacement: [fd](https://github.com/sharkdp/fd)
  - cat replacement: [bat](https://github.com/sharkdp/bat)
  - [fzf](https://github.com/junegunn/fzf)

gtk themes belong in `~/.themes/`, icons in `~/.icons/` (or `/usr/share\{themes,icons}`, if you want to use them for lightdm as well).

Hope you like it, and I always welcome suggestions for improvements as either tickets or PRs!
