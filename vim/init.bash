#! /bin/bash

alias v=vim
function install-vim-plugins(){
  vim "+mkspell ~/.vim/spell/custom.en.utf-8.add" +PluginInstall +qall
}
function update-vim-plugins(){
  vim "+mkspell ~/.vim/spell/custom.en.utf-8.add" +PluginUpdate +qall
}
function edit-vim-plugins(){
  vim ~/.vim/plugins.txt
}

