#! /bin/bash

if (which docker > /dev/null)
then
  local image=ubuntu:20.04
  function docker-bash() {
    docker run --rm -it $image /bin/bash
  }
  function docker-bash-share(){
    docker run -v "$(pwd)":/shared --rm -it $image /bin/bash
  }
  function docker-ip() {
    docker inspect --format "{{ .NetworkSettings.IPAddress }}" "$1"
  }
  function docker-pid() {
    docker inspect --format "{{ .State.Pid }}" "$1"
  }

  alias dip=docker-ip
  alias dpid=docker-pid
  alias dsh=docker-bash
  alias dshs=docker-bash-share
fi

if (which docker-compose > /dev/null)
then
  alias dcp=docker-compose
fi
