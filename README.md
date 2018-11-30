# vagrant_webserver

## Pre-required Software Installs
Vagrant 2.2.1
https://www.vagrantup.com/downloads.html

VirtualBox 5.2.22
https://www.virtualbox.org/wiki/Downloads

Note: Vagrant will download an Ubuntu 14.04 image upon running the install script
https://app.vagrantup.com/ubuntu/boxes/trusty64

## Usage

### 1) Install the environment with Vagrant

```sh
# /bin/install.sh
./install.sh
```

This script creates a new directory `/v_env` and initializes the Vagrant environment there before copying over configuration files.

![install image](img/install.png?raw=true "Install")

### 2) Start the container
```sh
# /bin/start.sh
./start.sh
```

This script starts the Vagrant container. It may take some time to run as it needs causes Vagrant to download the trusty64 image. Finally, it runs the Vagrant shell provisioning script `bootstrap.sh`.

![start image](img/start.png?raw=true "Start")

### 3) Clone the git repository
NOTE: Tearing down and restarting this project may cause an error due to the `known_hosts` file already having an entry for this host. Delete it or use a different IP to fix.

```sh
# /bin/clone.sh
./clone.sh
```

Now that the vagrant container is up and running, we can clone the repository from it, which will be used to add scripts to be run and displayed by the webserver.

![clone image](img/clone.png?raw=true "Clone")


### 4) Push scripts

```sh
# Add a new .sh script to the git repository in /admin
cd ../admin
echo '#!/usr/bin/env bash' > ps.sh && echo 'ps aux' >> ps.sh
chmod +x ps.sh
cd ../bin
./push.sh
```

This adds a short bash script to the git repository before pushing it. More scripts may be added and the output will be appended to the results.

![push image](img/push.png?raw=true "Push")

### 5) Render

One method of rendering is to simply browse to it on the host machine.

![browser image](img/browser.png?raw=true "Browser")

The `render.sh` script can be used to print the results to the command line.

```sh
./render
```

![render image](img/render.png?raw=true "Render")

### 6) Stop and Clean
```sh
# /bin/stop.sh
./stop.sh
```

The `stop.sh` script will halt the current machine, but saves the state and can be resumed with `start.sh`.

```sh
# /bin/clean.sh
./clean.sh
```

The `clean.sh` script will stop the running Vagrant environment and destroy all resources being used.
