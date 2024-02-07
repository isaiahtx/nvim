# My .nvim

My neovim config folder, using [LazyVim](https://github.com/LazyVim/LazyVim).
Built off of the
[LazyVim starter template](https://github.com/LazyVim/starter).

## Installation

1. Install [neovim](https://neovim.io/). If you're on Arch, that's as simple as running

        pacman -S neovim

and you're good to go. If you're on a Debian based distro, the default version
of neovim that comes with is outdated, in which case you can install the
nightly version from [the unstable branch of the neovim
ppa](https://launchpad.net/~neovim-ppa/+archive/ubuntu/unstable) (note: the
stable version is still too outdated for LazyVim, at the time of writing this).

3. Clone this repo to ~/.config/nvim

        git clone https://github.com/isaiahtx/nvim.git ~/.config/nvim

4. Run neovim (`nvim`)

## Features

Lots of snippets (mostly aimed towards writing in LaTeX), all the goodnessj
contained in the starter template.

## Tips

Best used with my [zsh setup](https://github.com/isaiahtx/zdotdir). This setup
has only been tested on Linux ([ArchWSL](https://github.com/yuk7/ArchWSL) on my
Windows desktop and a native Arch install on my laptop, I use both about
equally). In particular, you will need to change the PDF viewer (I use
[Zathura](https://github.com/pwmt/zathura)) if you're on Windows or macOS.
