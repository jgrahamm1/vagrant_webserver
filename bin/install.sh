#!/usr/bin/env bash

### Builds the system and makes it ready to be used

echo "Creating '/v_env' vagrant directory...
mkdir -p ../v_env
cd ../v_env

echo "Calling vagrant init..."
vagrant init

echo "Copying configuration files..."
cp ../Vagrantfile ./Vagrantfile
cp ../bootstrap.sh ./bootstrap.sh

echo "Complete"
