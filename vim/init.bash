#! /bin/bash

alias v=vim
function install-vim-plugins(){
  vim "+mkspell ~/.vim/spell/custom.en.utf-8.add" +PlugInstall +qall
}
function update-vim-plugins(){
  vim "+mkspell ~/.vim/spell/custom.en.utf-8.add" +PlugUpdate +qall
}
function edit-vim-plugins(){
  vim ~/.vim/plugins.txt
}

