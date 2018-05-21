#!/bin/sh


initvim="$HOME/.config/nvim/init.vim"
plug="$HOME/.local/share/nvim/plugged" 
ohmyzsh="$HOME/.oh-my-zsh"



: '-----------------------homebrew-----------------------'
if [ ! -x "$(command -v brew)" ]; then
	echo 'Installing homebrew..'
	/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
	echo "Homebrew already exists."
fi

: '------------------------------------------------------'



: '-----------------------molokai------------------------'

if [ ! -d ~/.vim ]; then
	mkdir ~/.vim
fi

if [ ! -d ~/.vim/colors ]; then
	echo "Installing molokai.."
	git clone https://github.com/tomasr/molokai.git
	cp molokai/colors/ ~/.vim/colors
	rm -r molokai/
else
	echo "molokai already exists."
fi

: '------------------------------------------------------'



: '-------------------------zsh--------------------------'

# install zsh
if [ ! -x "$(command -v zsh)" ]; then
	echo 'Installing zsh..'

	brew install zsh     # zsh 다운로드
	chsh -s `which zsh`  # 현재 쉘을 zsh 쉘로 바꿈
else
	echo "zsh already exists."
fi

# Download oh my zsh
if [ ! -d "$ohmyzsh" ]; then
	echo "Installing ohmyzsh.."
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
else
	echo "ohmyzsh already exists."
fi

# syntax highlighter
cd ~/.oh-my-zsh/custom/plugins
if [ ! -d ./zsh-syntax-highlighting ]; then
	echo "Installing zsh-syntax highlighter"
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git
	echo "source ${(q-)PWD}/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ${ZDOTDIR:-$HOME}/.zshrc                   # syntax highlighter 설치 후 설정
else
	echo "syntax highlighter already exists."
fi

# auto-suggestion
if ! brew list -1 | grep -q "zsh-autosuggestions" ; then
	echo "Installing zsh-autosuggestions.."
	brew install zsh-autosuggestions
	echo "source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh" >> ${ZDOTDIR:-$HOME}/.zshrc            # autosuggestions 설치 후 설정
else
	echo "zsh-autosuggestions already exists."
fi

: '------------------------------------------------------'



: '-----------------------neovim-------------------------'

# install nvim
if ! brew list -1 | grep -q "neovim" ; then
	echo "Installing neovim.."
	brew install neovim

	if [ ! -x "$(command -v pip2)" ]; then
		pip2 --no-cache-dir install neovim
	fi
	if [ ! -x "$(command -v pip3)" ]; then
		pip3 --no-cache-dir install neovim
	fi

	NVIM_PATH=$(which nvim)
	echo "alias vi='$NVIM_PATH'" >> ~/.config/nvim/init.vim
else
	echo "neovim already exists."
fi

: '------------------------------------------------------'



: '-------------------------plug-------------------------'

if [ ! -d "$plug" ]; then
	# install plug: nvim package manager
	echo "Installing plug.."
	curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
		https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim \
		&& nvim -c :PlugInstall -c qa
else
	echo "plug already exists."
fi

: '------------------------------------------------------'



: '-----------------------init.vim-----------------------'

# copy init.vim
if [ ! -f "$initvim" ]; then
	echo "Copying init.vim.."
	cp init.vim ~/.config/nvim/init.vim
else
	echo "init.vim already exists."
fi

: '------------------------------------------------------'



