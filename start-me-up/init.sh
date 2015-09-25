#! /bin/bash

export STU_HOME="`cd $HOME/.start-me-up; pwd`"
alias stu="cd $STU_HOME"
function start-me-update(){
	echo "Updating start-me-up..."
	cd $STU_HOME; sh bootstrap.sh
}
function stu-vagrant(){
  VAGRANT_CWD=$STU_HOME vagrant $@
}
function stu-ssh(){
  stu-vagrant up 
  stu-vagrant ssh
}
function stu-gui(){
  VAGRANT_CWD=$STU_HOME HEADLESS=false vagrant up
}
function stu-halt(){
  stu-vagrant halt
}



