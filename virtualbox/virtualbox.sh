#! /bin/sh

function vbox-list() {
  VBoxManage list $1 | cut -d' ' -f 1 
}

function vbox-list-grep() {
  vbox-list $1 | grep $2
}

function vbox-runningvms() {
  vbox-list runningvms
}

function vbox-poweroff-all() {
  vbox-list runningvms | xargs -i VBoxManage controlvm {} poweroff
}
