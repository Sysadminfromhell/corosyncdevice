Can be found at [https://hub.docker.com/repository/docker/safhdev/corosyncdevice](https://hub.docker.com/r/safhdev/corosyncdevice)

Is build there and tested on QNAP Docker (Container Station)

Hint: Create volumes before you use the image so the storage is persistent. You can use the image also in a docker-compose which should work with a directory or volumes in the same directory.

Created new Env-Argument for password, if not changed then the default root password is "Passw0rd!".

You can choose between Ubuntu and Debian, both are tested on QNAP and work fine.

A switch is not possible!
