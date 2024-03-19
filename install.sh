#!/usr/bin/env bash
#
# This is a dotfiles installer file

set -e

DOTFILEDIR=`pwd`

cp .vimrc ~/
cp .opencommit ~/
cp .act ~/

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

if ! [ -d ~/.vim/pack/themes/start ]; then
  mkdir -p ~/.vim/pack/themes/start
fi

if ! [ -d ~/.vim/pack/themes/start/vim-code-dark ]; then
  git clone https://github.com/tomasiser/vim-code-dark ~/.vim/pack/themes/start/vim-code-dark
else
  cd ~/.vim/pack/themes/start/vim-code-dark || return
  git pull
fi

if ! [ -d ~/.oh-my-zsh ]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

if ! [ -d ~/.zshrc ]; then
  cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc
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

wget https://raw.githubusercontent.com/Azure/azure-cli/dev/az.completion -O ~/.oh-my-zsh/custom/az.zsh

cd ${DOTFILEDIR}

tmpfile=$(mktemp)
sed 's/^plugins=.*$/plugins=(git zsh-syntax-highlighting zsh-autosuggestions ubuntu jsontools gh common-aliases conda-zsh-completion zsh-aliases-lsd zsh-tfenv)/' ~/.zshrc > "$tmpfile"
if [ $? -eq 0 ]; then
    # Replace the original file with the modified contents
    mv "$tmpfile" ~/.zshrc
else
    rm "$tmpfile"
fi

if command -v conda &> /dev/null
then
    conda init --all
fi

if ! [ -d ~/.local/bin/ ]; then
  mkdir -p ~/.local/bin/
fi
if ! [ -d ~/.oh-my-posh/themes/ ]; then
  mkdir -p ~/.oh-my-posh/themes
fi
curl -s https://ohmyposh.dev/install.sh | bash -s -- -d ~/.local/bin -t ~/.oh-my-posh/themes
oh-my-posh font install Meslo
cp powerlevel10k.omp.json ~/.oh-my-posh/themes/powerlevel10k.omp.json

if ! grep -q '^eval "$(oh-my-posh init' ~/.zshrc; then
  echo 'eval "$(oh-my-posh init zsh --config ~/.oh-my-posh/themes/powerlevel10k.omp.json)"' >> ~/.zshrc
fi

if command -v az &> /dev/null; then
  yes y | az config set auto-upgrade.enable=yes
  yes y | az config set auto-upgrade.prompt=no
fi

