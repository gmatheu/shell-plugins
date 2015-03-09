#! /bin/bash

if (which docker > /dev/null)
then
  local image=ubuntu:14.10
  function docker-bash() {
    sudo docker run --rm -it $image /bin/bash
  }
  function docker-bash-share(){
    sudo docker run -v `pwd`:/shared --rm -it $image /bin/bash
  }

  alias docker='sudo docker'
  alias docker-ip='sudo docker inspect --format "{{ .NetworkSettings.IPAddress }}" $1'
  alias docker-pid='sudo docker inspect --format "{{ .State.Pid }}" $1'
  alias docker-enter='sudo nsenter --target `docker-pid $1` -muinpw /bin/bash'
  alias dsh=docker-bash
  alias dshs=docker-bash-share
fi

if (which fig > /dev/null)
then
  alias fig='sudo fig'
fi
