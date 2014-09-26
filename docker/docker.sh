#! /bin/bash

if (which docker > /dev/null)
then
  alias docker='sudo docker'
  alias docker-ip='sudo docker inspect --format "{{ .NetworkSettings.IPAddress }}" $1'
  alias docker-pid='sudo docker inspect --format "{{ .State.Pid }}" $1'
  alias docker-enter='sudo nsenter --target `docker-pid $1` -muinpw /bin/bash'
  alias docker-bash='sudo docker run --rm -it ubuntu/14.04 /bin/bash'
  alias docker-bash-share='sudo docker run -v `pwd`:/shared --rm -it ubuntu/14.04 /bin/bash'
fi

if (which fig > /dev/null)
then
  alias fig='sudo fig'
fi
