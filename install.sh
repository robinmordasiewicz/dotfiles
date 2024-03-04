#!/usr/bin/env bash

set -e

cp .vimrc ~/
cp .p10k.zsh ~/
mkdir -p ~/.vim/autoload
mkdir -p ~/.vim/bundle

git clone https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/themes/powerlevel10k

wget 'https://tpo.pe/pathogen.vim' -O ~/.vim/autoload/pathogen.vim
git clone https://github.com/vim-airline/vim-airline ~/.vim/bundle/vim-airline
git clone https://github.com/preservim/nerdtree ~/.vim/bundle/nerdtree
git clone https://github.com/junegunn/fzf.vim ~/.vim/bundle/fzf.vim
git clone https://github.com/airblade/vim-gitgutter ~/.vim/bundle/vim-gitgutter
git clone https://github.com/tpope/vim-fugitive ~/.vim/bundle/vim-fugitive
git clone https://github.com/voldikss/vim-floaterm ~/.vim/bundle/vim-floaterm

mkdir -p ~/.vim/colors
wget https://raw.githubusercontent.com/crusoexia/vim-monokai/master/colors/monokai.vim -O ~/.vim/colors/monokai.vim

