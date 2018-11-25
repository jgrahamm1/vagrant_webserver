#!/usr/bin/env bash

### Builds the system and makes it ready to be used

mkdir -p ../v_env
cd ../v_env
vagrant init
cp ../Vagrantfile ./Vagrantfile
cp ../bootstrap.sh ./bootstrap.sh
