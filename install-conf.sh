#!/bin/sh
git pull
git submodule init
git submodule update

ln -vis `pwd`/vim/ ~/.vim
ln -vis `pwd`/vimrc ~/.vimrc
ln -vis `pwd`/zshrc ~/.zshrc
ln -vis `pwd`/zshenv ~/.zshenv
ln -vis `pwd`/zshcomplete ~/.zshcomplete
ln -vis `pwd`/gitconfig ~/.gitconfig
ln -vis `pwd`/gitignore ~/.gitignore
ln -vis `pwd`/nethackrc ~/.nethackrc
ln -vis `pwd`/screenrc ~/.screenrc
ln -vis `pwd`/inputrc ~/.inputrc
