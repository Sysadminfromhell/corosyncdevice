
# Corosyncdevice

The project was started and founded due to the restriction with proxmox that a working 2-node cluster needs a witness server which in the case of proxmox is corosync-d also called qnet-d device.

The Image or the dockerfile, if build yourself, creats a debian or ubuntu docker with qnet device working.

## Usage
The Docker can be pulled via Docker-Hub or self build with the Dockerfiles.

Beware that you need all files.

If you build or use it yourself and run the docker with docker run, you need to set the variable "passwd" for the root-User password which is needed in the process to set the qnet-d service. If not set, the password would be "Passw0rd!"

I recommend to use a specific 2nd IP which you assign to your Host so you can still ssh into the host and the docker.

## Commandline and build instructions

### Docker cmd line
decide between debianlatest and ubuntulatest.

Example for debianlatest:
```bash
docker pull safhdev/corosyncdevice:debianlatest

docker run -v ./data/run/sshd:/run/sshd -v ./data/etc/ssh:/etc/ssh -v ./data/etc/corosync:/etc/corosync -p 192.168.178.200 --env passwd=somerootpasswd -d safhdev/corosyncdevice:debianlatest 
```

### Build instructions

```bash
docker buildx build -t safhdev/corosyncdevice:debianlatest -f .\Dockerfile-Debian . --attest type=provenance,mode=max --sbom=true
```

## Contributing

Contributions are always welcome!

See `contributing.md` for ways to get started.
