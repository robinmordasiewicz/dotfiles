#!/usr/bin/env bash
#
# This is a dotfiles installer file

set -e

DOTFILEDIR=`pwd`

cp .vimrc ~/
cp .opencommit ~/
#cp .zshrc ~/
#cp .p10k.zsh ~/
cp .act ~/
cp powerlevel10k.omp.json ~/.oh-my-posh/themes/powerlevel10k.omp.json

if ! [ -d ~/.vim/pack/plugin/start ]; then
  mkdir -p ~/.vim/pack/plugin/start
fi

if ! [ -d ~/.vim/pack/plugin/start/vim-airline ]; then
  git clone https://github.com/vim-airline/vim-airline ~/.vim/pack/plugin/start/vim-airline
else
  cd ~/.vim/pack/plugin/start/vim-airline
  git pull
fi

if ! [ -d ~/.vim/pack/plugin/start/nerdtree ]; then
  git clone https://github.com/preservim/nerdtree.git ~/.vim/pack/plugin/start/nerdtree
else
  cd ~/.vim/pack/plugin/start/nerdtree
  git pull
fi

if ! [ -d ~/.vim/pack/plugin/start/fzf ]; then
  git clone https://github.com/junegunn/fzf.vim.git ~/.vim/pack/plugin/start/fzf
else
  cd ~/.vim/pack/plugin/start/fzf
  git pull
fi

if ! [ -d ~/.vim/pack/plugin/start/vim-gitgutter ]; then
  git clone https://github.com/airblade/vim-gitgutter.git ~/.vim/pack/plugin/start/vim-gitgutter
else
  cd ~/.vim/pack/plugin/start/vim-gitgutter
  git pull
fi

if ! [ -d ~/.vim/pack/plugin/start/vim-fugitive ]; then
  git clone https://github.com/tpope/vim-fugitive.git ~/.vim/pack/plugin/start/vim-fugitive
else
  cd ~/.vim/pack/plugin/start/vim-fugitive
  git pull
fi

if ! [ -d ~/.vim/pack/plugin/start/vim-polyglot ]; then
  git clone --depth 1 https://github.com/sheerun/vim-polyglot ~/.vim/pack/plugin/start/vim-polyglot
else
  cd ~/.vim/pack/plugin/start/vim-polyglot
  git pull
fi

if ! [ -d ~/.vim/pack/plugin/start/vim-terraform ]; then
  git clone https://github.com/hashivim/vim-terraform.git ~/.vim/pack/plugin/start/vim-terraform
else
  cd ~/.vim/pack/plugin/start/vim-terraform
  git pull
fi

if ! [ -d ~/.vim/colors ]; then
  mkdir -p ~/.vim/colors
fi

if ! [ -d ~/.vim/pack/themes/start ]; then
  mkdir -p ~/.vim/pack/themes/start
fi

if ! [ -d ~/.vim/pack/themes/start/vim-code-dark ]; then
  git clone https://github.com/tomasiser/vim-code-dark ~/.vim/pack/themes/start/vim-code-dark
else
  cd ~/.vim/pack/themes/start/vim-code-dark || return
  git pull
fi


#if ! [ -d ~/.oh-my-zsh/custom/themes ]; then
#  mkdir ~/.oh-my-zsh/custom/themes
#fi

#if ! [ -d ~/.oh-my-zsh/custom/themes/powerlevel10k ]; then
#  git clone https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k
#else
#  cd ~/.oh-my-zsh/custom/themes/powerlevel10k
#  git pull
#fi

if ! [ -d ~/.oh-my-zsh/custom/plugins ]; then
  mkdir ~/.oh-my-zsh/custom/plugins
fi

if ! [ -d ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions ]; then
  git clone https://github.com/zsh-users/zsh-autosuggestions.git ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
else
  cd ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
  git pull
fi

if ! [ -d ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting ]; then
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
else
  cd ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
  git pull
fi

if ! [ -d ~/.oh-my-zsh/custom/plugins/conda-zsh-completion ]; then
  git clone https://github.com/conda-incubator/conda-zsh-completion.git ~/.oh-my-zsh/custom/plugins/conda-zsh-completion
else
  cd ~/.oh-my-zsh/custom/plugins/conda-zsh-completion
  git pull
fi

if ! [ -d ~/.oh-my-zsh/custom/plugins/zsh-tfenv ]; then
  git clone https://github.com/cda0/zsh-tfenv.git ~/.oh-my-zsh/custom/plugins/zsh-tfenv
else
  cd ~/.oh-my-zsh/custom/plugins/zsh-tfenv
  git pull
fi

if ! [ -d ~/.oh-my-zsh/custom/plugins/zsh-aliases-lsd ]; then
  git clone https://github.com/yuhonas/zsh-aliases-lsd.git ~/.oh-my-zsh/custom/plugins/zsh-aliases-lsd
else
  cd ~/.oh-my-zsh/custom/plugins/zsh-aliases-lsd
  git pull
fi

cd ${DOTFILEDIR}

sed -i 's/^plugins=.*$/plugins=(git zsh-syntax-highlighting zsh-autosuggestions ubuntu jsontools gh common-aliases conda-zsh-completion zsh-aliases-lsd zsh-tfenv)/' ~/.zshrc

if command -v conda &> /dev/null
then
    conda init --all
fi

curl -s https://ohmyposh.dev/install.sh | sudo bash -s
oh-my-posh font install Meslo
if ! [ -d ~/.oh-my-posh/themes/ ]; then
  mkdir -p ~/.oh-my-posh/themes
fi

if ! grep -q '^eval "$(oh-my-posh init' ~/.zshrc; then
    echo 'eval "$(oh-my-posh init zsh --config ~/.oh-my-posh/themes/powerlevel10k.omp.json)"' >> ~/.zshrc
fi

wget https://raw.githubusercontent.com/Azure/azure-cli/dev/az.completion -O ~/.oh-my-zsh/custom/az.zsh

if command -v az &> /dev/null; then
    yes y | az config set auto-upgrade.enable=yes
    yes y | az config set auto-upgrade.prompt=no
fi

