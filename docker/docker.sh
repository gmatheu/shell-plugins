#! /bin/bash

if (which docker > /dev/null)
then
  local image=ubuntu:14.10
  function docker-bash() {
    sudo docker run --rm -it $image /bin/bash
  }
  function docker-bash-share(){
    sudo docker run -v "$(pwd)":/shared --rm -it $image /bin/bash
  }
  function docker-ip() {
    sudo docker inspect --format "{{ .NetworkSettings.IPAddress }}" "$1"
  }
  function docker-pid() {
    sudo docker inspect --format "{{ .State.Pid }}" "$1"
  }

  alias docker='sudo docker'
  alias dip=docker-ip
  alias dpid=docker-pid
  alias dsh=docker-bash
  alias dshs=docker-bash-share
fi

if (which docker-compose > /dev/null)
then
  alias docker-compose='sudo docker-compose'
  alias dcp=docker-compose
fi
