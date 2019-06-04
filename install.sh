#!/bin/sh

INITVIM_PATH="$HOME/.config/nvim"
INITVIM="$HOME/.config/nvim/init.vim"
PLUG="$HOME/.local/share/nvim/plugged" 
OHMYZSH="$HOME/.oh-my-zsh"
SCRIPT_PATH=$( cd "$(dirname "$0")" ; pwd )


: '-----------------------homebrew-----------------------'
if [ ! -x "$(command -v brew)" ]; then
	echo 'Installing homebrew..'
	/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
	echo "Homebrew already exists."
fi

: '------------------------------------------------------'


: '-------------------------zsh--------------------------'

# install zsh
if [ ! -x "$(command -v zsh)" ]; then
	echo 'Installing zsh..'

	brew install zsh     # zsh 다운로드
else
	echo "zsh already exists."
fi

# Download oh my zsh
if [ ! -d "$OHMYZSH" ]; then
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


: '-----------------------init.vim-----------------------'

if [ ! -d "$INITVIM_PATH" ]; then
	echo "Creating INITVIM_PATH"
	mkdir -p "$INITVIM_PATH"
fi

# copy init.vim
if [ ! -f "$INITVIM" ]; then
	echo "Copying init.vim.."
	cd "${SCRIPT_PATH}"
	cp init.vim "${INITVIM}"
else
	echo "init.vim already exists."
fi

: '------------------------------------------------------'


: '-----------------------neovim-------------------------'

# install nvim
if ! brew list -1 | grep -q "neovim" ; then
	echo "Installing neovim.."
	brew update
	brew upgrade neovim
	brew install --HEAD neovim

	NVIM_PATH="$(which nvim)"
	echo "alias vi='${NVIM_PATH}'" >> ~/.zshrc
else
	echo "neovim already exists."
fi

echo "Setting up neovim.."
if [ ! -x "$(command -v pip2)" ]; then
	echo "Installing python2 using homewbrew.."
	brew install python2
fi
if [ ! -x "$(command -v pip3)" ]; then
	echo "Installing python3 using homewbrew.."
	brew install python3
fi

sudo pip2 install --upgrade neovim
sudo pip3 install --upgrade neovim

: '------------------------------------------------------'
	

: '-------------------------plug-------------------------'

if [ ! -d "$PLUG" ]; then
	# install plug: nvim package manager
	echo "Installing plug.."
	mkdir -p "${PLUG}"
	curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
		https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim \
		&& nvim -c :PlugInstall -c qa
else
	echo "plug already exists."
fi

: '------------------------------------------------------'

chsh -s `which zsh`  # 현재 쉘을 zsh 쉘로 바꿈
source ~/.zshrc


echo "Finished!"


