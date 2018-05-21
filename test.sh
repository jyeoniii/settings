#!/bin/sh

initvim="$HOME/.config/nvim/init.vim"
plug="$HOME/.local/share/nvim/plugged" 
ohmyzsh="$HOME/.oh-my-zsh"


: '-----------------------homebrew-----------------------'
if [ ! -x "$(command -v brew)" ]; then
	echo 'Homebrew does not exist'
else
	echo 'Homebrew exists'
fi

: '------------------------------------------------------'


: '-------------------------zsh--------------------------'

# install zsh
if [ ! -x "$(command -v zsh)" ]; then
	echo 'zsh does not exist'
else
	echo 'zsh exists'
fi

# Download oh my zsh
if [ ! -d "$ohmyzsh" ]; then
	echo "ohmyzsh does not exits"
else
	echo "ohmyzsh exists"
fi


# syntax highlighter
cd ~/.oh-my-zsh/custom/plugins
if [ ! -d ./zsh-syntax-highlighting ]; then
	echo 'syntax highlighter does not existsCloning zsh-syntax highlighter'
else
	echo 'syntax highlighter exists'
fi

# auto-suggestion
if ! brew list -1 | grep -q "zsh-autosuggestions" ; then
	echo 'autosuggestions does not exist'
else
	echo 'autosuggestions exists'

fi

: '------------------------------------------------------'


: '-----------------------neovim-------------------------'

# install nvim
if ! brew list -1 | grep -q "neovim" ; then
	echo 'neovim does not exist'
else
	echo 'neovim exists'
fi

if [ ! -d "$plug" ]; then
	echo 'plug does not exist'
else
	echo 'plug exists'
fi

: '------------------------------------------------------'




# copy init.vim
initvim="$HOME/.config/nvim/init.vim"
if [ ! -f "$initvim" ]; then
	echo "init.vim does not exits"
else
	echo "init.vim exists"
fi


