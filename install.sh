#!/usr/bin/env bash
#
# This is a dotfiles installer file

set -e

cp .vimrc ~/
cp .opencommit ~/
cp .zshrc ~/
cp .p10k.zsh ~/

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

if ! [ -d ~/.vim/pack/plugin/start/vim-floaterm ]; then
  git clone https://github.com/voldikss/vim-floaterm.git ~/.vim/pack/plugin/start/vim-floaterm
else
  cd ~/.vim/pack/plugin/start/vim-floaterm
  git pull
fi

if ! [ -d ~/.vim/colors ]; then
  mkdir -p ~/.vim/colors
fi

wget https://raw.githubusercontent.com/crusoexia/vim-monokai/master/colors/monokai.vim -O ~/.vim/colors/monokai.vim

if ! [ -d ~/.oh-my-zsh/custom/themes ]; then
  mkdir ~/.oh-my-zsh/custom/themes
fi

if ! [ -d ~/.oh-my-zsh/custom/themes ]; then
  mkdir -p ~/.oh-my-zsh/custom/themes
fi

if ! [ -d ~/.oh-my-zsh/custom/themes/powerlevel10k ]; then
  git clone https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k
else
  cd ~/.oh-my-zsh/custom/themes/powerlevel10k
  git pull
fi

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

if ! [ -d ~/.oh-my-zsh/custom/plugins/zsh-eza ]; then
  git clone https://github.com/z-shell/zsh-eza.git ~/.oh-my-zsh/custom/plugins/zsh-eza
else
  cd ~/.oh-my-zsh/custom/plugins/zsh-eza
  git pull
fi

if command -v conda &> /dev/null
then
    conda init --all
fi
